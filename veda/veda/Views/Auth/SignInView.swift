//
//  SignInView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/24/26.
//

import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var isAgreed: Bool = false
    
    var body: some View {
        VStack {
            description
            textField.padding(.top, 40)
            resetPasswordButton.padding(.top, 8)
            Spacer()
            button
        }
        .padding(.horizontal, 20)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .contentShape(Rectangle())
        .onTapGesture { hideKeyboard() }
        .background(.sheetBackground)
    }
    
    @ViewBuilder
    private var description: some View {
        VStack(spacing: 6) {
            Text("Войти в аккаунт")
                .font(.system(size: 26, weight: .bold))
            
            Text("Пожалуйста, укажите email и пароль для входа")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        VStack(spacing: 20) {
            AppTextField(field: "Email", secure: false, text: $email)
            AppTextField(field: "Пароль", secure: true, text: $password)
        }
    }
    
    @ViewBuilder
    private var resetPasswordButton: some View {
        HStack {
            Spacer()
            Button(action: {}) {
                Text("Забыли пароль?")
            }
        }
        .foregroundStyle(.blue)
    }
    
    @ViewBuilder
    private var button: some View {
        AppButtonFill(title: "Войти", action: {})
    }
}

#Preview {
    SignInView()
}

