//
//  RMCharacterListPresenter.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import Foundation

final class RMCharacterListPresenter {
    
    private let interactor: RMCharacterListInteractorProtocol!
    private unowned let view: RMCharacterListViewProtocol!
    
    private var characters: [RMCharacterListPresentation] = []
    
    init(
        interactor: RMCharacterListInteractorProtocol!,
        view: RMCharacterListViewProtocol!
    ) {
        self.interactor = interactor
        self.view = view
        self.interactor.delegate = self
    }
}

extension RMCharacterListPresenter: RMCharacterListPresenterProtocol {
        
    var itemCount: Int {
        return characters.count
    }
    
    func getPresentation(at index: Int) -> RMCharacterListPresentation {
        return characters[index]
    }
    
    func loadData() {
        interactor.fetchData()
    }
}

extension RMCharacterListPresenter: RMCharacterListInteractorDelegate {
    
    func didReceiveOutput(_ output: RMCharacterListInteractorOutput) {
        switch output {
        case .setCharacters(let characters):
            let cellPresentation = characters.map({RMCharacterListPresentation(character: $0)})
            self.characters.append(contentsOf: cellPresentation)
            view.handleOutput(.setCharacters(cellPresentation))
        case .showLoadingIndicator(let isLoading):
            view.handleOutput(.showLoadingIndicator(isLoading))
        }
    }
}
