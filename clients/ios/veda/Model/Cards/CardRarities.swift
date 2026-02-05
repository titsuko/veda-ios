//
//  CardRarities.swift
//  veda
//
//  Created by Евгений Петрукович on 2/1/26.
//

import SwiftUI

enum Rarities: String, CaseIterable, Identifiable {
    case common
    case rare
    case epic
    case legendary
    
    var id: Self { self }
    
    var color: Color {
        switch self {
        case .common:
            return .green
        case .rare:
            return .blue
        case .epic:
            return .purple
        case .legendary:
            return .orange
        }
    }
    
    var name: String {
        switch self {
        case .common:
            return "Базовая"
        case .rare:
            return "Редкая"
        case .epic:
            return "Эпическая"
        case .legendary:
            return "Легендарная"
        }
    }
}
