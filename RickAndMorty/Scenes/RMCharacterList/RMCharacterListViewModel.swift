//
//  RMCharacterListViewModel.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import Foundation

protocol RMCharacterListViewModelProtocol: AnyObject {
    var delegate: RMCharacterListViewModelDelegate? { get set }
    func loadData()
    func selectCharacter(at index: Int)
}

enum RMCharacterListViewModelOutput {
    case displayCharacters([RMCharacterListPresentation])
    case showLoading(Bool)
}

protocol RMCharacterListViewModelDelegate: AnyObject {
    func handleOutput(_ output: RMCharacterListViewModelOutput)
    func navigate(to route: RMCharacterListRoute)
}

final class RMCharacterListViewModel: RMCharacterListViewModelProtocol {
    
    weak var delegate: (any RMCharacterListViewModelDelegate)?
    
    private let service: RMCharacterListServiceProtocol
    
    private var characters: [Character] = []
    
    init(service: RMCharacterListServiceProtocol) {
        self.service = service
    }
    
    func loadData() {
        delegate?.handleOutput(.showLoading(true))
        service.fetchCharactersList { [weak self] result in
            guard let self else { return }
            self.delegate?.handleOutput(.showLoading(false))
            switch result {
            case .success(let characters):
                self.characters.append(contentsOf: characters)
                let cellPresentations: [RMCharacterListPresentation] = characters.map(
                    { RMCharacterListPresentation(character: $0)}
                )
                delegate?.handleOutput(.displayCharacters(cellPresentations))
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func selectCharacter(at index: Int) {
        let character = characters[index]
        delegate?.navigate(
            to: .detail(
                RMCharacterDetailViewModel(
                    character: character,
                    service: RMCharacterDetailService()
                )
            )
        )
    }
}
