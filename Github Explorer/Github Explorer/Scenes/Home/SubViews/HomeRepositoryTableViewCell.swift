//
//  HomeRepositoryTableViewCell.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 19/06/21.
//

import UIKit

final class HomeRepositoryTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    enum Layout {}
    
    static let identifier = LocalizableString.Home.repositoryTableViewCellIdentifier
    
    // MARK: - UI Elements
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = Size.extraSmall.rawValue
        stackView.backgroundColor = .lightGray
        stackView.layer.cornerRadius = Size.medium.rawValue
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = Layout.Constants.layoutMargins
        return stackView
    }()
    
    private lazy var repoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Size.xBig.rawValue
        return imageView
    }()
    
    private lazy var repoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initialize
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(LocalizableString.Core.initCoder)
    }
}

private extension HomeRepositoryTableViewCell {
    
    // MARK: - View setup
    
    func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        setupHierarchy()
        setupConstraints()
    }
    
    func setupHierarchy() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(repoImageView)
        stackView.addArrangedSubview(repoNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Size.small.rawValue),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Size.small.rawValue),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Size.small.rawValue),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Size.small.rawValue),
            
            repoImageView.widthAnchor.constraint(equalToConstant: Layout.Constants.imageSize),
            repoImageView.heightAnchor.constraint(equalToConstant: Layout.Constants.imageSize),
            repoNameLabel.heightAnchor.constraint(equalToConstant: Size.xxBig.rawValue),
        ])
    }
}

extension HomeRepositoryTableViewCell {
    
    // MARK: - View configure
    
    func configure(viewModel: HomeModel.Repository.ViewModel) {
        repoNameLabel.text = viewModel.fullName
        setRepositoryImage(image: viewModel.owner.avatarUrl)
    }
    
    private func setRepositoryImage(image: String) {
        if let url_image = URL(string: image) {
            repoImageView.load(url: url_image)
        } else {
            repoImageView.image = UIImage(named: LocalizableString.Core.backgroundImageName)
        }
    }
}

extension HomeRepositoryTableViewCell.Layout {
    
    // MARK: - Constants
    
    enum Constants {
        
        static let imageSize: CGFloat = 60.00
        static let layoutMargins = NSDirectionalEdgeInsets(
            top: Size.medium.rawValue,
            leading: Size.medium.rawValue,
            bottom: Size.extraSmall.rawValue,
            trailing: Size.medium.rawValue
        )
    }
}
