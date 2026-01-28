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
    
    private var agreementText: AttributedString {
        var part1 = AttributedString("Вы подтверждаете, что ознакомились и соглашаетесь с условиями ")
        part1.foregroundColor = .secondary
        
        var part2 = AttributedString("пользовательского соглашения.")
        part2.foregroundColor = .goldText
        part2.underlineStyle = .single
        
        return part1 + part2
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
    }
    
    @ViewBuilder
    private var description: some View {
        VStack(spacing: 6) {
            Text("Создать аккаунт")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.goldText)
            
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
                        .fill(isAgreed ? .goldText : .clear)
                        .stroke(.gold, lineWidth: 1)
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
        AppButtonFill(title: "Создать аккаунт", action: {})
    }
}

#Preview {
    SignUpView()
}
