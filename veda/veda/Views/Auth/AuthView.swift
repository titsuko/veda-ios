//
//  AuthView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct AuthView: View {
    @State private var signInTapped: Bool = false
    @State private var signUpTapped: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer()
                logo
                description
                Spacer()
                buttons
            }
            .navigationDestination(isPresented: $signInTapped) {
                SignInView()
            }
            .navigationDestination(isPresented: $signUpTapped) {
                SignUpView()
                    .environmentObject(SignUpViewModel())
            }
            .background(.sheetBackground)
        }
    }
}

private extension AuthView {
    var logo: some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 230, height: 230)
        }
    }
    
    var description: some View {
        VStack(spacing: 10) {
            Text("VEDA.cards")
                .font(.custom("CrimsonText-Regular", size: 48))
            
            Text("СОБИРАЙ ЗНАНИЯ")
                .font(.custom("CrimsonText-Regular", size: 24))
                .foregroundStyle(.gray)
            
            Text("Энциклопедия знаний  в  формате коллекционных карточек")
                .font(.custom("CrimsonText-Regular", size: 16))
                .multilineTextAlignment(.center)
                .foregroundStyle(.gray)
        }
    }
    
    var buttons: some View {
        VStack(spacing: 15) {
            AppButton(title: "Войти", height: 40, style: .fill) {
                signInTapped = true
            }
            AppButton(title: "Создать аккаунт", height: 40, style: .clear) {
                signUpTapped = true
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    AuthView()
}
