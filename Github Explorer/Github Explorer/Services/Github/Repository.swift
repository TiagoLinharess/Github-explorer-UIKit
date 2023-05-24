//
//  Repository.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 20/09/21.
//

import Foundation
import SwiftUI

// MARK: - Repository Input

protocol RepositoryInput {
    func callMethod(endpoint: Endpoint, completion: @escaping (Result<Data, WorkerError>) -> Void)
}

// MARK: - Endpoint

protocol Endpoint {
    var endpoint: String { get set }
    var method: HTTPMethod { get set }
}

// MARK: - HTTP Method

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

// MARK: - Worker Error

enum WorkerError: Error {
    case genericError
    case customError(String)
    
    var message: String {
        switch self {
        case .genericError:
            return localizedDescription
        case .customError(let string):
            return string
        }
    }
}

// MARK: - Repository

final class Repository {
    
    // MARK: - Properties
    
    let baseUrl = "https://api.github.com"
}

extension Repository: RepositoryInput {
    
    // MARK: - Request
    
    func callMethod(endpoint: Endpoint, completion: @escaping (Result<Data, WorkerError>) -> Void) {
        guard let url = URL(string:"\(baseUrl)/\(endpoint.endpoint)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                let message = error.localizedDescription
                completion(.failure(.customError(message)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.genericError))
                return
            }
            
            completion(.success(data))
        }.resume()
    }
}
