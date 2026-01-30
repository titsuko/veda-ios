//
//  AppButton.swift
//  veda
//
//  Created by Евгений Петрукович on 1/24/26.
//

import SwiftUI

struct AppButtonFill: View {
    let title: String
    let image: String
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    init(title: String = "", image: String = "", width: CGFloat = .infinity, height: CGFloat = 40, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.width = width
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, maxHeight: height)
                
                Image(systemName: image)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: width, maxHeight: height)
            }
        }
        .buttonStyle(.glassProminent)
    }
}

struct AppButtonClear: View {
    let title: String
    let image: String
    let width: CGFloat
    let height: CGFloat
    let action: () -> Void

    init(title: String, image: String = "", width: CGFloat = .infinity, height: CGFloat = 40, action: @escaping () -> Void) {
        self.title = title
        self.image = image
        self.width = width
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: width, maxHeight: height)
                
                Image(systemName: image)
                    .font(.system(size: 18, weight: .semibold))
                    .frame(maxWidth: width, maxHeight: height)
            }
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    AppButtonFill(title: "Вход", action: {})
    AppButtonClear(title: "Выход", action: {})
    AppButtonClear(title: "", image: "xmark", width: 30, action: {})
}
