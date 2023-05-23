//
//  HomeInteractor.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import Foundation

protocol HomeInteracting: AnyObject {
    func searchRepository(respositoryName: String)
}

final class HomeInteractor {
    
    private let presenter: HomePresenting
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

extension HomeInteractor: HomeInteracting {
    
    func searchRepository(respositoryName: String) {
        
    }
}
