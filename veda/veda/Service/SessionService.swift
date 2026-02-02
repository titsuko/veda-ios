//
//  SessionService.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

import Foundation

protocol SessionServiceProtocol {
    func login(data: AuthRequest.Login) async throws -> AuthResponse.Auth
    func logout(token: String) async throws -> Void
    func refresh(token: String) async throws -> AuthResponse.Auth
}

final class SessionService {
    private let config: NetworkConfig
    private let session: URLSession
    
    init(config: NetworkConfig, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }
}
