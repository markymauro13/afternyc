//
//  TaxBreakdownView.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import SwiftUI

struct TaxBreakdownView: View {
    @ObservedObject var taxViewModel: TaxViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tax Breakdown")
                .font(.headline)
            
            TaxRow(title: "Federal Tax", amount: taxViewModel.federalTax, color: .blue, isAlternate: true)
            TaxRow(title: "State Tax", amount: taxViewModel.stateTax, color: .green, isAlternate: false)
            TaxRow(title: "Social Security", amount: taxViewModel.socialSecurity, color: .orange, isAlternate: true)
            TaxRow(title: "Medicare", amount: taxViewModel.medicare, color: .red, isAlternate: false)
            TaxRow(title: "State Disability", amount: taxViewModel.stateDisability, color: .purple,  isAlternate: true)
            TaxRow(title: "Family Leave", amount: taxViewModel.familyLeave, color: .pink, isAlternate: false)
            
            Divider()
            
            TaxRow(title: "Total Tax", amount: taxViewModel.totalTax, color: .primary, isBold: true, isAlternate: false)
        }
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}
