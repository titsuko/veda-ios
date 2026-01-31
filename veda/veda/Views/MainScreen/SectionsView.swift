//
//  CardView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/28/26.
//

import SwiftUI

struct SectionsView: View {
    let title: String
    let description: String
    let quantity: Int
    let color: Color
    let image: String
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    var body: some View {
        background
            .overlay(
                HStack(spacing: 15) {
                    imageCard
                    text
                    Spacer()
                    quantityCard
                }
                    .padding(.horizontal, 10)
            )
    }
    
    @ViewBuilder
    private var background: some View {
        RoundedRectangle(cornerRadius: 0)
            .fill(.clear)
            .frame(height: 80)
    }
    
    @ViewBuilder
    private var imageCard: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(colorScheme == .dark ? color.gradient.opacity(0.65) : color.gradient.opacity(0.65))
                .stroke(color, lineWidth: 0.3)
                .frame(width: 60, height: 60)
            
            Image(systemName: image)
                .font(.system(size: 22))
                .foregroundStyle(.white)
                .bold()
        }
    }
    
    @ViewBuilder
    private var text: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(.system(size: 16, weight: .semibold))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
            
            Text(description)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
        }
    }
    
    @ViewBuilder
    private var quantityCard: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(colorScheme == .dark ? color.gradient.opacity(0.1) : color.gradient.opacity(0.3))
                    .frame(width: 100, height: 30)
                    .glassEffect()
                
                Text("\(quantity) карточек")
                    .font(.system(size: 13, weight: .bold))
                    .foregroundStyle(color.gradient)
            }
        }
    }
}

#Preview {
    ContentView()
}
