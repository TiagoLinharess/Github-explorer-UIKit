//
//  GithubApiProvider.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 23/09/21.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
    case delete = "DELETE"
}

protocol GithubEndpoint {
    var endpoint: String {get set}
    var method: HTTPMethod {get set}
}

protocol GithubServiceDelegate {
    func callMethod(endpoint: GithubEndpoint, completion: @escaping (Data) -> (), typeErro: @escaping (String) -> ())
}
