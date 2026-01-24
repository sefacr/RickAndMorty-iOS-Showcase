//
//  RMCharacterListRouter.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import UIKit

final class RMCharacterListRouter: RMCharacterListRouterProtocol {
    
    private unowned let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func navigate(to route: RMCharacterListRoute) {
        switch route {
        case .showCharacterDetails(let character):
            let vc = UIViewController()
            self.view.show(vc, sender: nil)
        }
    }
}
