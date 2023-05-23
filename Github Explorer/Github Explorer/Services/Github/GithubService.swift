//
//  GithubEndpoint.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 20/09/21.
//

import Foundation
import SwiftUI

class GithubService {
    let baseUrl = "https://api.github.com"
    
    func callMethod(endpoint: GithubEndpoint, completion: @escaping (Data) -> (), typeErro: @escaping (String) -> ()) {
        let url = URL(string:"\(baseUrl)/\(endpoint.endpoint)")
        guard let url = url else {return}
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let responseCode = response as? HTTPURLResponse else {
                typeErro("Empty answer.")
                return
            }
            
            if let error = error {
                typeErro("error: \(String(describing: error.localizedDescription))")
                return
            }
            
            if responseCode.statusCode == 404 {
                typeErro("Repository not found.")
                return
            }
            
            guard let data = data else {
                typeErro("Empty data.")
                return
            }
            
            completion(data)
        }.resume()
    }
}

extension GithubService: GithubServiceDelegate {}
