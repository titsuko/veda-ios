//
//  Endpoint.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

protocol Endpoint {
    var path: String { get }
    var method: String { get }
    var body: Encodable? { get }
    var requireAuth: Bool { get }
}

enum AuthEndpoint: Endpoint {
    case login(AuthRequest.Login)
    case logout(AuthRequest.Refresh)
    case refresh(AuthRequest.Refresh)
    
    case register(AuthRequest.Register)
    case getProfile
    case checkEmail(AuthRequest.CheckEmail)
    
    var path: String {
        switch self {
        case .login:        return "/sessions"
        case .logout:       return "/sessions/logout"
        case .refresh:      return "/sessions/refresh"
        case .register:     return "/accounts"
        case .getProfile:   return "/accounts/me"
        case .checkEmail:   return "/accounts/check-email"
        }
    }
    
    var method: String {
        switch self {
        case .getProfile: return "GET"
        case .logout: return "DELETE"
        default: return "POST"
        }
    }
    
    var body: Encodable?{
        switch self {
        case .login(let data): return data
        case .logout(let data), .refresh(let data): return data
        case .register(let data): return data
        case .checkEmail(let data): return data
        case .getProfile: return nil
        }
    }
    
    var requireAuth: Bool {
        switch self {
        case .logout, .getProfile: return true
        default: return false
        }
    }
}
