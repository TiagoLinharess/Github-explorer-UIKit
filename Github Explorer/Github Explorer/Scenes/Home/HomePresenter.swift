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
    
    weak var viewController: HomeViewControllerDisplaying?
    
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {

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
