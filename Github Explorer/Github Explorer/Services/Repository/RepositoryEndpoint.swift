//
//  RepositoryEndpoint.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 20/09/21.
//

import Foundation

class RepositoryEndpoint: GithubEndpoint {
    var method: HTTPMethod = .get
    var endpoint: String
    
    init(repoName: String) {
        self.endpoint = "repos/\(repoName)"
    }
}
