//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {

    @Published private(set) var expectedToFinishOn = ""
    @Published private(set) var progress = Progress()
    @Published private(set) var allPayments: [Payment] = []
    @Published private(set) var allPaymentObjects: [PaymentObject] = []

    private var loan: Loan?
    
    func setLoanObject(loan: Loan) {
        self.loan = loan
        setPayments()
    }
    
    private func setPayments() {
        guard let loan = loan else { return }
        allPayments = loan.paymentArray
    }
    
    func calculateProgress() {
        guard let loan = loan else { return }

        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        let totalLeft = loan.totalAmount - totalPaid
        let value = totalPaid / loan.totalAmount
        
        progress = Progress(value: value, leftAmount: totalLeft, paidAmount: totalPaid)
    }
    
    func calculateDays() {
        guard let loan = loan else { return }

        var paymentStatus = ""
        
        let totalPaid = allPayments.reduce(0) { $0 + $1.amount }
        
        let totalDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: loan.wrappedDueDate).day!
        let passedDays = Calendar.current.dateComponents([.day], from: loan.wrappedStartDate, to: Date()).day!
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }

        let didPayPerDay = totalPaid / Double(passedDays)
        let shouldPayPerDay = loan.totalAmount / Double(totalDays)

        paymentStatus = shouldPayPerDay > didPayPerDay ? "Behind the schedule" : "Ahead of schedule"
        
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPayPerDay

        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())

        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }

        expectedToFinishOn = "Expected to finish by \(newDate.formatted(date: .long, time: .omitted)) \n \(paymentStatus)"
    }
    
    func deleteItem(paymentObject: PaymentObject, index: IndexSet) {
        
        guard let index = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObjects[index]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        
        setPayments()
        withAnimation {
            calculateProgress()
            calculateDays()
        }
        separateByYear()
    }

    
    func separateByYear() {
        allPaymentObjects = []

        let dict = Dictionary(grouping: allPayments, by: { $0.wrappedDate.intOfYear })

        for (key, value) in dict {
            guard let key = key else { return }
            
            let total = value.reduce(0) { $0 + $1.amount }

            allPaymentObjects.append(PaymentObject(sectionName: "\(key)", sectionObjects: value.reversed(), sectionTotal: total))
        }

        allPaymentObjects.sort(by: { $0.sectionName > $1.sectionName })
    }
}
