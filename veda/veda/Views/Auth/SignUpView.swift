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
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                logo
                VStack(spacing: 30) {
                    textField
                    userAgreement
                    button
                }
                .padding(.horizontal, 30)
            }
        }
    }
    
    @ViewBuilder
    private var logo: some View {
        ZStack {
            Image("logoCircle")
                .resizable()
                .frame(width: 260, height: 225)
            
            VStack(spacing: -10) {
                Image("logoEar")
                    .resizable()
                    .frame(width: 55, height: 80)
                    .rotationEffect(.degrees(60))
                
                Image("logoEar")
                    .resizable()
                    .frame(width: 45, height: 80)
                    .scaleEffect(x: 1, y: 1)
                    .rotationEffect(.degrees(260))
            }
        }
    }
    
    @ViewBuilder
    private var textField: some View {
        VStack(spacing: 30) {
            AppTextField(title: "", field: "Ваше имя", secure: false, text: $name)
            AppTextField(title: "Email", field: "Заполните поле", secure: false, text: $email)
            AppTextField(title: "Пароль", field: "Заполните поле", secure: true, text: $password)
        }
    }
    
    @ViewBuilder
    private var userAgreement: some View {
        HStack(spacing: 15) {
            Button(action: {isAgreed.toggle()}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.white)
                        .frame(width: 20, height: 20)
                    
                    if isAgreed {
                        Image(systemName: "checkmark")
                            .foregroundStyle(.black)
                            .bold()
                    }
                }
                Text("Пользовательское соглашение")
                    .foregroundStyle(.gold)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical, 15)
    }
    
    @ViewBuilder
    private var button: some View {
        Button(action: {}) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(.gold)
                    .frame(height: 45)
                
                Text("Создать аккаунт")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(.white)
            }
        }
        .padding(.horizontal, 40)
        .padding(.top, 10)
    }
}

#Preview {
    SignUpView()
}
