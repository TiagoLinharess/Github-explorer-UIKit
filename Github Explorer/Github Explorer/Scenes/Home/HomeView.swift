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
    private var repositories: [HomeModel.Repository.ViewModel] = []
    
    // MARK: - UI Elements
    
    private lazy var githubLogo: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: LocalizableString.Core.logoImage))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
        button.backgroundColor = .greenPrimary
        button.setTitleColor(.white, for: .normal)
        button.setTitle(LocalizableString.Home.searchButtonTitle, for: .normal)
        button.layer.cornerRadius = Layout.Constants.defaultCornerRadius
        button.addAction(.init(handler: { [weak self] _ in
            guard let text = self?.textField.text else { return }
            self?.delegate?.searchRepository(repositoryName: text)
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .greenPrimary
        view.color = .white
        view.layer.cornerRadius = Layout.Constants.defaultCornerRadius
        view.startAnimating()
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        return tableView
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
    
    // MARK: - Public methods
    
    func displaySuccess(viewModel: HomeModel.Repository.ViewModel) {
        resetDisplay()
        repositories.append(viewModel)
        tableView.reloadData()
    }
    
    func resetDisplay() {
        loadingView.isHidden = true
        button.isHidden = false
    }
    
    func displayLoading() {
        loadingView.isHidden = false
        button.isHidden = true
    }
}

private extension HomeView {
    
    // MARK: - View Setup
    
    func setup() {
        setupView()
        setupHierarchy()
        setupConstraints()
        resetDisplay()
    }
    
    func setupView() {
        backgroundColor = .white
    }
    
    func setupHierarchy() {
        addSubview(backgroundImage)
        addSubview(githubLogo)
        addSubview(textField)
        addSubview(button)
        addSubview(loadingView)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            githubLogo.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Size.small.rawValue),
            githubLogo.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: githubLogo.bottomAnchor, constant: Size.extraLarge.rawValue),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            textField.heightAnchor.constraint(equalToConstant: Layout.Constants.textFieldHeight)
        ])
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Size.small.rawValue),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            button.heightAnchor.constraint(equalToConstant: Layout.Constants.componentsHeight)
        ])
        
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: Size.small.rawValue),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            loadingView.heightAnchor.constraint(equalToConstant: Layout.Constants.componentsHeight)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: loadingView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.small.rawValue),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.small.rawValue),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: RepositoryCell.identifier,
            for: indexPath
        ) as? RepositoryCell else { fatalError() }
        
        cell.setup(viewModel: repositories[indexPath.row])
        
        return cell
    }
}

extension HomeView.Layout {
    
    // MARK: - Constants
    
    enum Constants {
        static let backgroundImageAlpha: CGFloat = 00.10
        static let textFieldPaddingView: UIView = UIView(frame: CGRect(x: .zero, y: .zero, width: 08.00, height: 20.00))
        static let textFieldBorderWidth: CGFloat = 02.00
        static let defaultCornerRadius: CGFloat = 10.00
        static let componentsHeight: CGFloat = 52.00
        static let textFieldHeight: CGFloat = 44.00
    }
}
