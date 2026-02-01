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
            // AuthView()
            if selectedTab == .main {
                MainView(selectedTab: $selectedTab)
            }
            if selectedTab == .collection {
                CollectionsView(selectedTab: $selectedTab)
            }
            if selectedTab == .settings {
                SettingsView(selectedTab: $selectedTab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
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
