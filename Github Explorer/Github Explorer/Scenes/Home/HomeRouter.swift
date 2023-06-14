//
//  HomeRouter.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import SafariServices
import UIKit

protocol HomeRouterInput: AnyObject {
    
    func handleError(error: WorkerError)
    func openSafari(urlString: String)
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
    
    func openSafari(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let controller = SFSafariViewController(url: url, configuration: config)
        navigationController?.present(controller, animated: true)
    }
}
