//
//  NetworkClient.swift
//  veda
//
//  Created by Воскобович Максим on 1.02.26.
//

import Foundation

protocol NetworkClientProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint, authToken: String?) async throws -> T
}

final class NetworkClient: NetworkClientProtocol {
    private let config: NetworkConfig
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(config: NetworkConfig = .dev, session: URLSession = .shared) {
        self.config = config
        self.session = session
        
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, authToken: String? = nil) async throws -> T {
        guard let url = URL(string: config.baseURL.absoluteString + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.allHTTPHeaderFields = config.headers
        
        if endpoint.requireAuth, let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        if let body = endpoint.body {
            request.httpBody = try JSONEncoder().encode(body)
        }
        
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.unknown(URLError(.badServerResponse))
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                if T.self == EmptyResponse.self {
                    return EmptyResponse() as! T
                }
                return try decoder.decode(T.self, from: data)
            case 401:
                throw NetworkError.unauthorized
            default:
                throw NetworkError.serverError(statusCode: httpResponse.statusCode)
            }
        } catch let error as DecodingError {
            throw NetworkError.decodingError(error)
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}
