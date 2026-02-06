//
//  RMCharacterListBuilder.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import Foundation

class RMCharacterListBuilder {
    
    static func make() -> RMCharacterListViewController {
        
        let viewController = RMCharacterListViewController()
        let service = RMCharacterListService()
        let viewModel = RMCharacterListViewModel(service: service)
        viewController.viewModel = viewModel
        
        return viewController
    }
    
}
