//
//  AddLoanViewModel.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI

final class AddLoanViewModel: ObservableObject {

    @Published var name = ""
    @Published var amount = ""
    @Published var startDate = Date()
    @Published var dueDate = Date()
    
    private var loanToEdit: Loan?

    init(loanToEdit: Loan? = nil) {
        self.loanToEdit = loanToEdit
    }
        
    func saveLoan() {
        loanToEdit != nil ? updateLoan() : createNewLoan()
    }
    
    private func createNewLoan() {
        let loan = Loan(context: PersistenceController.shared.viewContext)
        loan.id = UUID().uuidString
        loan.name = name
        loan.totalAmount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate

        PersistenceController.shared.save()
    }
    
    private func updateLoan() {
        guard let loan = loanToEdit else { return }

        loan.name = name
        loan.totalAmount = Double(amount) ?? 0.0
        loan.startDate = startDate
        loan.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        guard let loan = loanToEdit else { return }
        
        name = loan.wrappedName
        amount = "\(loan.totalAmount)"
        startDate = loan.wrappedStartDate
        dueDate = loan.wrappedDueDate
    }

    func isValidForm() -> Bool {
        name.isEmpty || amount.isEmpty
    }
}
