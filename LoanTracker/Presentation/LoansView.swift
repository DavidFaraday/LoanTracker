//
//  ContentView.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI
import CoreData

struct LoansView: View {
    
    @Environment(\.managedObjectContext) var viewContext

    @State private var isAddLoanShowing = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    
    private var loans: FetchedResults<Loan>
    
    @ViewBuilder
    private func addButton() -> some View {
        Button {
            isAddLoanShowing = true
        } label: {
            Image(systemName: "plus.circle")
                .font(.title3)
        }
        .padding([.vertical, .leading], 5)
    }
    
    
    var body: some View {
        
        NavigationStack {
            List {
                ForEach(loans) { loan in
                    NavigationLink(value: Destination.payment(loan)) {
                        LoanCellView(name: loan.name ?? "",
                                     amount: loan.totalAmount,
                                     date: loan.dueDate ?? Date()
                        )
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("All Loans")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    addButton()
                }
            }
            .sheet(isPresented: $isAddLoanShowing) {
                AddLoanView(viewModel: AddLoanViewModel())
            }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .payment(let loan):
                    PaymentView(loan: loan)
                case .addPayment(let loan, let payment):
                    AddPaymentView(loan: loan, payment: payment)
                case .newView:
                    Text("nothing")
                }
            }
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
}


