import SwiftUI

struct LifestyleCategoryView: View {
    var netIncome: Double
    
    var body: some View {
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
            Text(getLifestyleCategory())
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
    }
    
    private func getLifestyleCategory() -> String {
        let monthly = netIncome / 12
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
} 
