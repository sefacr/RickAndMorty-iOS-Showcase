//
//  NetworkTypes.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PATCH"
}

enum NetworkError: String, Error {
    case invalidURL = "URL oluşturulamadı."
    case unableToComplete = "İstek tamamlanamadı. İnternet bağlantısını kontrol edin."
    case invalidResponse = "Sunucudan geçersiz yanıt alındı."
    case invalidData = "Data okunamadı."
    case decodingError = "Data modele çevrilemedi."
}

