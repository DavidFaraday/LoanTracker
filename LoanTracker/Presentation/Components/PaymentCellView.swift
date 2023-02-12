//
//  PaymentCellView.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

struct PaymentCellView: View {
    
    var amount: Double
    var date: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(amount, format: .currency(code: "EUR"))
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(date.formatted(date: .abbreviated, time: .omitted))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

struct PaymentCellView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCellView(amount: 400.0, date: Date())
    }
}
