//
//  SettingsView.swift
//  veda
//
//  Created by Евгений Петрукович on 1/27/26.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var signInViewModel: SignInViewModel
    @Binding var selectedTab: SelectedTab
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @AppStorage("pushNotifications") private var pushNotifications = true
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                accountSection
                appearanceSection
                aboutSection
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.top, 160)
            .overlay(alignment: .bottom) { AppTabBar(selectedTab: $selectedTab) }
            .overlay(alignment: .top) { header }
            .ignoresSafeArea()
            .background(Color.mainBackground)
        }
    }
    
    @ViewBuilder
    private var header: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .bottom) {
                Rectangle()
                    .fill(.header.opacity(0.6))
                    .background(TransparentBlur())
                    .frame(height: 130)
                
                HStack {
                    AppButton(systemImage: "square.and.pencil", width: 25, height: 35, style: .clear) {
                        
                    }
                    Spacer()
                    
                    HStack(alignment: .center, spacing: 10) {
                        Image(systemName: "gearshape")
                            .font(.system(size: 22))
                        
                        Text("Настройки")
                            .font(.system(size: 20, weight: .bold))
                    }
                    .padding(.top, 10)
                    
                    Spacer()
                    AppButton(systemImage: "magnifyingglass", width: 25, height: 35, style: .clear) {
                        
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }
            Divider()
        }
    }
    
    @ViewBuilder
    private var accountSection: some View {
        CustomSettingsSection(header: "Аккаунт") {
            NavigationLink(destination: Text("Здесь будет информация о приложении.")) {
                SettingsRow(
                    iconSystemName: "person.crop.circle.fill",
                    iconBackground: .blue,
                    title: "Юзер",
                    subtitle: "user@email.com",
                    accessory: .chevron
                )
            }
            .foregroundStyle(.primary)
            
            SettingsDivider()
            Button(action: { signInViewModel.logout() }) {
                SettingsRow(
                    iconSystemName: "rectangle.portrait.and.arrow.right",
                    iconBackground: .red,
                    title: "Выйти с аккаунта",
                    subtitle: nil,
                    accessory: .none
                )
                .foregroundStyle(.red)
            }
        }
    }
    
    @ViewBuilder
    private var appearanceSection: some View {
        CustomSettingsSection(header: "Внешний вид") {
            NavigationLink(destination: Text("Здесь будет информация о приложении.")) {
                SettingsRow(
                    iconSystemName: "moon.fill",
                    iconBackground: .mint,
                    title: "Тёмная тема",
                    subtitle: nil,
                    accessory: .chevron
                )
            }
            .foregroundStyle(.primary)
            
            SettingsDivider()
            SettingsRow(
                iconSystemName: "bell.fill",
                iconBackground: .orange,
                title: "Push‑уведомления",
                subtitle: nil,
                accessory: .toggle($pushNotifications)
            )
        }
        .foregroundStyle(.primary)
    }
    
    @ViewBuilder
    private var aboutSection: some View {
        CustomSettingsSection(header: "О приложении") {
            NavigationLink(destination: Text("Здесь будет информация о приложении.")) {
                SettingsRow(
                    iconSystemName: "info.circle.fill",
                    iconBackground: .blue,
                    title: "О приложении",
                    subtitle: nil,
                    accessory: .chevron
                )
            }
            .foregroundStyle(.primary)
            
            SettingsDivider()
            NavigationLink(destination: Text("Здесь будет информация о приложении.")) {
                SettingsRow(
                    iconSystemName: "star.fill",
                    iconBackground: .yellow,
                    title: "Оценить приложение",
                    subtitle: nil,
                    accessory: .none
                )
            }
            .foregroundStyle(.primary)
        }
    }
}

#Preview {
    SettingsView(selectedTab: .constant(.settings))
        .environmentObject(SignInViewModel())
}
