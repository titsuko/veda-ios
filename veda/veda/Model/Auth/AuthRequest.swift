//
//  AuthRequest.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

enum AuthRequest {
    struct CheckEmail: Encodable {
        let email: String
    }
    
    struct Refresh: Encodable {
        let refreshToken: String
    }
    
    struct Login: Encodable {
        let email: String
        let password: String
    }
    
    struct Register: Encodable {
        let fullName: String
        let email: String
        let password: String
    }
}
