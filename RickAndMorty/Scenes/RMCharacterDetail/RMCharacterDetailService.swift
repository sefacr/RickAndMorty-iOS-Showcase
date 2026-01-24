//
//  RMCharacterDetailService.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import Foundation

protocol RMCharacterDetailServiceProtocol: AnyObject {
    func fetchCharacterDetail(id: Int, completion: @escaping (Result<Character, Error>) -> Void)
}

final class RMCharacterDetailService: RMCharacterDetailServiceProtocol {
    
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
