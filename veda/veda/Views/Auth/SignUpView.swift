//
//  SignUpView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct SignUpView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var isAgreed: Bool = false
    
    @State var isLoading: Bool = false
    @State var showError: Bool = false
    @State var errorMessage: String = ""
    @State var isRegistered: Bool = false
    
    private let accountService: AccountServiceProtocol
    
    private var agreementText: AttributedString {
        var part1 = AttributedString("Вы подтверждаете, что ознакомились и соглашаетесь с условиями ")
        part1.foregroundColor = .secondary
        
        var part2 = AttributedString("пользовательского соглашения.")
        part2.foregroundColor = .blue
        part2.underlineStyle = .single
        
        return part1 + part2
    }
    
    init(accountService: AccountServiceProtocol = AccountService()) {
        self.accountService = accountService
    }
    
    var body: some View {
        VStack {
            description
            textField.padding(.top, 30)
            userAgreement.padding(.top, 20)
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
            Text("Создать аккаунт")
                .font(.system(size: 26, weight: .bold))
            
            Text("Пожалуйста, укажите имя, email и пароль для входа")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    
    @ViewBuilder
    private var textField: some View {
        VStack(spacing: 20) {
            AppTextField(field: "Ваше имя", secure: false, text: $name)
            AppTextField(field: "Email", secure: false, text: $email)
            AppTextField(field: "Пароль", secure: true, text: $password)
        }
    }
    
    @ViewBuilder
    private var userAgreement: some View {
        Button(action: { isAgreed.toggle() }) {
            HStack(alignment: .center) {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(isAgreed ? .blue : .clear)
                        .stroke(.gray.opacity(0.4), lineWidth: 1)
                        .frame(width: 22, height: 22)
                    
                    if isAgreed {
                        Image(systemName: "checkmark")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                
                Text(agreementText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.leading)
                
                Spacer()
            }
        }
    }
    
    @ViewBuilder
    private var button: some View {
        AppButton(title: "Создать аккаунт", height: 40, style: .fill) {
            guard !name.isEmpty, !email.isEmpty, !password.isEmpty, isAgreed else {
                return
            }
            
            isLoading = true
            
            Task {
                do {
                    let model = AuthRequest.Register(fullName: name, email: email, password: password)
                    
                    let _ = try await accountService.register(data: model)
                    isRegistered = true
                } catch {
                    errorMessage = error.localizedDescription
                    showError = true
                }
                
                isLoading = false
            }
            
        }
        .disabled(isLoading)
        .opacity(isLoading ? 0.6 : 1)
    }
}

#Preview {
    SignUpView()
}
