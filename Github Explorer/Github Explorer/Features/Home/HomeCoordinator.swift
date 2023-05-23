//
//  HomeCoordinator.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import UIKit

protocol HomeCoordinating: AnyObject {
    
}

final class HomeCoordinator {
    
    weak var navigationController: UINavigationController?
}

extension HomeCoordinator: HomeCoordinating {
    
}
