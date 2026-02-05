//
//  AuthView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var signUpViewModel: SignUpViewModel
    @EnvironmentObject var signInViewModel: SignInViewModel
    
    @State private var appeared = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                Spacer()
                logo
                description
                Spacer()
                buttons
            }
            .sheet(isPresented: $signInViewModel.signInTapped) {
                SignInView()
                    .environmentObject(signInViewModel)
            }
            .sheet(isPresented: $signUpViewModel.signUpTapped) {
                SignUpView()
                    .environmentObject(signUpViewModel)
            }
            .background(.sheetBackground)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    withAnimation(.spring(response: 0.7, dampingFraction: 0.45, blendDuration: 0.2)) {
                        appeared = true
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var logo: some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 230, height: 230)
                .opacity(appeared ? 1 : 0)
                .offset(y: appeared ? 0 : 20)
                .animation(.spring(response: 0.9, dampingFraction: 0.76).delay(0.05), value: appeared)
        }
    }
    
    @ViewBuilder
    private var description: some View {
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
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 50)
        .animation(.spring(response: 0.8, dampingFraction: 0.82).delay(0.18), value: appeared)
    }
    
    @ViewBuilder
    private var buttons: some View {
        VStack(spacing: 15) {
            AppButton(title: "Войти", height: 40, style: .fill) {
                signInViewModel.signInTapped = true
            }
            AppButton(title: "Создать аккаунт", height: 40, style: .clear) {
                signUpViewModel.signUpTapped = true
            }
        }
        .padding(.horizontal, 20)
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 30)
        .animation(.spring(response: 1.2, dampingFraction: 0.88).delay(0.31), value: appeared)
    }
}

#Preview {
    AuthView()
        .environmentObject(SignInViewModel())
        .environmentObject(SignUpViewModel())
}
