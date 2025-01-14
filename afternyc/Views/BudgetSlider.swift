//
//  BudgetSlider.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import SwiftUI

struct BudgetSlider: View {
    let title: String
    @Binding var percentage: Double
    let color: Color
    var netIncome: Double
    
    private var monthlyIncome: Double {
        netIncome / 12
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Text(title)
                    .foregroundColor(.secondary)
                Spacer()
                Text(Formatters.currency.string(from: NSNumber(value: monthlyIncome * (percentage / 100))) ?? "$0")
                    .bold()
                    .foregroundColor(color)
                Text("\(Int(percentage))%")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .frame(width: 40, alignment: .trailing)
            }
            
            Slider(value: $percentage, in: 0...100, step: 5)
                .tint(color)
        }
        .padding(.vertical, 4)
        .padding(.horizontal, 8)
        .background(color.opacity(0.1))
        .cornerRadius(8)
    }
}
