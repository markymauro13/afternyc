//
//  TaxViewModel.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import Foundation

class TaxViewModel: ObservableObject {
    @Published var federalTax: Double = 0.0
    @Published var stateTax: Double = 0.0
    @Published var socialSecurity: Double = 0.0
    @Published var medicare: Double = 0.0
    @Published var stateDisability: Double = 0.0
    @Published var familyLeave: Double = 0.0
    @Published var totalTax: Double = 0.0
    @Published var netIncome: Double = 0.0
    @Published var taxRate: Double = 0.0
    @Published var savingsRate: Double = 0.0

    func calculateTaxes(grossIncome: String) {
        guard let grossIncomeValue = Double(grossIncome) else {
            resetValues()
            return
        }

        federalTax = TaxModel.calculateFederalTax(grossIncomeValue)
        stateTax = TaxModel.calculateNYStateTax(grossIncomeValue)
        let nycTax = TaxModel.calculateNYCTax(grossIncomeValue)

        socialSecurity = min(grossIncomeValue * 0.062, 9932.40)
        medicare = grossIncomeValue * 0.0145
        if grossIncomeValue > 200000 {
            medicare += (grossIncomeValue - 200000) * 0.009
        }

        stateDisability = min(grossIncomeValue * 0.005, 72.00)
        familyLeave = min(grossIncomeValue * 0.00455, 399.43)

        totalTax = federalTax + stateTax + nycTax + socialSecurity + medicare + stateDisability + familyLeave
        netIncome = grossIncomeValue - totalTax
        taxRate = (totalTax / grossIncomeValue) * 100
        savingsRate = 100 - taxRate
    }

    private func resetValues() {
        federalTax = 0
        stateTax = 0
        socialSecurity = 0
        medicare = 0
        stateDisability = 0
        familyLeave = 0
        totalTax = 0
        netIncome = 0
        taxRate = 0
        savingsRate = 0
    }
}
