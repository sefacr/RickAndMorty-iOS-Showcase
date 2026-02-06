//
//  RMChatacterDetailViewModel.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import Foundation

protocol RMCharacterDetailViewModelProtocol: AnyObject {
    var delegate: RMCharacterDetailViewModelDelegate? { get set }
    func loadData()
}

enum RMCharacterDetailViewModelOutput {
    case showLoading(Bool)
    case displayCharacter(RMCharacterDetailPresentation)
}

protocol RMCharacterDetailViewModelDelegate: AnyObject {
    func handleOutput(_ output: RMCharacterDetailViewModelOutput)
}

final class RMCharacterDetailViewModel: RMCharacterDetailViewModelProtocol {
    
    var delegate: (any RMCharacterDetailViewModelDelegate)?
    
    var character: Character!
    
    private var service: RMCharacterDetailServiceProtocol
    
    init(character: Character!, service: RMCharacterDetailServiceProtocol) {
        self.character = character
        self.service = service
    }
    
    func loadData() {
        delegate?.handleOutput(.showLoading(true))
        service.fetchCharacterDetail(id: character.id) { [weak self] result in
            guard let self else { return }
            delegate?.handleOutput(.showLoading(false))
            switch result {
            case .success(let character):
                self.character = character
                let characterDetailPresentation = RMCharacterDetailPresentation(character: character)
                delegate?.handleOutput(.displayCharacter(characterDetailPresentation))
            case .failure(let error):
                print(error)
            }
        }
    }
}
