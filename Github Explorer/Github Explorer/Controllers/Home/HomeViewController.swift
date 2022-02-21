//
//  MainPageViewController.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 18/06/21.
//

import UIKit

class HomeViewController: UIViewController {
    var viewModel: HomeViewModelDelegate
    var alertDelegate: CreatableAlertDelegate?
    
    let backgroundImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(imageLiteralResourceName: "background"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.frame = CGRect(x: 200, y: 0, width: 600, height: 400)
        imageView.alpha = 0.1
        
        return imageView
    }()
    
    let searchTextField: UITextField = {
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 20))
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Text your repository here"
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2.0
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.leftView = paddingView
        textField.leftViewMode = .always
        textField.autocapitalizationType = .none
        
        return textField
    }()
    
    let buttonSearch: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = UIColor(hexString: "#68C151")
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Search", for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(apiRequest), for: .touchUpInside)
        return button
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        return spinner
    }()
    
    let spinnerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.isHidden = true
        stackView.backgroundColor = UIColor(hexString: "#68C151")
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        
        return stackView
    }()
    
    let repositoryTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.allowsSelection = true
        table.register(UINib(nibName: RepositoryCell.identifier, bundle: nil), forCellReuseIdentifier: RepositoryCell.identifier)
        table.rowHeight = 140
        
        return table
    }()
    
    init(viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel()
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHierarchy()
        setupConstraints()
        setupTableView()
        setupBindings()
    }
    
    private func setup() {
        view.backgroundColor = .white
        alertDelegate = self
        viewModel.alert = self
    }
    
    private func setupHierarchy() {
        view.addSubview(backgroundImage)
        view.addSubview(searchTextField)
        view.addSubview(repositoryTableView)
        view.addSubview(buttonSearch)
        view.addSubview(spinnerStackView)
        spinnerStackView.addArrangedSubview(spinner)
    }
}

extension HomeViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            searchTextField.widthAnchor.constraint(equalToConstant: 300),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            buttonSearch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonSearch.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            buttonSearch.widthAnchor.constraint(equalToConstant: 300),
            buttonSearch.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            spinnerStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinnerStackView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 10),
            spinnerStackView.widthAnchor.constraint(equalToConstant: 300),
            spinnerStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            repositoryTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            repositoryTableView.topAnchor.constraint(equalTo: buttonSearch.bottomAnchor, constant: 50),
            repositoryTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            repositoryTableView.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}

//MARK:- methods
extension HomeViewController {
    private func setupBindings() {
        viewModel.viewStatus.bind { status in
            switch status {
            case .loaded:
                self.hideLoading()
                break
            case .loading:
                self.showLoading()
                break
            case .error(let error):
                self.dispatchAlertError(error: error)
                break
            default:
                break
            }
        }
    }
    
    @objc func apiRequest() {
        guard let repositoryName = searchTextField.text else { return }
        viewModel.getRepository(repositoryName: repositoryName)
    }
    
    private func hideLoading() {
        self.buttonSearch.isHidden = false
        self.spinnerStackView.isHidden = true
        self.repositoryTableView.reloadData()
    }
    
    private func showLoading() {
        self.buttonSearch.isHidden = true
        self.spinnerStackView.isHidden = false
    }
    
    private func dispatchAlertError(error: String) {
        self.alertDelegate?.createOkAlert(title: "Error", message: error)
        self.hideLoading()
    }
}

//MARK:- NavigationController Style
extension HomeViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
}

//MARK:- TableView data source
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    private func setupTableView() {
        repositoryTableView.dataSource = self
        repositoryTableView.delegate = self
        
        repositoryTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        repositoryTableView.backgroundColor = UIColor(white: 1, alpha: 0)
        repositoryTableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier, for: indexPath) as! RepositoryCell
        cell.configure(repository: viewModel.repositories[indexPath.row])
        return cell
    }
}

extension HomeViewController: CreatableAlertDelegate {}
