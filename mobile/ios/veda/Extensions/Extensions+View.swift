//
//  Extensions+View.swift
//  veda
//
//  Created by Евгений Петрукович on 2/3/26.
//

import SwiftUI

extension View {
    @ViewBuilder
    func gradientForeground(_ color: Color) -> some View {
        if #available(iOS 17.0, *) {
            self.foregroundStyle(color.gradient)
        } else {
            self.foregroundColor(color)
        }
    }
}
