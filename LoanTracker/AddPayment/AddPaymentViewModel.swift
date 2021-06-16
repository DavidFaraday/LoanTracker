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
    @Published var payment: Payment?

    var loanId: String

    init(paymentToEdit payment: Payment?, loanId: String) {
        self.payment = payment
        self.loanId = loanId
    }
    
    func savePayment() {
        if payment != nil {
            updatePayment()
        } else {
            createNewPayment()
        }
    }
    
    func createNewPayment() {
        let newPayment = Payment(context: PersistenceController.shared.viewContext)
        newPayment.id = UUID().uuidString
        newPayment.amount = Double(amount) ?? 0.0
        newPayment.date = date
        newPayment.loanId = loanId
        
        PersistenceController.shared.save()
    }
    
    func updatePayment() {
        payment!.amount = Double(amount) ?? 0.0
        payment!.date = date
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        if payment != nil {
            amount = "\(payment!.amount)"
            date = payment!.date ?? Date()
        }
    }
    
    func isValidForm() -> Bool {
        return amount.isEmpty
    }
}
