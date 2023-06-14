//
//  HomeRouter.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomeRouterInput: AnyObject {
    
    func handleError(error: WorkerError)
    func openSafari(url: URL)
}

final class HomeRouter {
    
    // MARK: - Properties
    
    weak var navigationController: UINavigationController?
}

extension HomeRouter: HomeRouterInput {
    
    // MARK: - Home Coordinating
    
    func handleError(error: WorkerError) {
        let alert = UIAlertController(title: LocalizableString.Core.errorTitle, message: error.message, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: LocalizableString.Core.okTitle, style: .cancel, handler: nil)
        
        alert.addAction(closeButton)
        navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func openSafari(url: URL) {
        // todo
    }
}
