//
//  HomeViewController.swift
//  UIKit GitHub Explorer
//
//  Created by Tiago Linhares on 18/06/21.
//

import UIKit

protocol HomeViewControllerDisplaying: AnyObject {
    
}

final class HomeViewController<Interactor: HomeInteracting, CustomView: HomeView>: UIViewController {
    
    // MARK: PROPERTIES
    private let customView: CustomView
    private let interactor: Interactor
    
    // MARK: INITIALIZE
    init(
        customView: CustomView,
        interactor: Interactor
    ) {
        self.customView = customView
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: VIEW LIFE CICLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

extension HomeViewController {
    
    func setupView() {
        view = customView
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension HomeViewController: HomeViewControllerDisplaying {
    
}
