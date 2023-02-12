//
//  AddPaymentViewModel.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI

final class AddPaymentViewModel: ObservableObject {
    
    @Published var amount = ""
    @Published var date = Date()
    
    private var payment: Payment?
    private var loan: Loan?

    func setLoanObject(loan: Loan) {
        self.loan = loan
    }
    
    func setPayment(payment: Payment?) {
        self.payment = payment
    }
    
    func savePayment() {
        payment != nil ? updatePayment() : createNewPayment()
    }
    
    private func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loan = loan
        
        PersistenceController.shared.save()
    }
    
    private func updatePayment() {
        guard let payment = payment else { return }
        
        payment.amount = Double(amount) ?? 0.0
        payment.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let payment = payment else { return }

        amount = "\(payment.amount)"
        date = payment.date ?? Date()
    }
    
    func isValidForm() -> Bool {
        amount.isEmpty
    }
}
