//
//  RMCharacterListContracts.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import Foundation

// MARK: - Router


// MARK: - Presenter

protocol RMCharacterListPresenterProtocol: AnyObject {
    func loadData()
}

enum RMCharacterListPresenterOutput {
    case setCharacters([Character])
}

// MARK: - View

protocol RMCharacterListViewProtocol: AnyObject {
    func handleOutput(_ output: RMCharacterListPresenterOutput)
}

// MARK: - Interactor

protocol RMCharacterListInteractorProtocol: AnyObject {
    var delegate: RMCharacterListInteractorDelegate? { get set } 
    func fetchData()
}

enum RMCharacterListInteractorOutput {
    case setCharacters([Character])
}

protocol RMCharacterListInteractorDelegate: AnyObject {
    func didReceiveOutput(_ output: RMCharacterListInteractorOutput)
}
