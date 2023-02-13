//
//  AddPaymentView.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI

struct AddPaymentView: View {
    
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel = AddPaymentViewModel()
    
    var loan: Loan
    var payment: Payment?
    
    @ViewBuilder
    private func saveButton() -> some View {
        Button{
            viewModel.savePayment()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isValidForm())
    }

    
    var body: some View {
        Form {
            Section {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Date", selection:  $viewModel.date, displayedComponents: .date)
            }
        }
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                saveButton()
            }
        }
        .onAppear() {
            viewModel.setLoanObject(loan: loan)
            viewModel.setPayment(payment: payment)
            viewModel.setupEditView()
        }
        .navigationTitle(payment != nil ? "Edit Payment" : "Add Payment")
    }
}

