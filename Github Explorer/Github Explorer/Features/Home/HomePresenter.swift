//
//  HomePresenter.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomePresenting {
    
}

final class HomePresenter {
    
    weak var viewController: HomeViewControllerDisplaying?
    
    private let coordinator: HomeCoordinating
    
    init(coordinator: HomeCoordinating) {
        self.coordinator = coordinator
    }
}

extension HomePresenter: HomePresenting {
    
}
