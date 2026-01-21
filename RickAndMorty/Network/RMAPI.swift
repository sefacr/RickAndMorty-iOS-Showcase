//
//  RMAPI.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

enum RMEndpoint: Endpoint {
    
    case characters(page: Int)
    case locations
    case episodes
    
    var baseURL: String {
        return "https://rickandmortyapi.com/api"
    }

    var path: String {
        switch self {
        case .characters: return "/character"
        case .locations: return "/location"
        case .episodes: return "/episode"
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    

    var queryItems: [String : String]? {
        switch self {
        case .characters(let page):
            return ["page": String(page)]
        default:
            return nil
        }
    }
    
    // R&M Header istemiyor ama isteseydi buraya yazardık
    var header: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
