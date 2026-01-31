//
//  CardPressStyle.swift
//  veda
//
//  Created by Евгений Петрукович on 1/30/26.
//

import SwiftUI

struct ButtonPressStyle: ButtonStyle {
    @Environment(\.colorScheme) private var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(
                Group {
                    if configuration.isPressed {
                        colorScheme == .dark ? Color.black.opacity(0.3) : Color.black.opacity(0.1)
                        
                    } else {
                        Color.clear
                    }
                }
            )
    }
}

#Preview {
    ContentView()
}
