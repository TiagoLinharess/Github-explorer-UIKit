//
//  HomeCoordinator.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomeCoordinating: AnyObject {
    
    func handleError(error: WorkerError)
}

final class HomeCoordinator {
    
    // MARK: - Properties
    
    weak var navigationController: UINavigationController?
}

extension HomeCoordinator: HomeCoordinating {
    
    // MARK: - Home Coordinating
    
    func handleError(error: WorkerError) {
        let alert = UIAlertController(title: LocalizableString.Core.errorTitle, message: error.message, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: LocalizableString.Core.okTitle, style: .cancel, handler: nil)
        
        alert.addAction(closeButton)
        
        DispatchQueue.main.async {
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
