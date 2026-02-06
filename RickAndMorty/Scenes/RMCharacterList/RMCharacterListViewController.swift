//
//  RMCharacterListViewController.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 6.02.2026.
//

import UIKit

enum RMCharacterListRoute {
    case detail(RMCharacterDetailViewModelProtocol)
}

final class RMCharacterListViewController: UIViewController {
    
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
        return collectionView
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    var viewModel: RMCharacterListViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }
    
    var cellPresentation: [RMCharacterListPresentation] = []
    
    var coordinator: RMCharacterListCoordinator?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        collectionView.delegate = self
        collectionView.dataSource = self
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupView()
        
        viewModel.loadData()
    }
    
    private func setupNavigationBar() {
        if #available(iOS 26.0, *) {
            collectionView.topEdgeEffect.style = .hard
        }
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.title = "Popular TV Shows"
        
        view.addSubview(collectionView)
        view.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

// MARK: - Delegate

extension RMCharacterListViewController: RMCharacterListViewModelDelegate {
    
    func handleOutput(_ output: RMCharacterListViewModelOutput) {
        switch output {
        case .displayCharacters(let characters):
            self.cellPresentation.append(contentsOf: characters)
            collectionView.reloadData()
        case .showLoading(let isLoading):
            if isLoading {
                loadingIndicator.startAnimating()
            }else {
                loadingIndicator.stopAnimating()
            }
        }
    }
    
    func navigate(to route: RMCharacterListRoute) {
        switch route {
        case .detail(let viewModel):
            coordinator?.handle(route: .detail(viewModel))
        }
    }
}


// MARK: - UICollectionViewDelegate, DataSourece, FlowLayout

extension RMCharacterListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height * 2 {
            self.viewModel.loadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellPresentation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCell.identifier, for: indexPath) as! CharacterCell
        
        let cellPresentation = cellPresentation[indexPath.item]
        
        cell.configure(presentation: cellPresentation)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = 3
        let spacing: CGFloat = 10
        
        let totalSpacing = (itemsPerRow - 1) * spacing
        let availableWidth = collectionView.bounds.width - totalSpacing
        let widthPerItem = floor(availableWidth / itemsPerRow)
        let heightPerItem = widthPerItem * 1.5
        
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectCharacter(at: indexPath.item)
    }
}
