//
//  RMCharacterDetailPresenter.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import Foundation

final class RMCharacterDetailPresenter: RMCharacterDetailInteractorDelegate {
    
    private var interactor: RMCharacterDetailInteractorProtocol!
    private unowned let view: RMCharacterDetailViewProtocol!
    
    init(
        interactor: RMCharacterDetailInteractorProtocol!,
        view: RMCharacterDetailViewProtocol!
    ) {
        self.interactor = interactor
        self.view = view
        interactor.delegate = self
    }
    
    func handleOutput(_ output: RMCharacterDetailInteractorOutput) {
        switch output {
        case .showCharacter(let character):
            let presentation = RMCharacterDetailPresentation(character: character)
            view.handleOutput(.showCharacter(presentation))
        case .showLoading(let isLoading):
            view.handleOutput(.showLoading(isLoading))
        }
    }
}

extension RMCharacterDetailPresenter: RMCharacterDetailPresenterProtocol {
    
    func loadData() {
        interactor.loadData()
    }
}
