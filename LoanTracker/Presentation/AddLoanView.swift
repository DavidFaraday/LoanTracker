//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI

struct AddLoanView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var viewModel: AddLoanViewModel

    @ViewBuilder
    private func saveButton() -> some View {
        Button{
            viewModel.saveLoan()
            dismiss()
        } label: {
            Text("Done")
                .font(.subheadline)
                .fontWeight(.semibold)
        }
        .disabled(viewModel.isValidForm())
    }

    @ViewBuilder
    private func cancelButton() -> some View {
        Button { dismiss() }
        label: {
            Text("Cancel")
                .font(.subheadline)
        }
    }
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Name", text: $viewModel.name)
                        .autocapitalization(.sentences)

                    TextField("Amount", text: $viewModel.amount)
                        .keyboardType(.numberPad)

                    DatePicker("Start Date", selection:  $viewModel.startDate, in: ...Date(), displayedComponents: .date)
                    
                    
                    DatePicker("Due Date",  selection:  $viewModel.dueDate, in: viewModel.startDate..., displayedComponents: .date)
                }
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    cancelButton()
                }
                ToolbarItem(placement: .confirmationAction) {
                    saveButton()
                }
            }
            .onAppear {
                viewModel.setupEditView()
            }
        }
    }
}

