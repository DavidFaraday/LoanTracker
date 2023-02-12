//
//  PaymentView.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI
import CoreData

struct PaymentView: View {
    
    @StateObject private var viewModel = PaymentViewModel()
    var loan: Loan
    
    @ViewBuilder
    private func progressView() -> some View {
        VStack {
            Text("Payment Progress")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.top)

            ProgressBar(progress: viewModel.progress)
                .padding(.horizontal)
            
            Text(viewModel.expectedToFinishOn)
        }
    }
    
    @ViewBuilder
    private func addButton() -> some View {
        NavigationLink(value: Destination.addPayment(loan)) {
            Image(systemName: "plus.circle")
                .font(.title3)
                .padding([.leading, .vertical], 5)
        }
    }
    
    
    var body: some View {
        
        VStack {
            progressView()
            
            Spacer()
            
            List {
                ForEach(viewModel.allPaymentObjects, id: \.sectionName) { paymentObject in

                    Section(header: Text("\(paymentObject.sectionName) - \(paymentObject.sectionTotal, format: .currency(code: "EUR"))")) {

                        ForEach(paymentObject.sectionObjects) { payment in
                            NavigationLink(value: Destination.addPayment(loan, payment)) {
                                PaymentCellView(amount: payment.amount, date: payment.date ?? Date())
                            }
                        }
                        .onDelete { index in
                            viewModel.deleteItem(paymentObject: paymentObject, index: index)
                        }
                    }
                }
            }
            .listStyle(.grouped)
        }
        .navigationTitle(loan.wrappedName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .confirmationAction) {
                addButton()
            }
        }
        .onAppear {
            viewModel.setLoanObject(loan: loan)
            viewModel.calculateProgress()
            viewModel.calculateDays()
            viewModel.separateByYear()
        }
    }

}

