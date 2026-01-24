//
//  RMCharacterListBuilder.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 24.01.2026.
//

import UIKit

final class RMCharacterListBuilder {
    
    static func make() -> RMCharacterListViewController {
        
        let viewController = RMCharacterListViewController()
        let service = RMCharacterListService()
        let interactor = RMCharacterListInteractor(service: service)
        let presenter = RMCharacterListPresenter(interactor: interactor, view: viewController)
        viewController.presenter = presenter
        
        return viewController
    }
}
