import SwiftUI

struct ContentView: View {
    @State private var grossIncome: String = ""
    @State private var federalTax: Double = 0.0
    @State private var stateTax: Double = 0.0
    @State private var socialSecurity: Double = 0.0
    @State private var medicare: Double = 0.0
    @State private var stateDisability: Double = 0.0
    @State private var familyLeave: Double = 0.0
    @State private var totalTax: Double = 0.0
    @State private var netIncome: Double = 0.0
    @State private var taxRate: Double = 0.0
    @State private var savingsRate: Double = 0.0
    @State private var housingPercentage: Double = 30
    @State private var savingsPercentage: Double = 20
    @State private var expensesPercentage: Double = 50
    @State private var showingBudgetInfo = false

    // Add formatters
    private let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter
    }()
    
    private let percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter
    }()

    var body: some View {
        ZStack {
            // Enhanced gradient background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.orange.opacity(0.3),
                    Color.purple.opacity(0.5),
                    Color.orange.opacity(0.25)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    // Modern Header with shadow
                    VStack(spacing: 8) {
                        Text("afternyc")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .shadow(color: .purple.opacity(0.3), radius: 2, x: 0, y: 2)
                        Text("NYC Tax Calculator")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)
                    
                    // Income Input Card with glass effect
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Annual Income")
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack {
                            Text("$")
                                .foregroundColor(.secondary)
                            TextField("Enter your gross income", text: $grossIncome)
                                .keyboardType(.numberPad)
                                .font(.system(.body, design: .rounded))
                        }
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                        )
                    }
                    .padding(20)
                    .background(.white)
                    .cornerRadius(16)
                    
                    // Tax Breakdown Card
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Tax Breakdown")
                            .font(.headline)
                            .padding(.bottom, 8)
                        
                        // Tax Items with alternating backgrounds
                        Group {
                            TaxRow(title: "Federal Tax", amount: federalTax, color: .blue, isAlternate: true)
                            TaxRow(title: "State Tax", amount: stateTax, color: .green, isAlternate: false)
                            TaxRow(title: "Social Security", amount: socialSecurity, color: .orange, isAlternate: true)
                            TaxRow(title: "Medicare", amount: medicare, color: .red, isAlternate: false)
                            TaxRow(title: "State Disability", amount: stateDisability, color: .purple, isAlternate: true)
                            TaxRow(title: "Family Leave", amount: familyLeave, color: .pink, isAlternate: false)
                        }
                        
                        Divider()
                            .padding(.vertical, 8)
                        
                        // Enhanced Summary Section
                        VStack(spacing: 20) {
                            TaxRow(title: "TOTAL TAX", amount: totalTax, color: .primary, isBold: true, isAlternate: false)
                            
                            // Net Income Card
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Net Income")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text(currencyFormatter.string(from: NSNumber(value: netIncome)) ?? "$0")
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(.primary)
                                    Text("\(currencyFormatter.string(from: NSNumber(value: netIncome / 26)) ?? "$0")/biweekly")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Tax Rate")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                    Text(percentFormatter.string(from: NSNumber(value: taxRate / 100)) ?? "0%")
                                        .font(.system(size: 28, weight: .bold, design: .rounded))
                                        .foregroundColor(.red)
                                }
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            
                            // Savings Potential Card with Gradient
                            VStack(spacing: 12) {
                                // Main savings rate display
                                HStack {
                                    Image(systemName: "chart.line.uptrend.xyaxis")
                                        .font(.title2)
                                        .foregroundStyle(.linearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ))
                                    Text("Savings Potential:")
                                        .font(.headline)
                                    Spacer()
                                    Text(percentFormatter.string(from: NSNumber(value: savingsRate / 100)) ?? "0%")
                                        .font(.title3)
                                        .bold()
                                        .foregroundStyle(.linearGradient(
                                            colors: [.blue, .purple],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ))
                                }
                                
                                // Add context based on savings rate
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(getSavingsContext(savingsRate))
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                        .fixedSize(horizontal: false, vertical: true)
                                    
                                    if savingsRate > 0 {
                                        Text("Monthly savings: \(currencyFormatter.string(from: NSNumber(value: netIncome * (savingsRate/100) / 12)) ?? "$0")")
                                            .font(.subheadline)
                                            .foregroundColor(.blue)
                                    }
                                }
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)

                            // Tax Bracket Card with Dynamic Styling
                            HStack {
                                let income = Double(grossIncome) ?? 0
                                Image(systemName: income >= 1000000 ? "crown.fill" : "chart.bar.fill")
                                    .font(.title2)
                                    .foregroundStyle(income >= 1000000 ? 
                                        .linearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing) :
                                        .linearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
                                Text("Tax Bracket:")
                                    .font(.headline)
                                Spacer()
                                Text(getCurrentTaxBracket())
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(income >= 1000000 ? 
                                        .linearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing) :
                                        .linearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)

                            // Lifestyle Category Card (moved here)
                            HStack {
                                Image(systemName: "star.fill")
                                    .font(.title2)
                                    .foregroundStyle(.linearGradient(
                                        colors: [.orange, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                                Text("NYC Lifestyle Category:")
                                    .font(.headline)
                                Spacer()
                                Text(getLifestyleCategory(netIncome))
                                    .font(.title3)
                                    .bold()
                                    .foregroundStyle(.linearGradient(
                                        colors: [.orange, .yellow],
                                        startPoint: .leading,
                                        endPoint: .trailing
                                    ))
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)

                            // Financial Insights Card
                            VStack(spacing: 16) {
                                HStack {
                                    Image(systemName: "chart.bar.doc.horizontal")
                                        .font(.title2)
                                        .foregroundStyle(.linearGradient(
                                            colors: [.blue, .green],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        ))
                                    Text("Financial Insights")
                                        .font(.headline)
                                    Spacer()
                                }
                                .padding(.bottom, 4)
                                
                                VStack(alignment: .leading, spacing: 12) {

                                    
                                    let monthlyNet = netIncome / 12
                                    
                                    // Rent Recommendation (30% rule)
                                    HStack {
                                        Image(systemName: "house.fill")
                                            .foregroundColor(.blue)
                                        Text("Recommended max rent:")
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text(currencyFormatter.string(from: NSNumber(value: monthlyNet * 0.3)) ?? "$0")
                                            .bold()
                                            .foregroundColor(.blue)
                                    }
                                    
                                    // Emergency Fund
                                    HStack {
                                        Image(systemName: "banknote.fill")
                                            .foregroundColor(.green)
                                        Text("Emergency fund target:")
                                            .foregroundColor(.secondary)
                                        Spacer()
                                        Text(currencyFormatter.string(from: NSNumber(value: monthlyNet * 6)) ?? "$0")
                                            .bold()
                                            .foregroundColor(.green)
                                    }
                                    
                                    // Updated Monthly Budget section
                                    VStack(alignment: .leading, spacing: 8) {
                                        HStack {
                                            Image(systemName: "creditcard.fill")
                                                .foregroundColor(.purple)
                                            Text("Monthly Budget Breakdown")
                                                .font(.headline)
                                            
                                            Button(action: {
                                                showingBudgetInfo = true
                                            }) {
                                                Image(systemName: "info.circle")
                                                    .foregroundColor(.secondary)
                                            }
                                            .sheet(isPresented: $showingBudgetInfo) {
                                                ZStack(alignment: .bottom) {
                                                    ScrollView {
                                                        VStack(alignment: .leading, spacing: 20) {
                                                            // Top spacing
                                                            Color.clear
                                                                .frame(height: 20)
                                                            
                                                            Text("50/30/20 Budget Rule")
                                                                .font(.title2)
                                                                .bold()
                                                                .padding(.horizontal)
                                                            
                                                            VStack(alignment: .leading, spacing: 16) {
                                                                Text("This is a popular budgeting method that suggests splitting your after-tax income into three main categories:")
                                                                    .foregroundColor(.secondary)
                                                                
                                                                VStack(alignment: .leading, spacing: 12) {
                                                                    HStack {
                                                                        Text("50%")
                                                                            .foregroundColor(.purple)
                                                                            .bold()
                                                                        Text("Living Expenses")
                                                                            .foregroundColor(.secondary)
                                                                    }
                                                                    Text("Essential expenses like groceries, utilities, transportation, and other necessities.")
                                                                        .font(.subheadline)
                                                                        .foregroundColor(.secondary)
                                                                    
                                                                    HStack {
                                                                        Text("30%")
                                                                            .foregroundColor(.blue)
                                                                            .bold()
                                                                        Text("Housing")
                                                                            .foregroundColor(.secondary)
                                                                    }
                                                                    Text("Rent or mortgage, including related housing costs.")
                                                                        .font(.subheadline)
                                                                        .foregroundColor(.secondary)
                                                                    
                                                                    HStack {
                                                                        Text("20%")
                                                                            .foregroundColor(.green)
                                                                            .bold()
                                                                        Text("Savings")
                                                                            .foregroundColor(.secondary)
                                                                    }
                                                                    Text("Emergency fund, retirement, investments, and debt repayment.")
                                                                        .font(.subheadline)
                                                                        .foregroundColor(.secondary)
                                                                }
                                                            }
                                                            .padding(.horizontal)
                                                            
                                                            Text("Note: These percentages are guidelines and can be adjusted based on your specific situation and NYC living costs.")
                                                                .font(.footnote)
                                                                .foregroundColor(.secondary)
                                                                .padding(.top)
                                                                .padding(.horizontal)
                                                            
                                                            // Bottom spacing for button
                                                            Color.clear
                                                                .frame(height: 80)
                                                        }
                                                    }
                                                    
                                                    // Fixed button at bottom
                                                    VStack {
                                                        Button("Got it") {
                                                            showingBudgetInfo = false
                                                        }
                                                        .frame(maxWidth: .infinity)
                                                        .padding()
                                                        .background(Color.blue)
                                                        .foregroundColor(.white)
                                                        .cornerRadius(12)
                                                        .padding()
                                                    }
                                                    .background(Color(UIColor.systemBackground))
                                                }
                                                .presentationDetents([.medium])
                                                .presentationDragIndicator(.visible)
                                            }
                                            
                                            Spacer()
                                            
                                            Button(action: {
                                                housingPercentage = 30
                                                savingsPercentage = 20
                                                expensesPercentage = 50
                                            }) {
                                                Image(systemName: "arrow.counterclockwise")
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                        .padding(.top, 4)
                                        
                                        let monthlyNet = netIncome / 12
                                        
                                        ForEach([
                                            (title: "Housing", percentage: $housingPercentage, color: Color.blue),
                                            (title: "Savings", percentage: $savingsPercentage, color: Color.green),
                                            (title: "Living Expenses", percentage: $expensesPercentage, color: Color.purple)
                                        ], id: \.title) { item in
                                            VStack(spacing: 4) {
                                                HStack {
                                                    Text(item.title)
                                                        .foregroundColor(.secondary)
                                                    Spacer()
                                                    Text(currencyFormatter.string(from: NSNumber(value: monthlyNet * (item.percentage.wrappedValue / 100))) ?? "$0")
                                                        .bold()
                                                        .foregroundColor(item.color)
                                                    Text("\(Int(item.percentage.wrappedValue))%")
                                                        .font(.subheadline)
                                                        .foregroundColor(.secondary)
                                                        .frame(width: 40, alignment: .trailing)
                                                }
                                                
                                                // Slider for adjusting percentages
                                                Slider(value: item.percentage, in: 0...100, step: 5) { editing in
                                                    if !editing {
                                                        // Ensure total equals 100%
                                                        let total = housingPercentage + savingsPercentage + expensesPercentage
                                                        if total != 100 {
                                                            let difference = 100 - total
                                                            // Distribute difference among other categories
                                                            if item.title == "Housing" {
                                                                savingsPercentage += difference / 2
                                                                expensesPercentage += difference / 2
                                                            } else if item.title == "Savings" {
                                                                housingPercentage += difference / 2
                                                                expensesPercentage += difference / 2
                                                            } else {
                                                                housingPercentage += difference / 2
                                                                savingsPercentage += difference / 2
                                                            }
                                                        }
                                                    }
                                                }
                                                .tint(item.color)
                                            }
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .background(item.color.opacity(0.1))
                                            .cornerRadius(8)
                                        }
                                        
                                        // Total percentage indicator
                                        HStack {
                                            Text("Total:")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                            Spacer()
                                            Text("\(Int(housingPercentage + savingsPercentage + expensesPercentage))%")
                                                .font(.subheadline)
                                                .foregroundColor(housingPercentage + savingsPercentage + expensesPercentage == 100 ? .secondary : .red)
                                        }
                                        .padding(.top, 4)
                                        .padding(.horizontal, 8)
                                    }
                                }
                            }
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                        }
                    }
                    .padding(20)
                    .background(.white)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
        .onChange(of: grossIncome, perform: { _ in calculateTaxes() })
    }

    func calculateTaxes() {
        guard let grossIncomeValue = Double(grossIncome) else { 
            resetValues()
            return 
        }
        
        // Calculate taxes
        self.federalTax = calculateFederalTax(grossIncomeValue)
        self.stateTax = calculateNYStateTax(grossIncomeValue)
        let nycTax = calculateNYCTax(grossIncomeValue)
        
        // FICA calculations
        socialSecurity = min(grossIncomeValue * 0.062, 9932.40)
        medicare = grossIncomeValue * 0.0145
        if grossIncomeValue > 200000 {
            medicare += (grossIncomeValue - 200000) * 0.009
        }
        
        // Fix state disability calculation
        stateDisability = min(grossIncomeValue * 0.005, 72.00)  // Updated max amount for 2024
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

    private func calculateFederalTax(_ income: Double) -> Double {
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

    private func calculateNYStateTax(_ income: Double) -> Double {
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

    private func calculateNYCTax(_ income: Double) -> Double {
        let brackets: [(threshold: Double, rate: Double)] = [
            (0, 0.03078),
            (12000, 0.03762),
            (25000, 0.03819),
            (50000, 0.03876)
        ]
        return calculateTaxWithBrackets(income, brackets)
    }

    private func calculateTaxWithBrackets(_ income: Double, _ brackets: [(threshold: Double, rate: Double)]) -> Double {
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

    private func getCurrentTaxBracket() -> String {
        guard let income = Double(grossIncome) else { return "N/A" }
        
        switch income {
        case 0..<11600:
            return "10% - Starting Out"
        case 11600..<47150:
            return "12% - Entry Level"
        case 47150..<100525:
            return "22% - Mid Career"
        case 100525..<191950:
            return "24% - Professional"
        case 191950..<243725:
            return "32% - Senior Level"
        case 243725..<609350:
            return "35% - Executive"
        case 609350..<1000000:
            return "37% - C-Suite"
        case 1000000..<5000000:
            return "37% - The 1%"
        case 5000000...:
            return "37% - Whale Status 🐋"
        default:
            return "N/A"
        }
    }

    private func getLifestyleCategory(_ annualIncome: Double) -> String {
        let monthly = annualIncome / 12
        switch monthly {
        case 0..<3000:
            return "Budget Living"
        case 3000..<5000:
            return "Modest Living"
        case 5000..<8000:
            return "Comfortable"
        case 8000..<12000:
            return "Upper Middle"
        case 12000..<20000:
            return "Luxury"
        default:
            return "Ultra Luxury"
        }
    }

    private func getSavingsContext(_ rate: Double) -> String {
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
}

struct TaxRow: View {
    let title: String
    let amount: Double
    let color: Color
    var isBold: Bool = false
    let isAlternate: Bool
    
    var gradientColors: [Color] {
        switch color {
        case .blue:
            return [.blue, .blue.opacity(0.7), Color(hex: "60A5FA")]
        case .green:
            return [.green, .green.opacity(0.7), Color(hex: "34D399")]
        case .orange:
            return [.orange, .orange.opacity(0.7), Color(hex: "FBBF24")]
        case .red:
            return [.red, .red.opacity(0.7), Color(hex: "F87171")]
        case .purple:
            return [.purple, .purple.opacity(0.7), Color(hex: "A78BFA")]
        case .pink:
            return [.pink, .pink.opacity(0.7), Color(hex: "F472B6")]
        default:
            return [.primary, .primary.opacity(0.7), .primary.opacity(0.5)]
        }
    }
    
    var formattedAmount: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: amount)) ?? "$0"
    }
    
    var body: some View {
        HStack {
            Text(title)
                .font(isBold ? .headline : .body)
            Spacer()
            Text(formattedAmount)
                .font(isBold ? .headline : .body)
                .foregroundStyle(
                    .linearGradient(
                        colors: gradientColors,
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .fontWeight(.semibold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 6)
        .background(isAlternate ? Color.gray.opacity(0.1) : Color.clear)
        .cornerRadius(6)
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
