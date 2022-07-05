//
//  AlbumCellTableViewCell.swift
//  iOSArchitecture
//
//  Created by Sebastian on 4/07/22.
//

import UIKit

import UIKit

final class AlbumCellTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let albumStack: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 8, weight: .regular)
        let image = UIImage(systemName: "square.stack.3d.down.right", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 7
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "ellipsis")
        button.setImage(image, for: .normal)
        button.tintColor = .gray
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = .black
        [nameLabel, artistLabel, albumStack, moreButton].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            albumStack.widthAnchor.constraint(equalToConstant: 14),
            albumStack.heightAnchor.constraint(equalToConstant: 14),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            albumStack.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            albumStack.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            albumStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            artistLabel.centerYAnchor.constraint(equalTo: albumStack.centerYAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: albumStack.trailingAnchor, constant: 8),
            artistLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            moreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moreButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            moreButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureUI(with album: Album) {
        nameLabel.text = album.collectionName ?? album.artistName
        artistLabel.text = album.artistName
    }
}
