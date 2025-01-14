//
//  BudgetModel.swift
//  afternyc
//
//  Created by Mark Mauro on 1/9/25.
//


import Foundation

struct BudgetModel {
    static func getSavingsContext(rate: Double, grossIncome: Double) -> String {
        // Return contextual information based on savings rate
        let annualIncome = Double(grossIncome) ?? 0
                
                // Low Income (Under $40k)
                if annualIncome < 40000 {
                    switch rate {
                    case ..<0:
                        return "Living in NYC on this income is challenging. Consider exploring rental assistance programs and income-based benefits."
                    case 0..<10:
                        return "Focus on essential expenses and look into NYC affordable housing programs. Every dollar saved counts at this income level."
                    case 10..<20:
                        return "You're doing well managing your budget at this income level. Consider building an emergency fund first before other savings goals."
                    default:
                        return "Impressive savings at this income level! Look into NYC rent stabilized apartments and continue building your emergency fund."
                    }
                }
                
                // Moderate Income ($40k-$80k)
                else if annualIncome < 80000 {
                    switch rate {
                    case ..<0:
                        return "Consider roommates or outer borough living to reduce expenses. Your income has potential for savings with adjusted living costs."
                    case 0..<10:
                        return "This is a workable income in NYC, but try to increase savings. Look for opportunities to reduce high-cost expenses like rent."
                    case 10..<20:
                        return "You're at the typical NYC savings rate. Focus on building both emergency and retirement funds at this income level."
                    default:
                        return "Great job! At this income, consider maximizing your 401(k) if available and look into index fund investing."
                    }
                }
                
                // Good Income ($80k-$150k)
                else if annualIncome < 150000 {
                    switch rate {
                    case ..<0:
                        return "With this solid income, review your NYC lifestyle costs. You have good potential for savings with some adjustments."
                    case 0..<10:
                        return "Your income supports comfortable NYC living. Aim to increase savings through tax-advantaged retirement accounts."
                    case 10..<20:
                        return "You're on track. Consider diversifying savings into retirement accounts and potentially real estate investment."
                    default:
                        return "Excellent savings rate! Look into maximizing all tax-advantaged accounts and consider consulting a financial advisor."
                    }
                }
                
                // High Income ($150k+)
                else {
                    switch rate {
                    case ..<0:
                        return "Review luxury expenses and housing costs. Your income provides significant savings potential with lifestyle optimization."
                    case 0..<10:
                        return "Consider tax optimization strategies. At this income level, you have strong potential for wealth building through savings."
                    case 10..<20:
                        return "Good start. Look into tax-efficient investment strategies and consider consulting a financial advisor for wealth management."
                    default:
                        return "Outstanding! Consider advanced tax strategies, investment diversification, and estate planning at this income level."
                    }
                }
    }

    static func getLifestyleCategory(netIncome: Double) -> String {
        let monthly = netIncome / 12
        switch monthly {
        case 0..<3000: return "Budget Living"
        case 3000..<5000: return "Modest Living"
        case 5000..<8000: return "Comfortable"
        case 8000..<12000: return "Upper Middle"
        case 12000..<20000: return "Luxury"
        default: return "Ultra Luxury"
        }
    }
}
