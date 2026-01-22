//
//  RMCharacterListViewController.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 22.01.2026.
//

import UIKit

final class RMCharacterListViewController: UIViewController {
    
    var presenter: RMCharacterListPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadData()
    }
}
