import SwiftUI
import Foundation


struct WeekCardView: View {
    let title: String
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 12).foregroundColor(.red)
            Text(title)
                .font(.title2)
        }
        
    }
}

struct WeekCard: Identifiable {
    let id = UUID()
    let title: String
}

struct RowView: View {
    let cards: [WeekCard]
    let width: CGFloat
    let height: CGFloat
    let horizontalSpacing: CGFloat
    var body: some View {
        HStack(spacing: horizontalSpacing) {
            ForEach(cards) { card in
                WeekCardView(title: card.title)
                    .frame(width: width, height: height)
            }
        }
        .padding()
    }
}


struct MockStore {
    static var cards = [
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
        WeekCard(title: "Italy"),
    ]
}

