//
//  RepositoryEndpoint.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 20/09/21.
//

import Foundation

class RepositoryEndpoint: Endpoint {
    var method: HTTPMethod = .get
    var endpoint: String
    
    init(request: GithubModel.Repository.Request) {
        self.endpoint = "repos/\(request.repositoryName)"
    }
}
