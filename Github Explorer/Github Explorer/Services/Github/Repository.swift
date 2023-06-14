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
    func callMethod(endpoint: Endpoint) async throws -> Data
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
    
    func callMethod(endpoint: Endpoint) async throws -> Data {
        guard let url = URL(string:"\(baseUrl)/\(endpoint.endpoint)") else { throw WorkerError.customError("No Available URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw WorkerError.customError("No response from server") }
        guard statusCode >= 200 && statusCode <= 400 else { throw WorkerError.genericError }
        
        return data
    }
}
