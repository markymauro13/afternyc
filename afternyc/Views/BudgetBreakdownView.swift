import SwiftUI

struct BudgetBreakdownView: View {
    @ObservedObject var budgetViewModel: BudgetViewModel
    var netIncome: Double
    @State private var showingBudgetInfo = false
    
    var body: some View {
        VStack(spacing: 16) {
            // Financial Insights Section
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
                        Text(Formatters.currency.string(from: NSNumber(value: monthlyNet * 0.3)) ?? "$0")
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
                        Text(Formatters.currency.string(from: NSNumber(value: monthlyNet * 6)) ?? "$0")
                            .bold()
                            .foregroundColor(.green)
                    }
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
            
            // Monthly Budget Breakdown Section
            VStack(alignment: .leading, spacing: 16) {
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
                                        Text("This budgeting method, popularized by Senator Elizabeth Warren, suggests splitting your after-tax income into three main categories:")
                                            .foregroundColor(.secondary)
                                            .padding(.bottom, 8)
                                        
                                        VStack(alignment: .leading, spacing: 16) {
                                            VStack(alignment: .leading, spacing: 8) {
                                                HStack {
                                                    Text("50%")
                                                        .foregroundColor(.purple)
                                                        .bold()
                                                    Text("Living Expenses")
                                                        .foregroundColor(.secondary)
                                                }
                                                Text("Essential expenses like groceries, utilities, transportation, insurance, minimum debt payments, and other daily necessities. These are the must-haves for basic living.")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 8) {
                                                HStack {
                                                    Text("30%")
                                                        .foregroundColor(.blue)
                                                        .bold()
                                                    Text("Housing")
                                                        .foregroundColor(.secondary)
                                                }
                                                Text("Rent or mortgage payments, including related housing costs like maintenance, property taxes, and utilities. In NYC, this might need adjustment due to higher housing costs.")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                            
                                            VStack(alignment: .leading, spacing: 8) {
                                                HStack {
                                                    Text("20%")
                                                        .foregroundColor(.green)
                                                        .bold()
                                                    Text("Savings & Debt")
                                                        .foregroundColor(.secondary)
                                                }
                                                Text("Emergency fund, retirement contributions (401k, IRA), investments, and additional debt payments beyond minimums. This ensures long-term financial security.")
                                                    .font(.subheadline)
                                                    .foregroundColor(.secondary)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    
                                    VStack(alignment: .leading, spacing: 16) {
                                        Text("NYC Considerations")
                                            .font(.headline)
                                            .padding(.top)
                                        
                                        Text("Living in NYC often requires adjusting these percentages due to:")
                                            .foregroundColor(.secondary)
                                        
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text("• Higher housing costs might require increasing the housing allocation")
                                            Text("• Excellent public transportation can reduce transportation expenses")
                                            Text("• Higher cost of living may impact the living expenses category")
                                            Text("• Higher salaries might allow for more savings despite higher costs")
                                        }
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                    }
                                    .padding(.horizontal)
                                    
                                    Text("Note: These percentages are guidelines and can be adjusted based on your specific situation, income level, and NYC neighborhood.")
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
                        .presentationDetents([.medium, .large])
                        .presentationDragIndicator(.visible)
                    }
                    
                    Spacer()
                    
                    // Quick Toggle Menu
                    Menu {
                        Button("50/30/20 (Default)") {
                            budgetViewModel.resetToDefault()
                        }
                        
                        Button("Housing Focus (50/30/20)") {
                            swapPercentages(housing: 50, savings: 30, expenses: 20)
                        }
                        
                        Button("Savings Focus (30/50/20)") {
                            swapPercentages(housing: 30, savings: 50, expenses: 20)
                        }
                        
                        Button("Expenses Focus (30/20/50)") {
                            swapPercentages(housing: 30, savings: 20, expenses: 50)
                        }
                        
                        Button("Equal Split (33/33/34)") {
                            swapPercentages(housing: 33, savings: 33, expenses: 34)
                        }
                    } label: {
                        Image(systemName: "arrow.left.arrow.right")
                            .foregroundColor(.secondary)
                    }
                    
                    Button(action: {
                        budgetViewModel.resetToDefault()
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .foregroundColor(.secondary)
                    }
                }

                // Budget Categories
                BudgetSlider(
                    title: "Housing",
                    percentage: $budgetViewModel.housingPercentage,
                    color: Color.blue,
                    netIncome: netIncome
                )
                
                BudgetSlider(
                    title: "Savings",
                    percentage: $budgetViewModel.savingsPercentage,
                    color: Color.green,
                    netIncome: netIncome
                )
                
                BudgetSlider(
                    title: "Living Expenses",
                    percentage: $budgetViewModel.expensesPercentage,
                    color: Color.purple,
                    netIncome: netIncome
                )

                // Total percentage validation
                HStack {
                    Text("Total: \(Int(budgetViewModel.housingPercentage + budgetViewModel.savingsPercentage + budgetViewModel.expensesPercentage))%")
                        .font(.subheadline)
                        .foregroundColor(
                            budgetViewModel.housingPercentage +
                            budgetViewModel.savingsPercentage +
                            budgetViewModel.expensesPercentage == 100
                            ? .secondary
                            : .red
                        )
                }
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(12)
        }
    }
    
    private func swapPercentages(housing: Double, savings: Double, expenses: Double) {
        budgetViewModel.housingPercentage = housing
        budgetViewModel.savingsPercentage = savings
        budgetViewModel.expensesPercentage = expenses
    }
}
