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
        .onChange(of: isFocused) { newValue in
            internalFocus = newValue
        }
        .animation(.spring(duration: 0.2), value: searchText)
    }

    @ViewBuilder
    private var background: some View {
        if #available(iOS 26.0, *) {
            RoundedRectangle(cornerRadius: 30)
                .fill(.gray.opacity(0.0))
                .frame(height: height)
                .glassEffect()
        } else {
            RoundedRectangle(cornerRadius: 30)
                .fill(Color.gray.opacity(0.12))
                .frame(height: height)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.ultraThinMaterial)
                )
        }
    }

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
        .foregroundColor(.secondary)
        .padding(.leading, 10)
    }

    private var textField: some View {
        HStack {
            TextField("", text: $searchText)
                .focused($internalFocus)
                .padding(.leading, 40)

            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                }
                .padding(.trailing, 10)
            }
        }
    }
}

#Preview {
    ContentView()
}
