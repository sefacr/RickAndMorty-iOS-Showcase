//
//  RMCharacterListCoordinator.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import UIKit

final class RMCharacterListCoordinator: Coordinator {
    
    enum RMCharacterListChildCoordinators {
        case characterDetail
    }
    
    weak var navigationController: UINavigationController!
    weak var mainViewController: RMCharacterListViewController?
    private var childCoordinators: [RMCharacterListChildCoordinators: Coordinator] = [:]
    
    init(navigationController: UINavigationController!) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = RMCharacterListBuilder.make()
        viewController.coordinator = self
        mainViewController = viewController
        if navigationController.viewControllers.isEmpty {
            navigationController.setViewControllers([viewController], animated: true)
        }
    }
    
    func handle(route: RMCharacterListRoute) {
        switch route {
        case .detail(let viewModel):
            guard mainViewController != nil else {
                start()
                return
            }
            let characterDetailCoordinator = RMCharacterDetailCoordinator(
                navigationController: navigationController,
                viewModel: viewModel
            )
            characterDetailCoordinator.finishDelegate = self
            childCoordinators[.characterDetail] = characterDetailCoordinator
            characterDetailCoordinator.start()
        }
    }
}

extension RMCharacterListCoordinator: RMCharacterDetailCoordinatorFinishDelegate {
    func showDetailDidFinish() {
        childCoordinators.removeValue(forKey: .characterDetail)
    }
}
