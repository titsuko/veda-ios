//
//  CardItem.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct CardItem: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let rarity: Rarities
}
