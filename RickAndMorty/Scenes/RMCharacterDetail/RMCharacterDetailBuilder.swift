//
//  RMCharacterDetailBuilder.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 25.01.2026.
//

import UIKit

final class RMCharacterDetailBuilder {
    
    static func make(character: Character) -> RMCharacterDetailViewController {
        
        let viewController = RMCharacterDetailViewController(navigationTitle: character.name)
        let service = RMCharacterDetailService()
        let interactor = RMCharacterDetailInteractor(character: character, service: service)
        let presenter = RMCharacterDetailPresenter(interactor: interactor ,view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
