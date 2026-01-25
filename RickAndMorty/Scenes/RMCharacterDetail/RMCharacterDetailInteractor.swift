//
//  RMCharacterDetailInteractor.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import Foundation

final class RMCharacterDetailInteractor {
    
    var delegate: (any RMCharacterDetailInteractorDelegate)?
    let service: RMCharacterDetailServiceProtocol
    
    var character: Character!
    
    init(
        character: Character,
        service: RMCharacterDetailServiceProtocol!
    ) {
        self.character = character
        self.service = service
    }
}

extension RMCharacterDetailInteractor: RMCharacterDetailInteractorProtocol {
    
    func loadData() {
//        delegate?.handleOutput(.showLoading(true))
//        service.fetchCharacterDetail(id: character.id) { [weak self] result in
//            guard let self else { return }
//            delegate?.handleOutput(.showLoading(false))
//            switch result {
//            case .success(let character):
//                delegate?.handleOutput(.showCharacter(character))
//            case .failure(let error):
//                print(error)
//            }
//        }
        delegate?.handleOutput(.showCharacter(self.character))
    }
}
