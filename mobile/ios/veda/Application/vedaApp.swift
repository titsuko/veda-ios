//
//  vedaApp.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

@main
struct vedaApp: App {
    @StateObject private var session = SessionManager.shared
    @StateObject private var signUpViewModel = SignUpViewModel()
    @StateObject private var signInViewModel = SignInViewModel()
    
    var body: some Scene {
        WindowGroup {
            if session.isLoggedIn {
                ContentView()
                    .environmentObject(session)
                    .environmentObject(signInViewModel)
                    .environmentObject(signUpViewModel)
            } else {
                AuthView()
                    .environmentObject(session)
                    .environmentObject(signInViewModel)
                    .environmentObject(signUpViewModel)
            }
        }
    }
}
