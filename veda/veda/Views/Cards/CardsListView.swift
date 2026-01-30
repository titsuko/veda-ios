//
//  CardsListView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct CardsListView: View {
    let category: CardCategory
    
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        ScrollView {
            VStack {
                Text("primer")
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Закрыть") {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CardsListView(
        category: CardCategory(
            title: "Праздники",
            description: "",
            quantity: 2,
            color: .orange,
            image: "sun.min",
            items: [CardItem(title: "Огонь как очищение", description: "Primer")]
        )
    )
}
