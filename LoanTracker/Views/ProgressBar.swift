//
//  ProgressView.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

struct ProgressBar: View {
    
    var value: Double
    var leftAmount: Double
    var paidAmount: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))
                    Text(leftAmount.toCurrency)
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle().frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width), height: geometry.size.height)
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(paidAmount.toCurrency)
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(45.0)
        }
    }
}

