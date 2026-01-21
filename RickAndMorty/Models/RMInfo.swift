//
//  RMInfo.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

struct RMInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
