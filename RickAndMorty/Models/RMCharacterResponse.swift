//
//  RMCharacterResponse.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

struct RMCharacterResponse: Codable {
    let info: RMInfo
    let results: [Character]
}
