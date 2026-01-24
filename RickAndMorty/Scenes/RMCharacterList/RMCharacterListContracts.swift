//
//  RMCharacterListContracts.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import Foundation

// MARK: - Router

enum RMCharacterListRoute {
    case showCharacterDetails(Character)
}

protocol RMCharacterListRouterProtocol: AnyObject {
    func navigate(to route: RMCharacterListRoute)
}

// MARK: - Presenter

protocol RMCharacterListPresenterProtocol: AnyObject {
    var itemCount: Int { get }
    func getPresentation(at index: Int) -> RMCharacterListPresentation
    func loadData()
    func selectCharacter(_ index: Int)
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
    func selectCharacter(_ index: Int)
}

enum RMCharacterListInteractorOutput {
    case showLoadingIndicator(Bool)
    case setCharacters([Character])
    case selectCharacter(Character)
}

protocol RMCharacterListInteractorDelegate: AnyObject {
    func didReceiveOutput(_ output: RMCharacterListInteractorOutput)
}
