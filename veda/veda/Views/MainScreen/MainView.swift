//
//  HomeView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

struct MainView: View {
    @State private var searchText: String = ""
    @State private var searchFocused = false
    @State private var showSearchBar: Bool = false
    @Binding var selectedTab: SelectedTab
    
    let categories = CardCategory.mockCategories
    
    var headerHeight: CGFloat = 130
    var tabBarHeight: CGFloat = 85
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                cardsView
                    .padding(.top, headerHeight)
                    .padding(.bottom, tabBarHeight)
            }
            .overlay(alignment: .top) { header }
            .overlay(alignment: .bottom) { AppTabBar(selectedTab: $selectedTab) }
            .ignoresSafeArea()
            .background(.mainBackground)
        }
        .animation(.spring(duration: 0.35), value: showSearchBar)
        .onTapGesture { hideKeyboard() }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.header.opacity(0.6))
                    .background(TransparentBlur())
                    .frame(height: headerHeight)
                
                ZStack {
                    if showSearchBar {
                        searchHeader
                            .transition(.blurAndFade)
                    } else {
                        normalHeader
                            .transition(.blurAndFade)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private var normalHeader: some View {
        HStack {
            HStack {
                Image(systemName: "books.vertical")
                Text("Разделы")
                    .bold()
            }
            .font(.system(size: 22))
            .padding(.top, 10)
            
            Spacer()
            AppButton(systemImage: "square.grid.2x2", width: 25, height: 35, style: .clear) {
                
            }
            AppButton(systemImage: "magnifyingglass", width: 25, height: 35, style: .clear) {
                showSearchBar = true
                searchFocused = true
            }
        }
    }
    
    @ViewBuilder
    private var searchHeader: some View {
        HStack(spacing: 0) {
            AppSearchBar(title: "Поиск по разделу", height: 45, isFocused: $searchFocused, searchText: $searchText)
            Spacer()
            AppButton(systemImage: "xmark", width: 25, height: 35, style: .clear) {
                showSearchBar = false
                searchFocused = false
                searchText = ""
            }
        }
    }
    
    @ViewBuilder
    private var cardsView: some View {
        VStack(spacing: 0) {
            ForEach(categories.indices, id: \.self) { index in
                let category = categories[index]
                VStack(spacing: 0) {
                    if index == 0 { Divider() }
                    NavigationLink(destination: CardsListView(category: category)) {
                        SectionsView(
                            title: category.title,
                            description: category.description,
                            quantity: category.quantity,
                            color: category.color,
                            image: category.image
                        )
                    }
                    .buttonStyle(ButtonPressStyle())
                    
                    Divider()
                }
                .foregroundStyle(.primary)
            }
        }
    }
}

#Preview {
    ContentView()
}
