//
//  RMCharacterDetailContracts.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import Foundation

// MARK: - Presenter

// View Controller -> Presenter
protocol RMCharacterDetailPresenterProtocol: AnyObject {
    func loadData()
}

enum RMCharacterDetailPresenterOutput {
    case showCharacter(Character)
    case showLoading(Bool)
}

// MARK: - View

// Presenter -> View Controller
protocol RMCharacterDetailViewProtocol: AnyObject {
    func handleOutput(_ output: RMCharacterDetailPresenterOutput)
}

// MARK: - Interactor

// Presenter -> Interactor
protocol RMCharacterDetailInteractorProtocol: AnyObject {
    var delegate: RMCharacterDetailInteractorDelegate? { get set }
    func loadData()
}

enum RMCharacterDetailInteractorOutput {
    case showLoading(Bool)
    case showCharacter(Character)
}

protocol RMCharacterDetailInteractorDelegate: AnyObject {
    func handleOutput(_ output: RMCharacterDetailInteractorOutput)
}
