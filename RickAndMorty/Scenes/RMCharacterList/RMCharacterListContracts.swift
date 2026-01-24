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
    var itemCount: Int { get }
    func getPresentation(at index: Int) -> RMCharacterListPresentation
    func loadData()
}

enum RMCharacterListPresenterOutput {
    case setCharacters([RMCharacterListPresentation])
    case showLoadingIndicator(Bool)
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
    case showLoadingIndicator(Bool)
    case setCharacters([Character])
}

protocol RMCharacterListInteractorDelegate: AnyObject {
    func didReceiveOutput(_ output: RMCharacterListInteractorOutput)
}
