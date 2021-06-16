//
//  AddPaymentView.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI

struct AddPaymentView: View {
    
    @ObservedObject var viewModel: AddPaymentViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        
        Form {
            Section {
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Date", selection:  $viewModel.date, displayedComponents: .date)
            }

            Section {
                Button{
                    viewModel.savePayment()
                    self.mode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .disabled(viewModel.isValidForm())
        }
        .onAppear() {
            viewModel.setupEditView()
        }
        .navigationTitle(viewModel.payment != nil ? "Edit Payment" : "Add Payment")
    }
}

