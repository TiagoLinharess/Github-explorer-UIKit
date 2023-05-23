//
//  GithubRepositoryWorker.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 23/09/21.
//

import Foundation

typealias GithubRepositoryWorkerCompletion = (Result<GithubModel.Repository.Response, WorkerError>) -> Void

protocol GithubRepositoryWorking {
    func fetchRepository(request: GithubModel.Repository.Request, completion: @escaping GithubRepositoryWorkerCompletion)
}

// MARK: - Worker

final class GithubRepositoryWorker {
    
    // MARK: - Properties
    
    let repository: RepositoryInput
    
    // MARK: - Initialize
    
    init(repository: RepositoryInput = Repository()) {
        self.repository = repository
    }
}

extension GithubRepositoryWorker: GithubRepositoryWorking {
    
    // MARK: - Fetch Repository
    
    func fetchRepository(request: GithubModel.Repository.Request, completion: @escaping GithubRepositoryWorkerCompletion) {
        let endpoint = RepositoryEndpoint(request: request)
        
        repository.callMethod(endpoint: endpoint) { result in
            switch result {
            case let .success(data):
                if let response = try? JSONDecoder().decode(GithubModel.Repository.Response.self, from: data) {
                    completion(.success(response))
                } else {
                    completion(.failure(.genericError))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
