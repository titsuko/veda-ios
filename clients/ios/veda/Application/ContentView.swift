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

    var body: some View {
        ZStack {
            switch selectedTab {
            case .main:
                MainView(selectedTab: $selectedTab)
                
            case .collection:
                CollectionsView(selectedTab: $selectedTab)
                
            case .settings:
                SettingsView(selectedTab: $selectedTab)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.mainBackground)
    }
}

#Preview {
    ContentView()
        .environmentObject(SignInViewModel())
}
