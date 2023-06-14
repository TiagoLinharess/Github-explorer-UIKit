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
    func presentError(error: Error)
}

final class HomeInteractor {
    
    // MARK: - Properties
    
    private let presenter: HomeInteractorOutput
    private let worker: GithubRepositoryWorkerInput
    
    // MARK: - Initialize
    
    init(presenter: HomePresenterInput, worker: GithubRepositoryWorkerInput = GithubRepositoryWorker()) {
        self.presenter = presenter
        self.worker = worker
    }
}

extension HomeInteractor: HomeIntercatorInput {
    
    // MARK: - Home Interacting

    func searchRepository(respositoryName: String) {
        let request = HomeModel.Repository.Request(repositoryName: respositoryName)
        
        presenter.presentLoading()
        Task {
            do {
                let response = try await worker.fetchRepository(request: request)
                presenter.presentSuccess(response: response)
            } catch {
                presenter.presentError(error: error)
            }
        }
    }
}
