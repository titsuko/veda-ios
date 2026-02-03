//
//  AppTextField.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct AppTextField: View {
    let field: String
    let secure: Bool
    
    @State private var showPassword: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @Binding var text: String
    
    var body: some View {
        ZStack {
            background
            HStack(spacing: 10) {
                ZStack {
                    placeholder
                    textField
                }
                buttonClearText
            }
            .padding(.horizontal)
        }
        .animation(.spring(duration: 0.1), value: text)
        .animation(.spring(duration: 0.1), value: showPassword)
        .animation(.spring(duration: 0.2), value: isTextFieldFocused)
    }
    
    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(.gray.opacity(0.4), lineWidth: 1)
            .frame(height: 50)
    }
    
    @ViewBuilder
    private var placeholder: some View {
        HStack {
            Text(field)
                .padding(.horizontal, 3)
                .bold(isTextFieldFocused)
                .foregroundStyle(.secondary)
                .background(.sheetBackground)
                .offset(y: (isTextFieldFocused || !text.isEmpty) ? -26 : 0)
            
            Spacer()
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        if secure {
            if !showPassword {
                SecureField("", text: $text)
                    .focused($isTextFieldFocused)
                
            } else {
                TextField("", text: $text)
                    .focused($isTextFieldFocused)
            }
        } else {
            TextField("", text: $text)
                .focused($isTextFieldFocused)
        }
    }
    
    @ViewBuilder
    private var buttonClearText: some View {
        if !text.isEmpty {
            if secure {
                Button(action: { showPassword.toggle() }) {
                    Image(systemName: showPassword ? "eye" : "eye.slash")
                        .font(.system(size: 18))
                        .foregroundColor(Color.white.opacity(0.7))
                }
            }

            Button(action: { text.removeAll() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 18))
                    .foregroundColor(Color.white.opacity(0.7))
            }
        }
    }
}
