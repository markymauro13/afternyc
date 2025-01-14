//
//  TaxModel.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import Foundation

struct TaxModel {
    static func calculateFederalTax(_ income: Double) -> Double {
        let brackets: [(threshold: Double, rate: Double)] = [
            (0, 0.10),
            (11600, 0.12),
            (47150, 0.22),
            (100525, 0.24),
            (191950, 0.32),
            (243725, 0.35),
            (609350, 0.37)
        ]
        return calculateTaxWithBrackets(income, brackets)
    }

    static func calculateNYStateTax(_ income: Double) -> Double {
        let brackets: [(threshold: Double, rate: Double)] = [
            (0, 0.04),
            (13900, 0.045),
            (21400, 0.0525),
            (80650, 0.0585),
            (215400, 0.0597),
            (1077550, 0.0633),
            (5000000, 0.0685),
            (25000000, 0.0965)
        ]
        return calculateTaxWithBrackets(income, brackets)
    }

    static func calculateNYCTax(_ income: Double) -> Double {
        let brackets: [(threshold: Double, rate: Double)] = [
            (0, 0.03078),
            (12000, 0.03762),
            (25000, 0.03819),
            (50000, 0.03876)
        ]
        return calculateTaxWithBrackets(income, brackets)
    }

    private static func calculateTaxWithBrackets(_ income: Double, _ brackets: [(threshold: Double, rate: Double)]) -> Double {
        var tax = 0.0
        var remainingIncome = income

        for i in 0..<brackets.count {
            let currentThreshold = brackets[i].threshold
            let nextThreshold = i + 1 < brackets.count ? brackets[i + 1].threshold : .infinity
            let rate = brackets[i].rate

            let taxableInThisBracket = min(remainingIncome, nextThreshold - currentThreshold)
            if taxableInThisBracket > 0 {
                tax += taxableInThisBracket * rate
                remainingIncome -= taxableInThisBracket
            }

            if remainingIncome <= 0 {
                break
            }
        }

        return tax
    }
}
