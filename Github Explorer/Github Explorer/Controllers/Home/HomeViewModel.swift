//
//  MainPageViewModel.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 20/09/21.
//

import Foundation

protocol HomeViewModelDelegate {
    var repositories: [Repository] { get set }
    var viewStatus: Box<ViewStatus> { get set }
    var alert: CreatableAlertDelegate? {get set}
    
    func getRepository(repositoryName: String)
}

class HomeViewModel {
    var repositories: [Repository] = []
    var viewStatus: Box<ViewStatus> = Box(.none)
    var alert: CreatableAlertDelegate?
    
    private var service: RepositoryServiceDelegate
    
    init(service: RepositoryServiceDelegate = RepositoryService()) {
        self.service = service
    }
    
    func getRepository(repositoryName: String) {
        guard !repositoryName.isEmpty else {
            viewStatus.value = .error("Please, do not search with the text field empty.")
            return
        }
        
        if let _ = repositories.first(where: { $0.full_name == repositoryName }) {
            viewStatus.value = .error("This repository has already been added.")
            return
        }
        
        self.viewStatus.value = .loading
        service.getRepository(with: repositoryName) { repository in
            self.repositories.append(repository)
            self.viewStatus.value = .loaded
        } typeErro: { error in
            self.viewStatus.value = .error(error)
        }
    }
}

extension HomeViewModel: HomeViewModelDelegate {}
