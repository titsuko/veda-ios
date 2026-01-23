//
//  AppTextField.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

struct AppTextField: View {
    let title: String
    let field: String
    let secure: Bool
    
    @State private var showPassword: Bool = false
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.system(size: 22, weight: .semibold))
                .foregroundColor(.goldText)
            
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(.gold, lineWidth: 1)
                    .frame(height: 50)
                
                HStack(spacing: 10) {
                    ZStack {
                        HStack {
                            if text.isEmpty {
                                Text(field)
                                    .foregroundStyle(.gold)
                            }
                            Spacer()
                        }
                        if secure {
                            if !showPassword {
                                SecureField("", text: $text)
                                    .foregroundStyle(.goldText)
                            } else {
                                TextField("", text: $text)
                                    .foregroundStyle(.goldText)
                            }
                        } else {
                            TextField("", text: $text)
                                .foregroundStyle(.goldText)
                        }
                    }
                    if !text.isEmpty {
                        if secure {
                            Button(action: {showPassword.toggle()}) {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .font(.system(size: 18))
                                    .foregroundStyle(.goldText)
                            }
                        }
                        Button(action: {text.removeAll()}) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 18))
                                .foregroundStyle(.goldText)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .animation(.easeIn(duration: 0.1), value: text)
        .animation(.easeIn(duration: 0.1), value: showPassword)
    }
}

#Preview {
    @Previewable @State var email: String = ""
    @Previewable @State var password: String = ""
    AppTextField(title: "Email", field: "Заполните поле", secure: false, text: $email)
    AppTextField(title: "Password", field: "Заполните поле", secure: true, text: $password)
}
