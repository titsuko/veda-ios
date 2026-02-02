//
//  CardCategory.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct CardCategory: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let description: String
    let quantity: Int
    let color: Color
    let image: String
    let items: [CardItem]
    
    static func == (lhs: CardCategory, rhs: CardCategory) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

