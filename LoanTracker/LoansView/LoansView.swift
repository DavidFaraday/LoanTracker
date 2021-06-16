//
//  ContentView.swift
//  LoanTracker
//
//  Created by David Kababyan on 04/06/2021.
//

import SwiftUI
import CoreData

struct LoansView: View {
    
    @StateObject var viewModel = LoansViewModel()
    
    @Environment(\.managedObjectContext) var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Loan.startDate, ascending: true)],
        animation: .default)
    
    private var loans: FetchedResults<Loan>
    
    
    var body: some View {
        NavigationView {
            
            List {
                ForEach(loans) { loan in
                    NavigationLink(destination: PaymentView(viewModel: PaymentViewModel(loan: loan))){
                        LoanCellView(name: loan.name ?? "Unknown", amount: loan.totalAmount, date: loan.dueDate ?? Date())
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .listStyle(PlainListStyle())
            .navigationTitle("All Loans")
            .navigationBarItems(trailing:
            
            Button {
                viewModel.isAddLoanShowing = true
            } label: {
                Image(systemName: "plus")
                    .font(.title)
            })
        }
        .accentColor(Color(.label))
        .sheet(isPresented: $viewModel.isAddLoanShowing) {
            AddLoanView(viewModel: AddLoanViewModel(loanToEdit: viewModel.selectedLoan, isAddLoanShowing: $viewModel.isAddLoanShowing))
        }
    }
    
    func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { loans[$0] }.forEach(viewContext.delete)
            PersistenceController.shared.save()
        }
    }
}


