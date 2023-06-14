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
            case url = "html_url"
        }
        
        let id: Int?
        let name: String?
        let fullName: String?
        let owner: Owner.Response?
        let language: String?
        let openIssuesCount: Int?
        let forks: Int?
        let subscribersCount: Int?
        let url: String?
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
        let url: String
        
        init(from dto: Response) {
            self.id = dto.id ?? Int()
            self.name = dto.name ?? String()
            self.fullName = dto.fullName ?? String()
            self.owner = Owner.viewModel(from: dto.owner)
            self.language = dto.language ?? String()
            self.openIssuesCount = dto.openIssuesCount ?? Int()
            self.forks = dto.forks ?? Int()
            self.subscribersCount = dto.subscribersCount ?? Int()
            self.url = dto.url ?? String()
        }
    }
}
