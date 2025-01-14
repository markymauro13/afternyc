import SwiftUI

struct NewContentView: View {
    @StateObject private var taxViewModel = TaxViewModel()
    @StateObject private var budgetViewModel = BudgetViewModel()
    @State private var grossIncome: String = ""

    var body: some View {
        ZStack {
            // NYC-inspired gradient background
            // Yellow/Orange for taxi cabs, Blue for sky/water, hints of gray for buildings
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.yellow.opacity(0.2),      // Taxi yellow
                    Color.blue.opacity(0.3),        // Hudson River blue
                    Color.gray.opacity(0.2)         // Skyscraper gray
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Modern Header with shadow
                    VStack(spacing: 8) {
                        Text("afternyc")
                            .font(.system(size: 40, weight: .bold, design: .rounded))
                            .foregroundColor(.primary)
                            .shadow(color: .blue.opacity(0.3), radius: 2, x: 0, y: 2)
                        Text("NYC Tax Calculator")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 20)

                    // Floating Income Input Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Enter Your Annual Gross Income")
                            .font(.headline)
                        HStack {
                            Text("$")
                                .font(.title3)
                                .foregroundColor(.secondary)
                            TextField("e.g., 100000", text: $grossIncome)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .font(.title3)
                                .onChange(of: grossIncome) { newValue in
                                    taxViewModel.calculateTaxes(grossIncome: newValue)
                                }
                        }
                    }
                    .padding()
                    .background(Color(UIColor.systemBackground))
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)

                    // White Card Background for remaining content
                    VStack(spacing: 24) {
                        // Tax Breakdown Section
                        TaxBreakdownView(taxViewModel: taxViewModel)

                        // Net Income View
                        NetIncomeView(
                            netIncome: taxViewModel.netIncome,
                            taxRate: taxViewModel.taxRate
                        )

                        // Savings Potential Section
                        SavingsPotentialView(
                            savingsRate: taxViewModel.savingsRate,
                            netIncome: taxViewModel.netIncome
                        )
                        
                        // Tax Bracket View
                        TaxBracketView(grossIncome: Double(grossIncome) ?? 0)

                        // Lifestyle Category View
                        LifestyleCategoryView(netIncome: taxViewModel.netIncome)
                        
                        // Budget Breakdown Section
                        BudgetBreakdownView(
                            budgetViewModel: budgetViewModel,
                            netIncome: taxViewModel.netIncome
                        )
                    }
                    .padding(20)
                    .background(.white)
                    .cornerRadius(16)
                }
                .padding()
            }
        }
    }
}
