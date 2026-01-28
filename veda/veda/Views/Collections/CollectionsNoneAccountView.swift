//
//  CollectionsNoneAccountView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct CollectionsNoneAccountView: View {
    @State private var isPresented: Bool = false
    
    var body: some View {
        VStack {
            image
            description
            button
                .padding(.top)
        }
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AuthView()
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Закрыть") {
                                isPresented = false
                            }
                        }
                    }
            }
        }
    }
    
    @ViewBuilder
    private var image: some View {
        Image("logo")
            .resizable()
            .frame(width: 150, height: 150)
    }
    
    @ViewBuilder
    private var description: some View {
        VStack(spacing: 6) {
            Text("Войдите в аккаунт")
                .font(.system(size: 26, weight: .bold))
                .foregroundStyle(.goldText)
            
            Text("Здесь вы увидите сохраненные прогресс и те темы, которые вам понравились")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    @ViewBuilder
    private var button: some View {
        AppButtonFill(title: "Войти", height: 38, action: { isPresented = true })
            .padding(.horizontal, 100)
    }
}

#Preview {
    CollectionsNoneAccountView()
}
