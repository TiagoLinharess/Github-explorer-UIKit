//
//  Owner.swift
//  Github Explorer
//
//  Created by Tiago Linhares on 12/06/21.
//

import Foundation

extension GithubModel.Repository {
    
    enum Owner {}
}

extension GithubModel.Repository.Owner {
    
    struct Response: Decodable {
    
        enum CodingKeys: String, CodingKey {
            case login = "login"
            case avatarUrl = "avatar_url"
        }
        
        let login: String
        let avatarUrl: String
    }
    
    struct viewModel {
        
        let login: String
        let avatarUrl: String
        
        init(from dto: Response) {
            self.login = dto.login
            self.avatarUrl = dto.avatarUrl
        }
    }
}
