//
//  RepositoryService.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 23/09/21.
//

import Foundation

class RepositoryService {
    let githubService: GithubServiceDelegate
    
    init(githubService: GithubServiceDelegate = GithubService()) {
        self.githubService = githubService
    }
    
    func getRepository(with repoName: String, completion: @escaping (Repository) -> (), typeErro: @escaping (String) -> ()) {
        githubService.callMethod(endpoint: RepositoryEndpoint(repoName: repoName)) { data in
            do {
                let decoder = JSONDecoder()
                let repository = try decoder.decode(Repository.self, from: data)
                
                DispatchQueue.main.async {
                    completion(repository)
                }
            } catch let error {
                typeErro(error.localizedDescription)
            }
        } typeErro: { error in
            typeErro(error)
        }
    }
}

extension RepositoryService: RepositoryServiceDelegate {}
