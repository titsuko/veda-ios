//
//  CardReview.swift
//  veda
//
//  Created by Евгений Петрукович on 2/1/26.
//

import SwiftUI

struct CardReview: View {
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.dismiss) private var dismiss
    
    let category: CardCategory
    let item: CardItem
    
    private let navigationHeaderHeight: CGFloat = 130
    private let headerHeight: CGFloat = 280
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                historyCard
            }
            .padding(.top, headerHeight)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) { header }
        .overlay(alignment: .top) { navigation }
        .ignoresSafeArea()
        .background(.mainBackground)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.60) : item.rarity.color.opacity(0.70), location: 0.0),
                                .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.30) : item.rarity.color.opacity(0.40), location: 0.45),
                                .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.15) : item.rarity.color.opacity(0.25), location: 0.75),
                                .init(color: colorScheme == .dark ? item.rarity.color.opacity(0.05) : item.rarity.color.opacity(0.15), location: 1.0),
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ))
                    .background(TransparentBlur())
                    .frame(height: headerHeight)
                
                CardsHeader(item: item, category: category)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private var navigation: some View {
        ZStack(alignment: .bottom) {
            Rectangle()
                .fill(.clear)
                .frame(height: navigationHeaderHeight)
            
            HStack {
                AppButton(systemImage: "chevron.backward", width: 25, height: 35, style: .clear) { dismiss() }
                Spacer()
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
    
    @ViewBuilder
    private var historyCard: some View {
        ForEach(0..<20) { _ in
            VStack(spacing: 0) {
                ZStack {
                    Rectangle()
                        .fill(.clear)
                        .frame(height: 60)
                    
                    
                }
            }
            Divider()
        }
    }
}

private struct CardsHeader: View {
    let item: CardItem
    let category: CardCategory
    
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(item.rarity.color.gradient)
                    .frame(width: 85, height: 85)
                
                Image(systemName: category.image)
                    .font(.system(size: 22))
                    .foregroundStyle(.white)
                    .bold()
            }
            VStack(spacing: 3) {
                Text(item.title)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                
                Text(item.description)
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                
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
                    .padding(.top, 10)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    CardReview(
        category: CardCategory.mockCategories[0],
        item: CardCategory.mockCategories[0].items[0]
    )
}
