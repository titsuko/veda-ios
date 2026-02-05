//
//  AuthViewModel.swift
//  veda
//
//  Created by Евгений Петрукович on 2/1/26.
//

import Combine
import Foundation
import SwiftUI

@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isAgreed: Bool = false
    
    @Published var signUpTapped: Bool = false
    @Published var isLoading: Bool = false
    @Published var showError: Bool = false
    @Published var errorMessage: String = ""
    
    private let accountService: AccountServiceProtocol
    
    init(accountService: AccountServiceProtocol? = nil) {
        self.accountService = accountService ?? AccountService()
    }
    
    var isButtonDisabled: Bool {
        name.isEmpty || email.isEmpty || password.isEmpty || !isAgreed || isLoading
    }
    
    func register() {
        guard !isButtonDisabled else { return }
        isLoading = true
        Task {
            do {
                let model = AuthRequest.Register(
                    fullName: name,
                    email: email,
                    password: password
                )
                let auth = try await accountService.register(data: model)
            
                SessionManager.shared.saveTokens(
                    accessToken: auth.accessToken,
                    refreshToken: auth.refreshToken
                )
                
                signUpTapped = false
                
            } catch {
                errorMessage = error.localizedDescription
                showError = true
            }
            isLoading = false
        }
    }
}
