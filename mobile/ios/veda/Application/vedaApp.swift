//
//  vedaApp.swift
//  veda
//
//  Created by Евгений Петрукович on 1/23/26.
//

import SwiftUI

@main
struct vedaApp: App {
    @StateObject private var authViewModel = SignUpViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isRegistered {
                ContentView()
            } else {
                AuthView()
            }
        }
    }
}
