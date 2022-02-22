//
//  CreatableSafari.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 18/10/21.
//

import Foundation
import UIKit
import SafariServices

protocol CreatableSafariDelegate {
    func createSafari(_ issueUrl: String)
}

extension CreatableSafariDelegate where Self: UIViewController {
    func createSafari(_ issueUrl: String) {
        if let url = URL(string: issueUrl) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}
