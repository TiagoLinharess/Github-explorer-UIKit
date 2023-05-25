//
//  HomeInteractor.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import Foundation

typealias HomeIntercatorInput = HomeViewControllerOutput

protocol HomeInteractorOutput {
    
    func presentLoading()
    func presentSuccess(response: HomeModel.Repository.Response)
    func presentError(error: WorkerError)
}

final class HomeInteractor {
    
    // MARK: - Properties
    
    private let presenter: HomeInteractorOutput
    private let worker: GithubRepositoryWorking
    
    // MARK: - Initialize
    
    init(presenter: HomePresenterInput, worker: GithubRepositoryWorking = GithubRepositoryWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension HomeInteractor: HomeIntercatorInput {
    
    // MARK: - Home Interacting

    func searchRepository(respositoryName: String) {
        let request = HomeModel.Repository.Request(repositoryName: respositoryName)
        
        presenter.presentLoading()
        worker.fetchRepository(request: request) { [weak self] result in
            switch result {
            case let .success(response):
                self?.presenter.presentSuccess(response: response)
            case let .failure(error):
                self?.presenter.presentError(error: error)
            }
        }
    }
}
