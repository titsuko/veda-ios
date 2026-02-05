//
//  SignInView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/24/26.
//

import SwiftUI

struct SignInView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    var body: some View {
        VStack {
            description
            textField.padding(.top, 40)
            resetPasswordButton.padding(.top, 8)
            Spacer()
            button
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .padding(.top, 60)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .overlay(alignment: .top) { header }
        .contentShape(Rectangle())
        .onTapGesture { hideKeyboard() }
        .alert("Ошибка", isPresented: $signInViewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(signInViewModel.errorMessage)
        }
        .background(.sheetBackground)
    }
    
    @ViewBuilder
    private var header: some View {
        HStack {
            AppButton(systemImage: "chevron.left", width: 25, height: 35, style: .clear) {
                dismiss()
            }
            Spacer()
        }
        .padding(.horizontal)
        .padding(.top)
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
            AppTextField(field: "Email", secure: false, text: $signInViewModel.email)
            AppTextField(field: "Пароль", secure: true, text: $signInViewModel.password)
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
        AppButton(title: "Войти", height: 40, style: .fill) {
            signInViewModel.login()
        }
        .disabled(signInViewModel.isButtonDisabled)
        .opacity(signInViewModel.isLoading ? 0.6 : 1)
    }
}

#Preview {
    AuthView()
        .environmentObject(SignInViewModel())
        .environmentObject(SignUpViewModel())
}
