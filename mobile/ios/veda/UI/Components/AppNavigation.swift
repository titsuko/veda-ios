//
//  AppNavigation.swift
//  veda
//
//  Created by Евгений Петрукович on 2/3/26.
//

import SwiftUI

struct AppNavigation<Content: View>: View {
    @ViewBuilder let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                content
            }
        } else {
            NavigationView {
                content
            }
            .navigationViewStyle(.stack)
        }
    }
}
