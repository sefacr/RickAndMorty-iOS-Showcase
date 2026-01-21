//
//  Endpoint.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any]? { get }
    var queryItems: [String: String]? { get }
}

extension Endpoint {
    var header: [String: String]? { return nil }
    var body: [String: Any]? { return nil }
    var queryItems: [String: String]? { return nil }
}
