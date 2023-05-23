//
//  HomeInteractor.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import Foundation

protocol HomeInteracting: AnyObject {
    
}

final class HomeInteractor {
    
    private let presenter: HomePresenting
    
    init(presenter: HomePresenting) {
        self.presenter = presenter
    }
}

extension HomeInteractor: HomeInteracting {
    
}
