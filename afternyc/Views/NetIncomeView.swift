import SwiftUI

struct NetIncomeView: View {
    var netIncome: Double
    var taxRate: Double
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Net Income")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(Formatters.currency.string(from: NSNumber(value: netIncome)) ?? "$0")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)
                Text("\(Formatters.currency.string(from: NSNumber(value: netIncome / 26)) ?? "$0")/biweekly")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("Tax Rate")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text(Formatters.percent.string(from: NSNumber(value: taxRate / 100)) ?? "0%")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
    }
} 