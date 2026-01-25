//
//  RMCharacterListService.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 24.01.2026.
//

import Foundation

protocol RMCharacterListServiceProtocol: AnyObject {
    func fetchCharactersList(completion: @escaping (Result<[Character], Error>) -> Void)
}

final class RMCharacterListService: RMCharacterListServiceProtocol {
    
    var currentPage = 1
    var totalPages: Int? = nil
    private var isLoading = false
    
    func fetchCharactersList(completion: @escaping (Result<[Character], Error>) -> Void) {
        guard !isLoading, currentPage <= totalPages ?? 1 else { return }
        
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
