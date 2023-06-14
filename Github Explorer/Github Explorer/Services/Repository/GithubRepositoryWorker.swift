//
//  GithubRepositoryWorker.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 23/09/21.
//

import Foundation

protocol GithubRepositoryWorkerInput {
    func fetchRepository(request: GithubModel.Repository.Request) async throws -> GithubModel.Repository.Response
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

extension GithubRepositoryWorker: GithubRepositoryWorkerInput {
    
    // MARK: - Fetch Repository
    
    func fetchRepository(request: GithubModel.Repository.Request) async throws -> GithubModel.Repository.Response {
        let endpoint = RepositoryEndpoint(request: request)
        let data = try await repository.callMethod(endpoint: endpoint)
        return try JSONDecoder().decode(GithubModel.Repository.Response.self, from: data)
    }
}
