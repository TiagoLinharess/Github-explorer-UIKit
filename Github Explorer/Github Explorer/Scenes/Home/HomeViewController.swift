//
//  HomeViewController.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 18/06/21.
//

import UIKit

protocol HomeViewControllerDisplaying: AnyObject {
    
    func resetDisplay()
    func displayLoading()
    func displaySuccess(viewModel: HomeModel.Repository.ViewModel)
}

final class HomeViewController<Interactor: HomeInteracting, CustomView: HomeView>: UIViewController {
    
    // MARK: - Properties
    
    private let customView: CustomView
    private let interactor: Interactor
    
    // MARK: - Initialize
    
    init(
        customView: CustomView,
        interactor: Interactor
    ) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(LocalizableString.Core.initCoder)
    }
    
    // MARK: - View life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension HomeViewController {
    
    // MARK: - View setup
    
    func setupView() {
        customView.delegate = self
        view = customView
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeViewController: HomeViewDelegate {
    
    // MARK: - HomeView Delegate
    
    func searchRepository(repositoryName: String) {
        interactor.searchRepository(respositoryName: repositoryName)
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    
    // MARK: - HomeViewController Displaying
    
    func resetDisplay() {
        DispatchQueue.main.async {
            self.customView.resetDisplay()
        }
    }
    
    func displayLoading() {
        DispatchQueue.main.async {
            self.customView.displayLoading()
        }
    }
    
    func displaySuccess(viewModel: HomeModel.Repository.ViewModel) {
        DispatchQueue.main.async {
            self.customView.displaySuccess(viewModel: viewModel)
        }
    }
}
