//
//  CharacterListService.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import Foundation

protocol CharacterListServiceProtocol: AnyObject {
    func fetchCharactersList(completion: @escaping (Result<[Character], Error>) -> Void)
}

final class CharacterListService: CharacterListServiceProtocol {
    
    var currentPage = 1
    var totalPages = 1
    
    func fetchCharactersList(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard currentPage <= totalPages else { return }
        
        Task {
            do {
                let response: RMCharacterResponse = try await NetworkManager.shared.request(endpoint: RMEndpoint.characters(page: currentPage))
                
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.totalPages = response.info.pages
                    self.currentPage += 1
                    completion(.success(response.results))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
