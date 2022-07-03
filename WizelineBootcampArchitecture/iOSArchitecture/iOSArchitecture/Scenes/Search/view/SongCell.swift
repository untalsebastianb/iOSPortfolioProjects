//
//  SongCell.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import UIKit

final class SongCell: UITableViewCell {
    
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
    
    private let downloadImageView: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 7, weight: .regular)
        let image = UIImage(systemName: "arrow.down", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.backgroundColor = #colorLiteral(red: 0.1137254902, green: 0.7254901961, blue: 0.3294117647, alpha: 1)
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
        [nameLabel, artistLabel, downloadImageView, moreButton].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            downloadImageView.widthAnchor.constraint(equalToConstant: 14),
            downloadImageView.heightAnchor.constraint(equalToConstant: 14),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            downloadImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            downloadImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            downloadImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            artistLabel.centerYAnchor.constraint(equalTo: downloadImageView.centerYAnchor),
            artistLabel.leadingAnchor.constraint(equalTo: downloadImageView.trailingAnchor, constant: 8),
            artistLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            moreButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            moreButton.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            moreButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            moreButton.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func configureUI(with song: Song) {
        nameLabel.text = song.name
        artistLabel.text = song.artist
    }
}
