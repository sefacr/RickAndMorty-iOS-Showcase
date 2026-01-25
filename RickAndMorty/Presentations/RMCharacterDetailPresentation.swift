//
//  RMCharacterDetailPresentation.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import Foundation

struct RMCharacterDetailPresentation {
    let name: String
    let statusText: String
    let speciesText: String
    let originText: String
    let locationText: String
    let imageURL: String
    
    init(character: Character) {
        self.name = character.name
        self.statusText = "Status: \(character.status)"
        self.speciesText = "Species: \(character.species)"
        self.originText = "Origin: \(character.origin.name)"
        self.locationText = "Location: \(character.location.name)"
        self.imageURL = character.image
    }
}

