//
//  LoansViewModel.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import SwiftUI


final class LoansViewModel: ObservableObject {
    
    @Published var isAddLoanShowing = false
    var selectedLoan: Loan?
}
