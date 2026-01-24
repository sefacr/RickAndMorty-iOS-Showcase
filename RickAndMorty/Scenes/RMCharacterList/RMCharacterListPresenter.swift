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
    
    func loadData() {
        interactor.fetchData()
    }
}

extension RMCharacterListPresenter: RMCharacterListInteractorDelegate {
    
    func didReceiveOutput(_ output: RMCharacterListInteractorOutput) {
        switch output {
        case .setCharacters(let characters):
            view.handleOutput(.setCharacters(characters))
        case .showLoadingIndicator(let isLoading):
            view.handleOutput(.showLoadingIndicator(isLoading))
        }
    }
}
