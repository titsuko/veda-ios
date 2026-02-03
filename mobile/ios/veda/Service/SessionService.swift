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

final class SessionService: SessionServiceProtocol {
    private let config: NetworkConfig
    private let session: URLSession

    init(config: NetworkConfig, session: URLSession = .shared) {
        self.config = config
        self.session = session
    }

    func login(data: AuthRequest.Login) async throws -> AuthResponse.Auth {
        let client = NetworkClient(config: config)
        return try await client.request(AuthEndpoint.login(data), authToken: nil)
    }

    func logout(token: String) async throws {
        let client = NetworkClient(config: config)
        _ = try await client.request(
            AuthEndpoint.logout(AuthRequest.Refresh(refreshToken: token)),
            authToken: nil
        ) as EmptyResponse
    }

    func refresh(token: String) async throws -> AuthResponse.Auth {
        let client = NetworkClient(config: config)
        return try await client.request(
            AuthEndpoint.refresh(AuthRequest.Refresh(refreshToken: token)),
            authToken: nil
        )
    }
}
