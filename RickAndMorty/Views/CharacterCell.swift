//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Sefa Acar on 21.01.2026.
//

import UIKit

final class CharacterCell: UICollectionViewCell {
    
    static let identifier = "CharacterCell"
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let speciesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .tertiaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(characterImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubview(speciesLabel)
        
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 4
        contentView.layer.shadowOpacity = 0.1
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            characterImageView.heightAnchor.constraint(equalTo: characterImageView.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: characterImageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            speciesLabel.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 4),
            speciesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            speciesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            speciesLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with character: Character) {
        nameLabel.text = character.name
        statusLabel.text = character.status
        speciesLabel.text = character.species
        
        if let url = URL(string: character.image) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                guard let data = data, let image = UIImage(data: data) else { return }
                DispatchQueue.main.async {
                    self?.characterImageView.image = image
                }
            }.resume()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
        speciesLabel.text = nil
    }
}
