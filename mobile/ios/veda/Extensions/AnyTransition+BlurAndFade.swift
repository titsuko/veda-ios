//
//  View+BlurAndFade.swift
//  veda
//
//  Created by Евгений Петрукович on 1/29/26.
//

import SwiftUI

extension AnyTransition {
    static var blurAndFade: AnyTransition {
        .modifier(
            active: BlurFadeModifier(blur: 10, opacity: 0),
            identity: BlurFadeModifier(blur: 0, opacity: 1)
        )
    }
    static var blur: AnyTransition {
        .modifier(
            active: BlurFadeModifier(blur: 5, opacity: 1),
            identity: BlurFadeModifier(blur: 0, opacity: 1)
        )
    }
}

private struct BlurFadeModifier: ViewModifier {
    let blur: CGFloat
    let opacity: Double

    func body(content: Content) -> some View {
        content
            .blur(radius: blur)
            .opacity(opacity)
            .compositingGroup()
    }
}
