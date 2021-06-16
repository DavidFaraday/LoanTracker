//
//  Date+Ext.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import Foundation


extension Date {  
    var dayNumberOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }

    var longDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: self)
    }
}


