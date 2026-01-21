//
//  CharacterListViewController.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import UIKit

final class CharacterListViewController: UIViewController {
    
    private let service: CharacterListServiceProtocol = CharacterListService()
    private var characters: [Character] = []
    private var isLoading = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: CharacterCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchCharacters()
    }
    
    private func setupUI() {
        title = "Rick and Morty"
        view.backgroundColor = .systemBackground
        
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func fetchCharacters() {
        guard !isLoading else { return }
        isLoading = true
        loadingIndicator.startAnimating()
        
        service.fetchCharactersList { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            self.loadingIndicator.stopAnimating()
            
            switch result {
            case .success(let newCharacters):
                self.characters.append(contentsOf: newCharacters)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching characters: \(error)")
            }
        }
    }
}

extension CharacterListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as? CharacterCell else {
            return UICollectionViewCell()
        }
        
        let character = characters[indexPath.item]
        cell.configure(with: character)
        return cell
    }
}

extension CharacterListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16 * 3
        let availableWidth = collectionView.frame.width - padding
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth + 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.item]
        let detailVC = CharacterDetailViewController(characterId: character.id)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension CharacterListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 2 {
            fetchCharacters()
        }
    }
}
