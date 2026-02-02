//
//  AuthResponse.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

import Foundation

enum AuthResponse {
    struct Account: Decodable, Identifiable {
        var id: String { email }
        let firstName: String
        let lastName: String
        let email: String
        let role: String
        let createdAt: Date?
    }
    
    struct Auth: Decodable {
        let accessToken: String
        let refreshToken: String
        let expiresIn: Int64
    }
    
    struct Availability: Decodable {
        let available: Bool
        let message: String
    }
}
