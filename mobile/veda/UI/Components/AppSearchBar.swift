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
    
    @Binding var isFocused: Bool
    @FocusState private var internalFocus: Bool
    @Binding var searchText: String
    
    var body: some View {
        ZStack {
            background
            ZStack {
                placeholder
                textField
            }
        }
        .onAppear {
            internalFocus = true
        }
        .onChange(of: isFocused) { _, newValue in
            internalFocus = newValue
        }
        .animation(.spring(duration: 0.2), value: searchText)
    }
    
    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: 30)
            .fill(.gray.opacity(0))
            .frame(height: height)
            .glassEffect()
    }
    
    @ViewBuilder
    private var placeholder: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 18))
            
            if searchText.isEmpty {
                Text(title)
                    .font(.system(size: 18))
            }
            Spacer()
        }
        .foregroundStyle(.secondary)
        .padding(.leading, 10)
    }
    
    @ViewBuilder
    private var textField: some View {
        HStack {
            TextField("", text: $searchText)
                .focused($internalFocus)
                .onChange(of: isFocused) { _, newValue in
                    internalFocus = newValue
                }
                .padding(.leading, 40)
            
            if !searchText.isEmpty {
                Button(action: { searchText = "" }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                }
                .foregroundStyle(.secondary)
                .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    ContentView()
}
