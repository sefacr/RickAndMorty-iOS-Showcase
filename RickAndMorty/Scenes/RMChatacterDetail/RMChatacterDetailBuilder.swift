//
//  RMChatacterDetailBuilder.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import Foundation

final class RMCharacterDetailBuilder {
    
    static func make(viewModel: RMCharacterDetailViewModelProtocol) -> RMCharacterDetailViewController {
        
        let viewController = RMCharacterDetailViewController()
        viewController.viewModel = viewModel
        
        return viewController
    }
}
