//
//  PaymentViewModel.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

final class PaymentViewModel: ObservableObject {

    @Published var selectedPayment: Payment?
    @Published var expectedToFinishOn: String = ""
    @Published var isNavigationLinkActive = false
    @Published var allPayments: [Payment] = []
    @Published var allPaymentObjects: [PaymentObject] = []

    var loan: Loan
    
    init(loan: Loan) {
        self.loan = loan
    }
        
    func totalPaid() -> Double {
        return allPayments.reduce(0) { $0 + $1.amount }
    }
    
    func totalLeft() -> Double {
        return self.loan.totalAmount - totalPaid()
    }
    
    func progressValue() -> Double {
        return totalPaid() / loan.totalAmount
    }
    
    func fetchAllPayments() {
        allPayments = PersistenceController.shared.fetchPayments(for: loan.id ?? "")
    }
    

    func deleteItem(paymentObject: PaymentObject, index: IndexSet) {
        
        guard let indexRow = index.first else { return }
        
        let paymentToDelete = paymentObject.sectionObjects[indexRow]
        
        PersistenceController.shared.viewContext.delete(paymentToDelete)
        PersistenceController.shared.save()
        fetchAllPayments()
        calculateDays()
        separateByYear()
    }

    func separateByYear() {
        allPaymentObjects = []

        let dict = Dictionary(grouping: allPayments, by: { $0.date?.dayNumberOfYear })

        for (key, value) in dict {

            var total = 0.0

            for payment in value {
                total += payment.amount
            }

            allPaymentObjects.append(PaymentObject(sectionName: "\(key!)", sectionObjects: value.reversed(), sectionTotal: total))

        }

        allPaymentObjects.sort(by: {$0.sectionName > $1.sectionName})
    }

    func calculateDays() {

        let totalPaid = totalPaid()
        
        let totalDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: loan.dueDate ?? Date()).day!
        let passedDays = Calendar.current.dateComponents([.day], from: loan.startDate ?? Date(), to: Date()).day!
        
        if passedDays == 0 || totalPaid == 0 {
            expectedToFinishOn = ""
            return
        }

        let didPayPerDay = totalPaid / Double(passedDays)
        let shouldPayPerDay = loan.totalAmount / Double(totalDays)

        if shouldPayPerDay < didPayPerDay {
            //we are behind the schedule
        } else {
            //we are ahead of schedule
        }
        
        let daysLeftToFinish = (loan.totalAmount - totalPaid) / didPayPerDay

        let newDate = Calendar.current.date(byAdding: .day, value: Int(daysLeftToFinish), to: Date())

        guard let newDate = newDate else {
            expectedToFinishOn = ""
            return
        }

        expectedToFinishOn = "Expected to finish by \(newDate.longDate)"
    }
}


struct PaymentObject: Equatable {
    var sectionName: String!
    var sectionObjects : [Payment]!
    var sectionTotal: Double!
}
