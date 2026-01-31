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
    
    let category: CardCategory
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
            }
            .overlay(alignment: .top) { header }
            .ignoresSafeArea()
            .background(.mainBackground)
        }
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
                    .frame(height: 130)
                
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
            AppButton(systemImage: "chevron.backward", width: 25, height: 35, style: .clear) {
                dismiss()
            }
            Spacer()
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
}

#Preview {
    ContentView()
}
