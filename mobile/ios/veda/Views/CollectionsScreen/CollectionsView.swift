//
//  CollectionsView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

struct CollectionsView: View {
    @Binding var selectedTab: SelectedTab
    
    var headerHeight: CGFloat = 130
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("collection")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(alignment: .top) { header }
            .overlay(alignment: .bottom) { 
                AppTabBar(selectedTab: $selectedTab)
                    .animation(nil, value: selectedTab)
            }
            .ignoresSafeArea()
            .background(.mainBackground)
        }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.header.opacity(0.6))
                    .background(TransparentBlur())
                    .frame(height: headerHeight)
                
                HStack {
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "book.pages")
                            .font(.system(size: 22))
                        
                        VStack(alignment: .leading) {
                            Text("Моя коллекция")
                                .font(.system(size: 20, weight: .bold))
                            
                            Text("34 карточек собрано")
                                .font(.system(size: 13))
                                .foregroundStyle(.secondary)
                        }
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    AppButton(systemImage: "line.3.horizontal.decrease", width: 25, height: 35, style: .clear) {
                        
                    }
                    AppButton(systemImage: "magnifyingglass", width: 25, height: 35, style: .clear) {
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            Divider()
        }
    }
}

#Preview {
    CollectionsView(selectedTab: .constant(.collection))
}
