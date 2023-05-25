//
//  HomeFactory.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 22/05/23.
//

import UIKit

enum HomeFactory {
    
    static func configure(navigationController: UINavigationController?) -> UIViewController {
        let router = HomeRouter()
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter)
        let view = HomeView()
        
        let controller = HomeViewController<HomeRouter, HomeInteractor, HomeView>(
            customView: view,
            interactor: interactor,
            router: router
        )
        
        router.navigationController = navigationController
        presenter.viewController = controller
        
        return controller
    }
}
