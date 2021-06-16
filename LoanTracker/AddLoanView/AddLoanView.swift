//
//  AddLoanView.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI

struct AddLoanView: View {
    
    @ObservedObject var viewModel: AddLoanViewModel

    var body: some View {
        
        VStack {
            HStack (spacing: 10) {
                Button{
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Cancel")
                        .font(.title3)
                }
                
                Spacer()
                
                Button{
                    viewModel.saveLoan()
                    viewModel.isAddLoanShowing.wrappedValue = false
                } label: {
                    Text("Done")
                        .font(.title3)
                        .fontWeight(.semibold)
                }
                .disabled(viewModel.isValidForm())
            }
            .padding()
            
            Form {
                TextField("Name", text: $viewModel.name)
                    .autocapitalization(.sentences)
                
                TextField("Amount", text: $viewModel.amount)
                    .keyboardType(.numberPad)
                
                DatePicker("Start Date", selection:  $viewModel.startDate, displayedComponents: .date)
                DatePicker("Due Date", selection:  $viewModel.dueDate, displayedComponents: .date)
            }
        }
        .onAppear {
            viewModel.setupEditView()
        }
    }
}

