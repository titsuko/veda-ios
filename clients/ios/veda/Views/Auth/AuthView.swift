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
    
    @State private var signInTapped: Bool = false
    @State private var signUpTapped: Bool = false
    
    @State private var showLogo: Bool = false
    @State private var showDescription: Bool = false
    @State private var showButtons: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            Spacer()
            
            logo
                .opacity(showLogo ? 1 : 0)
                .offset(y: showLogo ? 0 : 20)
                .animation(.spring(duration: 1), value: showLogo)
            
            description
                .opacity(showDescription ? 1 : 0)
                .offset(y: showDescription ? 0 : 40)
                .animation(.spring(duration: 0.95), value: showDescription)
            
            Spacer()
            
            buttons
                .opacity(showButtons ? 1 : 0)
                .offset(y: showButtons ? 0 : 40)
                .animation(.spring(duration: 0.95), value: showButtons)
        }
        .task {
            await animateIn()
        }
        .sheet(isPresented: $signInTapped) {
            NavigationStack {
                SignInView()
                    .environmentObject(signInViewModel)
            }
        }
        .sheet(isPresented: $signUpTapped) {
            NavigationStack {
                SignUpView()
                    .environmentObject(signUpViewModel)
            }
        }
        .background(.sheetBackground)
    }
    
    private func animateIn() async {
        showLogo = false
        showDescription = false
        showButtons = false
        
        withAnimation { showLogo = true }
        try? await Task.sleep(nanoseconds: 300_000_000)
        
        withAnimation { showDescription = true }
        try? await Task.sleep(nanoseconds: 400_000_000)
        
        withAnimation { showButtons = true }
    }
    
    @ViewBuilder
    private var logo: some View {
        ZStack {
            Image("logo")
                .resizable()
                .frame(width: 230, height: 230)
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
    }
    
    @ViewBuilder
    private var buttons: some View {
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
        .environmentObject(SignInViewModel())
        .environmentObject(SignUpViewModel())
}
