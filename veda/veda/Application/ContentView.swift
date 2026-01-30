//
//  ContentView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

enum SelectedTab: Hashable {
    case main 
    case collection
    case settings
}

struct ContentView: View {
    @State private var selectedTab: SelectedTab = .main
    @State private var previousTab: SelectedTab = .main

    var body: some View {
        ZStack {
            if selectedTab == .main {
                MainView()
            }
            if selectedTab == .collection {
                CollectionsView()
            }
            if selectedTab == .settings {
                SettingsView()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .bottom) { AppTabBar(selectedTab: $selectedTab) }
        .ignoresSafeArea()
        .background(.mainBackground)
        .onChange(of: selectedTab) { oldValue, newValue in
            previousTab = oldValue
        }
    }
}

#Preview {
    ContentView()
}
