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
    @Published var loanToEdit: Loan?
    var isAddLoanShowing: Binding<Bool>

    init(loanToEdit: Loan?, isAddLoanShowing: Binding<Bool>) {
        self.loanToEdit = loanToEdit
        self.isAddLoanShowing = isAddLoanShowing
    }
    
    func saveLoan() {
        if loanToEdit != nil {
            updateLoan()
        } else {
            createNewLoan()
        }
    }
    
    func createNewLoan() {
        let newLoan = Loan(context: PersistenceController.shared.viewContext)
        newLoan.id = UUID().uuidString
        newLoan.name = name
        newLoan.totalAmount = Double(amount) ?? 0.0
        newLoan.startDate = startDate
        newLoan.dueDate = dueDate

        PersistenceController.shared.save()
    }
    
    func updateLoan() {
        loanToEdit!.name = name
        loanToEdit!.totalAmount = Double(amount) ?? 0.0
        loanToEdit!.startDate = startDate
        loanToEdit!.dueDate = dueDate
        
        PersistenceController.shared.save()
    }
    
    func setupEditView() {
        if loanToEdit != nil {
            name = loanToEdit!.name ?? ""
            amount = "\(loanToEdit!.totalAmount)"
            startDate = loanToEdit!.startDate ?? Date()
            dueDate = loanToEdit!.dueDate ?? Date()
        }
    }
    
    func isValidForm() -> Bool {
        return name.isEmpty || amount.isEmpty
    }
}
