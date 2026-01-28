//
//  AppTabBar.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

struct AppTabBar: View {
    @Binding var selectedTab: SelectedTab 
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            ZStack {
                Rectangle()
                    .fill(.windowBackground.opacity(0.8))
                    .background(TransparentBlur())
                    .frame(maxWidth: .infinity, maxHeight: 85)
                
                HStack {
                    tabButton(icon: selectedTab == .main ? "house.fill" : "house", title: "Главная", tab: .main)
                    tabButton(icon: selectedTab == .collection ? "menucard.fill" : "menucard", title: "Коллекции", tab: .collection)
                    tabButton(icon: selectedTab == .settings ? "gearshape.fill" : "gearshape", title: "Настройки", tab: .settings)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 20)
            }
        }
    }
    
    @ViewBuilder
    private func tabButton(icon: String, title: String, tab: SelectedTab) -> some View {
        let isSelected = selectedTab == tab
        Button(action: { selectedTab = tab }) {
            VStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 22))
                Text(title)
                    .font(.system(size: 12))
            }
            .frame(maxWidth: .infinity)
            .foregroundStyle(isSelected ? Color.goldText : .secondary)
        }
    }
}

#Preview {
    ContentView()
}
