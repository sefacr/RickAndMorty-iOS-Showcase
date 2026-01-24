//
//  RMCharacterListPresenter.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import Foundation

final class RMCharacterListPresenter {
    
    private let interactor: RMCharacterListInteractorProtocol!
    private let router: RMCharacterListRouterProtocol!
    private unowned let view: RMCharacterListViewProtocol!
    
    private var characters: [RMCharacterListPresentation] = []
    
    init(
        interactor: RMCharacterListInteractorProtocol!,
        view: RMCharacterListViewProtocol!,
        router: RMCharacterListRouterProtocol!
    ) {
        self.interactor = interactor
        self.view = view
        self.router = router
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
    
    func selectCharacter(_ index: Int) {
        interactor.selectCharacter(index)
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
        case .selectCharacter(let character):
            router.navigate(to: .showCharacterDetails(character))
        }
    }
}
