//
//  CreatableAlert.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 26/09/21.
//

import Foundation
import UIKit

protocol CreatableAlertDelegate {
    func createOkAlert(title: String, message: String)
}

extension CreatableAlertDelegate where Self: UIViewController {
    func createOkAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let closeButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        alert.addAction(closeButton)
        present(alert, animated: true, completion: nil)
    }
}
