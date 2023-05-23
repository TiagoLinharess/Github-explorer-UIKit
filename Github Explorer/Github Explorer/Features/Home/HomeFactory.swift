//
//  HomeFactory.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import UIKit

enum HomeFactory {
    
    static func make() -> UIViewController {
        let coordinator = HomeCoordinator()
        let presenter = HomePresenter(coordinator: coordinator)
        let interactor = HomeInteractor(presenter: presenter)
        let view = HomeView()
        
        let controller = HomeViewController<HomeInteractor, HomeView>(
            customView: view,
            interactor: interactor
        )
        
        coordinator.navigationController = controller.navigationController
        presenter.viewController = controller
        
        return controller
    }
}
