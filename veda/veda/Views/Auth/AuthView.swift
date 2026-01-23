//
//  AuthView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct AuthView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.black)
                .ignoresSafeArea()
            
            VStack(spacing: 40) {
                logo
                description
                buttons
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
        VStack(spacing: 30) {
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(.gold)
                        .frame(height: 45)
                    
                    Text("Войти")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                }
            }
            
            Button(action: {}) {
                ZStack {
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(.gold, lineWidth: 1)
                        .frame(height: 45)
                    
                    Text("Создать аккаунт")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundStyle(.gold)
                }
            }
        }
        .padding(.horizontal, 50)
    }
}

#Preview {
    AuthView()
}
