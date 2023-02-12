//
//  Date+Ext.swift
//  LoanTracker
//
//  Created by David Kababyan on 05/06/2021.
//

import Foundation


extension Date {  
    var intOfYear: Int? {
        return Calendar.current.dateComponents([.year], from: self).year
    }
}


