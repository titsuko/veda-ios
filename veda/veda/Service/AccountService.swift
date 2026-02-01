//
//  AccountService.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

import Foundation

protocol AccountServiceProtocol {
    func register(data: AuthRequest.Register) async throws -> AuthResponse.Auth
    func checkEmail(email: String) async throws -> AuthResponse.Availability
    func getProfile(token: String) async throws -> AuthResponse.Account
}

final class AccountService: AccountServiceProtocol {
    private let client: NetworkClientProtocol
    
    init(client: NetworkClientProtocol = NetworkClient()) {
        self.client = client
    }
    
    func register(data: AuthRequest.Register) async throws -> AuthResponse.Auth {
        return try await client.request(AuthEndpoint.register(data), authToken: nil)
    }
    
    func checkEmail(email: String) async throws -> AuthResponse.Availability {
        let requestModel = AuthRequest.CheckEmail(email: email)
        return try await client.request(AuthEndpoint.checkEmail(requestModel), authToken: nil)
    }
    
    func getProfile(token: String) async throws -> AuthResponse.Account {
        return try await client.request(AuthEndpoint.getProfile, authToken: token)
    }
}
