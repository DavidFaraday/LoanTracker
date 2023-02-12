//
//  Payment+CoreDataProperties.swift
//  LoanTracker
//
//  Created by David Kababyan on 30/10/2022.
//
//

import Foundation
import CoreData


extension Payment {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Payment> {
        return NSFetchRequest<Payment>(entityName: "Payment")
    }

    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: String?
    @NSManaged public var isRecurring: Bool
    @NSManaged public var loanId: String?
    @NSManaged public var loan: Loan?

    public var wrappedDate: Date {
        date ?? Date()
    }

}

extension Payment : Identifiable {

}
