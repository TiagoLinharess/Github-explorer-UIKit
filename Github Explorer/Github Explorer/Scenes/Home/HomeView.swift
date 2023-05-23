//
//  HomeView.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomeViewDelegate: AnyObject {
    
    // MARK: - Delegate
    
    func searchRepository(repositoryName: String)
}

final class HomeView: UIView {
    
    // MARK: - Properties
    
    enum Layout {}
    
    weak var delegate: HomeViewDelegate?
    
    // MARK: - UI Elements
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: LocalizableString.Core.backgroundImageName))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.alpha = Layout.Constants.backgroundImageAlpha
        return imageView
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = LocalizableString.Home.textFieldPlaceholder
        textField.layer.cornerRadius = Layout.Constants.defaultCornerRadius
        textField.layer.borderWidth = Layout.Constants.textFieldBorderWidth
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = Layout.Constants.textFieldPaddingView
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#68C151")
        button.setTitleColor(.white, for: .normal)
        button.setTitle(LocalizableString.Home.searchButtonTitle, for: .normal)
        button.layer.cornerRadius = Layout.Constants.defaultCornerRadius
        button.addAction(.init(handler: { [weak self] _ in
            guard let text = self?.textField.text else { return }
            self?.delegate?.searchRepository(repositoryName: text)
        }), for: .editingChanged)
        return button
    }()
    
    // MARK: - Initialize
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(LocalizableString.Core.initCoder)
    }
}

private extension HomeView {
    
    // MARK: - View Setup
    
    func setup() {
        setupView()
        setupHierarchy()
        setupConstraints()
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubview(backgroundImage)
        addSubview(textField)
        addSubview(button)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Size.extraLarge.rawValue),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            textField.heightAnchor.constraint(equalToConstant: Size.extraLarge.rawValue)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Size.small.rawValue),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            button.heightAnchor.constraint(equalToConstant: Size.extraLarge.rawValue)
        ])
    }
}

extension HomeView.Layout {
    
    // MARK: - Constants
    
    enum Constants {
        static let backgroundImageAlpha: CGFloat = 00.10
        static let textFieldPaddingView: UIView = UIView(frame: CGRect(x: .zero, y: .zero, width: 08.00, height: 20.00))
        static let textFieldBorderWidth: CGFloat = 02.00
        static let defaultCornerRadius: CGFloat = 10.00
    }
}
