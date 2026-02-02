//
//  SignUpView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var viewModel: SignUpViewModel
    
    var body: some View {
        VStack {
            description
            if !viewModel.isLoading {
                textField
                userAgreement
            } else {
                Spacer()
                progressView
            }
            Spacer()
            button
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 20)
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .contentShape(Rectangle())
        .onTapGesture { hideKeyboard() }
        .background(.sheetBackground)
        .animation(.spring(duration: 0.2), value: viewModel.isButtonDisabled)
        .animation(.spring(duration: 0.2), value: viewModel.isLoading)
        .alert("Ошибка", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}
    
private extension SignUpView {
    var description: some View {
        VStack(spacing: 6) {
            Text("Создать аккаунт")
                .font(.system(size: 26, weight: .bold))
            
            Text("Пожалуйста, укажите имя, email и пароль для входа")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    var textField: some View {
        VStack(spacing: 20) {
            AppTextField(field: "Ваше имя", secure: false, text: $viewModel.name)
            AppTextField(field: "Email", secure: false, text: $viewModel.email)
            AppTextField(field: "Пароль", secure: true, text: $viewModel.password)
        }
        .padding(.top, 30)
    }
    
    var userAgreement: some View {
        Button {
            viewModel.isAgreed.toggle()
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(viewModel.isAgreed ? .blue : .clear)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                        .frame(width: 22, height: 22)
                    
                    if viewModel.isAgreed {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                
                Text(agreementText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
        .padding(.top, 20)
    }
    
    var button: some View {
        AppButton(title: "Создать аккаунт", height: 40, style: .fill) {
            viewModel.register()
        }
        .disabled(viewModel.isButtonDisabled)
        .opacity(viewModel.isLoading ? 0.6 : 1)
    }
    
    var progressView: some View {
        ProgressView()
    }
    
    var agreementText: AttributedString {
        var part1 = AttributedString("Вы подтверждаете, что ознакомились и соглашаетесь с условиями ")
        part1.foregroundColor = .secondary
        
        var part2 = AttributedString("пользовательского соглашения.")
        part2.foregroundColor = .blue
        part2.underlineStyle = .single
        
        return part1 + part2
    }
}

#Preview {
    SignUpView()
        .environmentObject(SignUpViewModel())
}
