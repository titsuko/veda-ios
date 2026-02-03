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
    
    var filteredCategories: [CardCategory] {
        if searchText.isEmpty {
            return categories
        } else {
            return categories.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if filteredCategories.isEmpty {
                    emptySearchView
                } else {
                    ScrollView(showsIndicators: false) {
                        sectionsView
                            .padding(.top, headerHeight)
                            .padding(.bottom, tabBarHeight)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
            AppButton(systemImage: "line.3.horizontal.decrease", width: 25, height: 35, style: .clear) {
                
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
    private var sectionsView: some View {
        NavigationList(items: filteredCategories) { category in
            SectionsView(
                title: category.title,
                description: category.description,
                quantity: category.quantity,
                color: category.color,
                image: category.image
            )
        } destination: { category in
            CardsListView(categories: category)
        }
    }
    
    @ViewBuilder
    private var emptySearchView: some View {
        VStack {
            Image(systemName: "books.vertical.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .foregroundColor(.secondary)
            
            Text("Нет разделов")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.secondary)
        }
    }
}

private struct SectionsView: View {
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    let title: String
    let description: String
    let quantity: Int
    let color: Color
    let image: String
    
    var body: some View {
        HStack(spacing: 15) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(color.gradient)
                    .frame(width: 60, height: 60)
                
                Image(systemName: image)
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            }
            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
                
                Text(description)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            Spacer()
            
            Text("\(quantity) карточек")
                .font(.system(size: 12, weight: .bold))
                .foregroundStyle(color.gradient)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(colorScheme == .dark ? color.gradient.opacity(0.1) : color.gradient.opacity(0.2))
                )
                .overlay(
                    Capsule()
                        .stroke(color.opacity(0.4), lineWidth: 1)
                )
        }
        .padding(10)
    }
}

#Preview {
    ContentView()
}
