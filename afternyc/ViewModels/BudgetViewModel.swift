//
//  BudgetViewModel.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import Foundation

class BudgetViewModel: ObservableObject {
    @Published var housingPercentage: Double = 30.0
    @Published var savingsPercentage: Double = 20.0
    @Published var expensesPercentage: Double = 50.0

    func resetBudget() {
        housingPercentage = 30.0
        savingsPercentage = 20.0
        expensesPercentage = 50.0
    }

    func adjustPercentages(for item: String, total: Double) {
        let currentTotal = housingPercentage + savingsPercentage + expensesPercentage
        if currentTotal != 100 {
            let difference = 100 - currentTotal
            switch item {
            case "Housing":
                savingsPercentage += difference / 2
                expensesPercentage += difference / 2
            case "Savings":
                housingPercentage += difference / 2
                expensesPercentage += difference / 2
            case "Living Expenses":
                housingPercentage += difference / 2
                savingsPercentage += difference / 2
            default:
                break
            }
        }
    }

    func resetToDefault() {
        housingPercentage = 30
        savingsPercentage = 20
        expensesPercentage = 50
    }
}
