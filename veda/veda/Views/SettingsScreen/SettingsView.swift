//
//  SettingsView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

struct SettingsView: View {
    @Binding var selectedTab: SelectedTab
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("collection")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .safeAreaInset(edge: .bottom) { AppTabBar(selectedTab: $selectedTab) }
            .ignoresSafeArea()
            .background(.mainBackground)
        }
    }
}
