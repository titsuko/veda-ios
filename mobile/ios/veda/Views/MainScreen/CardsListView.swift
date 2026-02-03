//
//  CardsListView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct CardsListView: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    @State private var searchText: String = ""
    @State private var searchFocused = false
    @State private var showSearchBar: Bool = false
    
    let categories: CardCategory
    
    var headerHeight: CGFloat = 130
    
    var filteredItems: [CardItem] {
        if searchText.isEmpty {
            return categories.items
        } else {
            return categories.items.filter {
                $0.title.localizedCaseInsensitiveContains(searchText) ||
                $0.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack {
            if filteredItems.isEmpty {
                emptySearchView
            } else {
                ScrollView(showsIndicators: false) {
                    cardsListView
                        .padding(.top, headerHeight)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) { header }
        .ignoresSafeArea()
        .background(.mainBackground)
        .navigationBarHidden(true)
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
        ZStack {
            HStack {
                AppButton(systemImage: "chevron.backward", width: 25, height: 35, style: .clear) {
                    dismiss()
                }
                Spacer()
                VStack(alignment: .center, spacing: 5) {
                    Text(categories.title)
                        .font(.system(size: 18, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .lineLimit(1)
                    
                    Text("\(categories.quantity) карточек")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundStyle(categories.color.gradient)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 3)
                        .overlay(
                            Capsule()
                                .fill(colorScheme == .dark ? categories.color.gradient.opacity(0.1) : categories.color.gradient.opacity(0.2))
                                .stroke(categories.color.opacity(0.4), lineWidth: 1)
                        )
                }
                Spacer()
                AppButton(systemImage: "magnifyingglass", width: 25, height: 35, style: .clear) {
                    showSearchBar = true
                    searchFocused = true
                }
            }
        }
    }
    
    @ViewBuilder
    private var searchHeader: some View {
        HStack(spacing: 0) {
            AppSearchBar(title: "Поиск по карточкам", height: 45, isFocused: $searchFocused, searchText: $searchText)
            Spacer()
            AppButton(systemImage: "xmark", width: 25, height: 35, style: .clear) {
                showSearchBar = false
                searchFocused = false
                searchText = ""
            }
        }
    }
    
    @ViewBuilder
    private var cardsListView: some View {
        NavigationList(items: filteredItems) { item in
            CardsView(category: categories, item: item)
        } destination: { item in
            CardReview(category: categories, item: item)
        } background: { item in
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.20) : item.rarity.color.opacity(0.30), location: 0.0),
                    .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.10) : item.rarity.color.opacity(0.20), location: 0.45),
                    .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.05) : item.rarity.color.opacity(0.05), location: 0.75),
                    .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.00) : item.rarity.color.opacity(0.00), location: 1.0)
                ]),
                startPoint: .trailing,
                endPoint: .leading
            )
        }
    }
    
    @ViewBuilder
    private var emptySearchView: some View {
        VStack {
            Image(systemName: "menucard.fill")
                .resizable()
                .frame(width: 35, height: 50)
                .foregroundColor(.secondary)
            
            Text("Нет карточек")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.secondary)
        }
    }
}

private struct CardsView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    let category: CardCategory
    let item: CardItem
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(item.rarity.color.gradient)
                    .frame(width: 65, height: 65)
                
                Image(systemName: category.image)
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            }
            VStack(alignment: .leading, spacing: 5) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text("Праздники")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(item.rarity.color)
                    .multilineTextAlignment(.leading)
                    .lineLimit(1)
                
                Text(item.description)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.leading)
                    .lineLimit(2)
            }
            Spacer()
            
            Text(item.rarity.name)
                .font(.system(size: 14, weight: .bold))
                .foregroundStyle(item.rarity.color.gradient)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .overlay(
                    Capsule()
                        .fill(item.rarity.color.opacity(0.2))
                        .stroke(item.rarity.color.opacity(0.4), lineWidth: 1)
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
    }
}

#Preview {
    CardsListView(
        categories: CardCategory(
            title: "Праздники",
            description: "Традиции и обряды солнцестояния с кострами, гаданиями и древними ",
            quantity: 5,
            color: .orange,
            image: "sun.max",
            items: [
                CardItem(
                    title: "Цветок папоротника",
                    description: "Мифический цветок, который, по легенде, расцветает в ночь на Ивана Купалу и приносит удачу",
                    rarity: .epic
                ),
                CardItem(
                    title: "Ночь Ивана Купалы",
                    description: "Праздник летнего солнцестояния с кострами, гаданиями и древними обрядами",
                    rarity: .rare
                ),
                CardItem(
                    title: "Коляда",
                    description: "Зимний обрядовый праздник, связанный с рождением нового солнца",
                    rarity: .common
                ),
                CardItem(
                    title: "Масленица",
                    description: "Проводы зимы с блинами, гуляниями и сожжением чучела",
                    rarity: .rare
                ),
                CardItem(
                    title: "Дзяды",
                    description: "Древний обряд поминовения предков, сохранившийся в белорусской традиции",
                    rarity: .legendary
                )
            ]
        )
    )
}
