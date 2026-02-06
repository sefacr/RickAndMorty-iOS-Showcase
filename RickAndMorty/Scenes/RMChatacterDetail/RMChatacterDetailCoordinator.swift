//
//  RMChatacterDetailCoordinator.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import UIKit

protocol RMCharacterDetailCoordinatorFinishDelegate: AnyObject {
    func showDetailDidFinish()
}

final class RMCharacterDetailCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    weak var mainViewController: RMCharacterDetailViewController?
    
    weak var finishDelegate: RMCharacterDetailCoordinatorFinishDelegate?
    
    var viewModel: RMCharacterDetailViewModelProtocol
    
    init(
        navigationController: UINavigationController,
        viewModel: RMCharacterDetailViewModelProtocol
    ) {
        self.navigationController = navigationController
        self.viewModel = viewModel
    }
    
    func start() {
        let viewController = RMCharacterDetailBuilder.make(viewModel: viewModel)
        viewController.coordinator = self
        self.mainViewController = viewController
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func didFinish() {
        finishDelegate?.showDetailDidFinish()
    }
}

