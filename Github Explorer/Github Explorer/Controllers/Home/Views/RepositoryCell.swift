//
//  RepositoryCell.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 19/06/21.
//

import UIKit
import CoreData

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
        let image = UIImageView()
        image.makeRounded()
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    var repoName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    func configure(repository: NSManagedObject) {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(repoImage)
        stackView.addArrangedSubview(repoName)
        setupLayout()
        
        let url_image = URL(string: (repository.value(forKey: "full_name") as? String)!)
        self.repoName.text = repository.value(forKey: "name") as? String
        self.repoImage.load(url: url_image!)
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        self.selectionStyle = .none
    }
    
    private func setupLayout() {
        
        // Stack View
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: 280),
            stackView.heightAnchor.constraint(equalToConstant: 120),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
        
        // Image
        NSLayoutConstraint.activate([
            repoImage.widthAnchor.constraint(equalToConstant: 60),
            repoImage.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
