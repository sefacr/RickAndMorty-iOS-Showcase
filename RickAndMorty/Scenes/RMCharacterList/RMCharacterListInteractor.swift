//
//  RMCharacterListInteractor.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import Foundation

final class RMCharacterListInteractor {
    
    weak var delegate: RMCharacterListInteractorDelegate?
    var service: RMCharacterListServiceProtocol!
    
    init(service: RMCharacterListServiceProtocol!) {
        self.service = service
    }
}

extension RMCharacterListInteractor: RMCharacterListInteractorProtocol {
    
    func fetchData() {
        self.delegate?.didReceiveOutput(.showLoadingIndicator(true))
        service.fetchCharactersList { [weak self] result in
            guard let self else { return }
            delegate?.didReceiveOutput(.showLoadingIndicator(false))
            switch result {
            case .success(let characters):
                self.delegate?.didReceiveOutput(.setCharacters(characters))
            case .failure(let error):
                print(error)
            }
        }
    }
}
