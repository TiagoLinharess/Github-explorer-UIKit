//
//  HomePresenter.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomePresenting {
    
    func presentLoading()
    func presentSuccess(response: HomeModel.Repository.Response)
    func presentError(error: WorkerError)
}

final class HomePresenter {
    
    // MARK: - Properties
    
    weak var viewController: HomeViewControllerDisplaying?
    
    private let coordinator: HomeCoordinating
    
    // MARK: - Initialize
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    
    // MARK: - Home Presenting

    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func presentSuccess(response: HomeModel.Repository.Response) {
        viewController?.displaySuccess(viewModel: .init(from: response))
    }
    
    func presentError(error: WorkerError) {
        viewController?.resetDisplay()
        coordinator.handleError(error: error)
    }
}
