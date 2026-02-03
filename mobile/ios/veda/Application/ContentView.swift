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
    @EnvironmentObject var session: SessionManager
    @EnvironmentObject var signInViewModel: SignInViewModel
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    
    @State private var selectedTab: SelectedTab = .main
    @State private var previousTab: SelectedTab = .main

    var body: some View {
        ZStack {
            switch selectedTab {
            case .main:
                MainView(selectedTab: $selectedTab)
            case .collection:
                CollectionsView(selectedTab: $selectedTab)
            case .settings:
                SettingsView(selectedTab: $selectedTab)
                    .environmentObject(signInViewModel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.mainBackground)
        .onChange(of: selectedTab) { newValue in
            previousTab = selectedTab
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(SignInViewModel())
}
