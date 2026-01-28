//
//  AppButton.swift
//  veda
//
//  Created by Евгений Петрукович on 1/24/26.
//

import SwiftUI

struct AppButtonFill: View {
    let title: String
    let height: CGFloat
    let action: () -> Void

    init(title: String, height: CGFloat = 50, action: @escaping () -> Void) {
        self.title = title
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.goldText)
                    .frame(height: height)

                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct AppButtonClear: View {
    let title: String
    let height: CGFloat
    let action: () -> Void

    init(title: String, height: CGFloat = 50, action: @escaping () -> Void) {
        self.title = title
        self.height = height
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(.gold, lineWidth: 1)
                    .frame(height: height)

                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.goldText)
            }
        }
    }
}

#Preview {
    AppButtonFill(title: "Вход", action: {})
    AppButtonClear(title: "Выход", action: {})
}
