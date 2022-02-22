//
//  RepositoryCell.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 19/06/21.
//

import UIKit

class RepositoryCell: UITableViewCell {
    static let identifier = "RepositoryCell"
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.backgroundColor = UIColor(hexString: "#EBEDEF")
        stackView.layer.cornerRadius = 20
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 10, trailing: 20)
        return stackView
    }()
    
    var repoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 30
        return imageView
    }()
    
    var repoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(repository: Repository) {
        selectionStyle = .none
        backgroundColor = UIColor(white: 1, alpha: 0)
        setupHierarchy()
        setupConstraints()
        configure(repository: repository)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(repoImage)
        stackView.addArrangedSubview(repoName)
    }
    
    private func configure(repository: Repository) {
        repoName.text = repository.full_name
        setRepositoryImage(image: repository.owner.avatar_url)
    }
    
    private func setRepositoryImage(image: String) {
        if let url_image = URL(string: image) {
            repoImage.load(url: url_image)
        } else {
            repoImage.image = UIImage(named: "background")
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 280),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            repoImage.widthAnchor.constraint(equalToConstant: 60),
            repoImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
