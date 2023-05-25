//
//  HomeViewController.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 18/06/21.
//

import UIKit

protocol HomeViewControllerInput: AnyObject {
    
    func displayError(error: WorkerError)
    func displayLoading()
    func displaySuccess(viewModel: HomeModel.Repository.ViewModel)
}

protocol HomeViewControllerOutput: AnyObject {
    
    func searchRepository(respositoryName: String)
}

final class HomeViewController<Router: HomeRouterInput, Interactor: HomeViewControllerOutput, CustomView: HomeView>: UIViewController {
    
    // MARK: - Properties
    
    private let customView: CustomView
    private let interactor: Interactor
    private let router: Router
    
    // MARK: - Initialize
    
    init(
        customView: CustomView,
        interactor: Interactor,
        router: Router
    ) {
        self.customView = customView
        self.interactor = interactor
        self.router = router
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

extension HomeViewController: HomeViewControllerInput {
    
    // MARK: - HomeViewController Input
    
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
    
    func displayError(error: WorkerError) {
        DispatchQueue.main.async {
            self.customView.resetDisplay()
            self.router.handleError(error: error)
        }
    }
}
