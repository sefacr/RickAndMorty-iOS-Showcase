//
//  CharacterDetailService.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

protocol CharacterDetailServiceProtocol: AnyObject {
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Character, Error>) -> Void)
}

final class CharacterDetailService: CharacterDetailServiceProtocol {
    
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Character, Error>) -> Void) {
        Task {
            do {
                let character: Character = try await NetworkManager.shared.request(endpoint: RMEndpoint.characterDetail(id: id))
                
                DispatchQueue.main.async {
                    completion(.success(character))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
