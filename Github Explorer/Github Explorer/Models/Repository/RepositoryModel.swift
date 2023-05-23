//
//  Repository.swift
//  Github Explorer
//
//  Created by Tiago Linhares on 12/06/21.
//

import Foundation

extension GithubModel {
    
    enum Repository {}
}

extension GithubModel.Repository {
    
    struct Request: Encodable {
        
        let repositoryName: String
    }
    
    struct Response: Decodable {
        
        enum CodingKeys: String, CodingKey {
            case id = "id"
            case name = "name"
            case fullName = "full_name"
            case owner = "owner"
            case language = "language"
            case openIssuesCount = "open_issues_count"
            case forks = "forks"
            case subscribersCount = "subscribers_count"
        }
        
        let id: Int
        let name: String
        let fullName: String
        let owner: Owner.Response
        let language: String
        let openIssuesCount: Int
        let forks: Int
        let subscribersCount: Int
    }
    
    struct ViewModel {
        
        let id: Int
        let name: String
        let fullName: String
        let owner: Owner.viewModel
        let language: String
        let openIssuesCount: Int
        let forks: Int
        let subscribersCount: Int
        
        init(from dto: Response) {
            self.id = dto.id
            self.name = dto.name
            self.fullName = dto.fullName
            self.owner = Owner.viewModel(from: dto.owner)
            self.language = dto.language
            self.openIssuesCount = dto.openIssuesCount
            self.forks = dto.forks
            self.subscribersCount = dto.subscribersCount
        }
    }
}
