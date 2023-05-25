//
//  HomePresenter.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

typealias HomePresenterInput = HomeInteractorOutput

typealias HomePresenterOutput = HomeViewControllerInput

final class HomePresenter {
    
    // MARK: - Properties
    
    weak var viewController: HomePresenterOutput?
}

extension HomePresenter: HomePresenterInput {
    
    // MARK: - Home Presenting

    func presentLoading() {
        viewController?.displayLoading()
    }
    
    func presentSuccess(response: HomeModel.Repository.Response) {
        viewController?.displaySuccess(viewModel: .init(from: response))
    }
    
    func presentError(error: WorkerError) {
        viewController?.displayError(error: error)
    }
}
