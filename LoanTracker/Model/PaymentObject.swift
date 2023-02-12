//
//  PaymentObject.swift
//  LoanTracker
//
//  Created by David Kababyan on 12/02/2023.
//

import Foundation

struct PaymentObject: Equatable {
    var sectionName: String
    var sectionObjects: [Payment]
    var sectionTotal: Double
}
