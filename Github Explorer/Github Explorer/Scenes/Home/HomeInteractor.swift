//
//  HomeInteractor.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import Foundation

protocol HomeInteracting: AnyObject {
    func searchRepository(respositoryName: String)
}

final class HomeInteractor {
    
    // MARK: - Properties
    
    private let presenter: HomePresenting
    private let worker: GithubRepositoryWorking
    
    // MARK: - Initialize
    
    init(presenter: HomePresenting, worker: GithubRepositoryWorking = GithubRepositoryWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension HomeInteractor: HomeInteracting {
    
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
