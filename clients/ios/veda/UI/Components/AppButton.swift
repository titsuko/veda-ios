//
//  AppButton.swift
//  veda
//
//  Created by Евгений Петрукович on 1/24/26.
//

import SwiftUI

enum AppButtonStyle {
    case fill
    case clear
}

struct AppButton: View {
    let title: String?
    let systemImage: String?
    let width: CGFloat
    let height: CGFloat
    let style: AppButtonStyle
    let action: () -> Void

    init(
        title: String? = nil,
        systemImage: String? = nil,
        width: CGFloat = .infinity,
        height: CGFloat = 40,
        style: AppButtonStyle = .fill,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.systemImage = systemImage
        self.width = width
        self.height = height
        self.style = style
        self.action = action
    }

    var body: some View {
        if style == .fill {
            if #available(iOS 26.0, *) {
                Button(action: action) {
                    label
                        .frame(maxWidth: width, maxHeight: height)
                }
                .buttonStyle(.glassProminent)
                .foregroundColor(Color.white)
                
            } else {
                Button(action: action) {
                    label
                        .frame(maxWidth: width, maxHeight: height)
                        .foregroundColor(Color.primary)
                }
                .buttonStyle(.borderedProminent)
                .foregroundColor(Color.white)
            }
            
        } else {
            if #available(iOS 26.0, *) {
                Button(action: action) {
                    label
                        .frame(maxWidth: width, maxHeight: height)
                }
                .buttonStyle(.glass)
                
            } else {
                Button(action: action) {
                    label
                        .frame(maxWidth: width, maxHeight: height)
                }
                .buttonStyle(.bordered)
                .foregroundColor(Color.primary)
            }
        }
    }

    @ViewBuilder
    private var label: some View {
        if let title, let systemImage {
            Label(title, systemImage: systemImage)
                .font(.system(size: 18, weight: .semibold))
        } else if let title {
            Text(title)
                .font(.system(size: 18, weight: .semibold))
        } else if let systemImage {
            Image(systemName: systemImage)
                .font(.system(size: 18, weight: .semibold))
        } else {
            EmptyView()
        }
    }
}

#Preview {
    AppButton(title: "Войти", style: .fill) {
        
    }
    AppButton(title: "Выйти", style: .clear) {
        
    }
    
    HStack(spacing: 10) {
        AppSearchBar(title: "Search", height: 50, isFocused: .constant(false), searchText: .constant(""))
        
        AppButton(systemImage: "xmark", width: 30, style: .clear) {}
    }
    .padding(.horizontal)
}
