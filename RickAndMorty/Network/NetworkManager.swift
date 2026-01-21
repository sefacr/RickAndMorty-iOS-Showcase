//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

protocol NetworkService {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkManager: NetworkService {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        
        guard var components = URLComponents(string: endpoint.baseURL + endpoint.path) else {
            throw NetworkError.invalidURL
        }
        
        if let queryItems = endpoint.queryItems {
            components.queryItems = queryItems.map { URLQueryItem(name: $0.key, value: $0.value)}
        }
        
        guard let url = components.url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("Decoding Hatası: \(error)")
            throw NetworkError.decodingError
        }
    }
}
