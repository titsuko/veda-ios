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
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 40) {
                    logo
                    description
                    buttons
                }
                .navigationDestination(isPresented: $signInTapped) { SignInView() }
                .navigationDestination(isPresented: $signUpTapped) { SignUpView() }
            }
        }
    }
    
    @ViewBuilder
    private var logo: some View {
        ZStack {
            Image("logoCircle")
                .resizable()
                .frame(width: 310, height: 265)
            
            VStack(spacing: -25) {
                Image("logoEar")
                    .resizable()
                    .frame(width: 75, height: 100)
                    .rotationEffect(.degrees(60))
                
                Image("logoEar")
                    .resizable()
                    .frame(width: 65, height: 100)
                    .scaleEffect(x: 1, y: 1)
                    .rotationEffect(.degrees(260))
            }
        }
    }
    
    @ViewBuilder
    private var description: some View {
        Image("description")
            .resizable()
            .frame(width: 290, height: 210)
    }
    
    @ViewBuilder
    private var buttons: some View {
        VStack(spacing: 20) {
            AppButtonFill(title: "Войти", action: { signInTapped = true })
            AppButtonClear(title: "Создать аккаунт", action: { signUpTapped = true })
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    AuthView()
}
