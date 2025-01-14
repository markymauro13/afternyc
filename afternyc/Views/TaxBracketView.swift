import SwiftUI

struct TaxBracketView: View {
    var grossIncome: Double
    
    var body: some View {
        HStack {
            Image(systemName: grossIncome >= 1000000 ? "crown.fill" : "chart.bar.fill")
                .font(.title2)
                .foregroundStyle(grossIncome >= 1000000 ? 
                    .linearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing) :
                    .linearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
            Text("Tax Bracket:")
                .font(.headline)
            Spacer()
            Text(getCurrentTaxBracket())
                .font(.title3)
                .bold()
                .foregroundStyle(grossIncome >= 1000000 ? 
                    .linearGradient(colors: [.yellow, .orange], startPoint: .leading, endPoint: .trailing) :
                    .linearGradient(colors: [.purple, .pink], startPoint: .leading, endPoint: .trailing))
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
    
    private func getCurrentTaxBracket() -> String {
        switch grossIncome {
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
} 
