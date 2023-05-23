//
//  RepositoryProtocols.swift
//  Github Explorer
//
//  Created by Tiago Linhares on 23/11/21.
//

import Foundation

protocol RepositoryServiceDelegate {
    func getRepository(with repoName: String, completion: @escaping (Repository) -> (), typeErro: @escaping (String) -> ())
}
