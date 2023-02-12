//
//  ProgressView.swift
//  LoanTracker
//
//  Created by David Kababyan on 06/06/2021.
//

import SwiftUI

struct ProgressBar: View {
    
    private let progress: Progress
    private let barHeight: CGFloat
    
    init(progress: Progress, barHeight: CGFloat = 20.0) {
        self.progress = progress
        self.barHeight = barHeight
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                ZStack(alignment: .trailing) {
                    Rectangle()
                        .frame(width: geometry.size.width,
                               height: geometry.size.height
                        )
                        .opacity(0.3)
                        .foregroundColor(Color(UIColor.systemTeal))

                    Text(progress.leftAmount, format: .currency(code: "EUR"))
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.horizontal)
                }
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(width: min(CGFloat(progress.value) * geometry.size.width, geometry.size.width),
                               height: geometry.size.height
                        )
                        .foregroundColor(Color(UIColor.systemBlue))
                    
                    Text(progress.paidAmount, format: .currency(code: "EUR"))
                        .font(.caption)
                        .padding(.horizontal)
                }
            }
            .cornerRadius(45.0)
        }
        .frame(height: barHeight)
    }
}


struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {

        ProgressBar(progress: Progress(value: 20, leftAmount: 10, paidAmount: 5))
    }
}


