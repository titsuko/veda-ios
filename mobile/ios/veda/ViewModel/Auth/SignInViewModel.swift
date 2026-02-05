//
//  SignInViewModel.swift
//  veda
//
//  Created by Евгений Петрукович on 2/3/26.
//

import Combine
import SwiftUI
import Foundation

@MainActor
final class SignInViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var signInTapped: Bool = false
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    @Published var isLoggedIn: Bool = false
    
    private let sessionService: SessionServiceProtocol
    
    init(sessionService: SessionServiceProtocol? = nil) {
        self.sessionService = sessionService ?? SessionService(config: .dev)
    }
    
    var isButtonDisabled: Bool {
        email.isEmpty || password.isEmpty || isLoading
    }
    
    func login() {
        guard !isButtonDisabled else { return }
        isLoading = true
        
        Task {
            do {
                let request = AuthRequest.Login(email: email, password: password)
                let auth = try await sessionService.login(data: request)
                
                SessionManager.shared.saveTokens(
                    accessToken: auth.accessToken,
                    refreshToken: auth.refreshToken
                )
                
                isLoggedIn = true
                signInTapped = false
                
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
            isLoading = false
        }
    }
    
    func logout() {
        SessionManager.shared.logout()
        isLoggedIn = false
    }
}
