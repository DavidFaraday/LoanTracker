//
//  Destination.swift
//  LoanTracker
//
//  Created by David Kababyan on 12/02/2023.
//

import Foundation

enum Destination: Hashable {
    case payment(Loan)
    case addPayment(Loan, Payment? = nil)
}
