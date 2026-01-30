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
    @State private var selectedCategory: CardCategory?
        
    var headerHeight: CGFloat = 130
    
    let categories: [CardCategory] = [
        CardCategory(
            title: "Праздники",
            description: "Традиционные торжества и их смысл",
            quantity: 4,
            color: .orange,
            image: "sun.min",
            items: [
                CardItem(title: "Коляда", description: "Зимний праздник"),
                CardItem(title: "Купала", description: "Летний обряд")
            ]
        ),
        CardCategory(
            title: "Символы",
            description: "Знаки и их значения",
            quantity: 3,
            color: .green,
            image: "wand.and.sparkles",
            items: [
                CardItem(title: "Солнце", description: "Источник жизни"),
                CardItem(title: "Древо", description: "Связь миров")
            ]
        ),
        CardCategory(
            title: "Обряды",
            description: "Ритуалы и священные практики",
            quantity: 2,
            color: .red,
            image: "flame",
            items: [
                CardItem(title: "Солнце", description: "Источник жизни"),
                CardItem(title: "Древо", description: "Связь миров")
            ]
        ),
        CardCategory(
            title: "Персонажи",
            description: "Мифологические образы и герои",
            quantity: 3,
            color: .purple,
            image: "person",
            items: [
                CardItem(title: "Солнце", description: "Источник жизни"),
                CardItem(title: "Древо", description: "Связь миров")
            ]
        )
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                cardsView
                    .padding(.top, headerHeight)
            }
            .overlay(alignment: .top) { header }
            .ignoresSafeArea()
            .background(.mainBackground)
        }
        .animation(.spring(duration: 0.35), value: showSearchBar)
        .onTapGesture { hideKeyboard() }
        .sheet(item: $selectedCategory) { category in
            NavigationStack {
                CardsListView(category: category)
            }
        }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.header.opacity(0.4))
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
                Image(systemName: "house.fill")
                Text("Главная")
                    .bold()
            }
            .font(.system(size: 22))
            .padding(.top, 10)
            
            Spacer()
            AppButtonClear(title: "", image: "square.grid.2x2", width: 25, height: 35, action: {
                
            })
            AppButtonClear(title: "", image: "magnifyingglass", width: 25, height: 35, action: {
                showSearchBar = true
                searchFocused = true
            })
        }
    }
    
    @ViewBuilder
    private var searchHeader: some View {
        HStack(spacing: 0) {
            AppSearchBar(title: "Поиск карточек", height: 45, isFocused: $searchFocused, searchText: $searchText)
            Spacer()
            AppButtonClear(title: "", image: "xmark", width: 25, height: 35, action: {
                showSearchBar = false
                searchFocused = false
                searchText = ""
            })
        }
    }
    
    @ViewBuilder
    private var cardsView: some View {
        VStack(spacing: 0) {
            ForEach(categories.indices, id: \.self) { index in
                let category = categories[index]
                VStack(spacing: 0) {
                    if index == 0 { Divider() }
                    Button(action: {
                        selectedCategory = category
                    }) {
                        CardsView(
                            title: category.title,
                            description: category.description,
                            quantity: category.quantity,
                            color: category.color,
                            image: category.image
                        )
                    }
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
