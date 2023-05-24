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
    
    weak var navigationController: UINavigationController?
}

extension HomeCoordinator: HomeCoordinating {
    
    func handleError(error: WorkerError) {
        let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(closeButton)
        
        DispatchQueue.main.async {
            self.navigationController?.present(alert, animated: true, completion: nil)
        }
    }
}
