//
//  SessionManager.swift
//  veda
//
//  Created by Евгений Петрукович on 2/3/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class SessionManager: ObservableObject {
    static let shared = SessionManager()

    @Published var isLoggedIn: Bool = false

    private let accessTokenKey = "accessToken"
    private let refreshTokenKey = "refreshToken"

    private init() {
        if let _ = KeychainHelper.read(accessTokenKey) {
            isLoggedIn = true
        }
    }

    var accessToken: String? {
        KeychainHelper.read(accessTokenKey)
    }

    var refreshToken: String? {
        KeychainHelper.read(refreshTokenKey)
    }

    func saveTokens(accessToken: String, refreshToken: String) {
        _ = KeychainHelper.save(accessToken, forKey: accessTokenKey)
        _ = KeychainHelper.save(refreshToken, forKey: refreshTokenKey)
        isLoggedIn = true
    }

    func logout() {
        KeychainHelper.delete(accessTokenKey)
        KeychainHelper.delete(refreshTokenKey)
        isLoggedIn = false
    }
}
