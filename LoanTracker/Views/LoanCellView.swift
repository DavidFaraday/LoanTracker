//
//  LoanCellView.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

struct LoanCellView: View {
    
    var name: String
    var amount: Double
    var date: Date
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Text(amount.toCurrency)
                    .font(.title2)
                    .fontWeight(.light)
            }
            
            Spacer()
            
            Text(date.longDate)
                .font(.subheadline)
                .foregroundColor(.secondary)

        }            
    }
}

struct LoanCellView_Previews: PreviewProvider {
    static var previews: some View {
        LoanCellView(name: "Test Name", amount: 10000, date: Date())
    }
}
