//
//  AppSearchBar.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct AppSearchBar: View {
    let title: String
    let height: CGFloat
    
    @FocusState private var isFocused: Bool
    @Binding var searchText: String
    
    init(title: String, height: CGFloat = 50, searchText: Binding<String>) {
        self.title = title
        self.height = height
        self._searchText = searchText
    }
    
    var body: some View {
        ZStack {
            background
            ZStack {
                placeholder
                textField
            }
        }
        .animation(.spring(duration: 0.2), value: searchText)
        .animation(.spring(duration: 0.2), value: isFocused)
    }
    
    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.gray.opacity(0.2))
            .frame(height: height)
    }
    
    @ViewBuilder
    private var placeholder: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20))
            
            if searchText.isEmpty {
                Text(title)
                    .font(.system(size: 18))
            }
            
            if isFocused {
                Spacer()
            }
        }
        .foregroundStyle(.goldText.secondary)
        .padding(.leading, 10)
    }
    
    @ViewBuilder
    private var textField: some View {
        HStack {
            TextField("", text: $searchText)
                .focused($isFocused)
                .foregroundStyle(.goldText)
                .padding(.leading, 42)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                }
                .foregroundStyle(.goldText)
                .padding(.trailing)
            }
        }
    }
}

#Preview {
    @Previewable @State var searchText: String = ""
    VStack {
        Spacer()
        AppSearchBar(title: "Поиск", searchText: $searchText)
        Spacer()
    }
    .padding(.horizontal)
}
