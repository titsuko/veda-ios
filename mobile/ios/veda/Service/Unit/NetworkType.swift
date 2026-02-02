//
//  NetworkType.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

import Foundation

struct NetworkConfig {
    let baseURL: URL
    let headers: [String: String]
    
    static let dev = NetworkConfig(
        baseURL: URL(string: "http://project.veda.webtm.ru/api")!,
        headers: ["Content-Type": "application/json"]
    )
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(Error)
    case serverError(statusCode: Int)
    case unauthorized
    case unknown(Error)
}

struct EmptyResponse: Decodable {}
