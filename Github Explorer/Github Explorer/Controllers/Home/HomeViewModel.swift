//
//  MainPageViewModel.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 20/09/21.
//

import Foundation
import CoreData
import UIKit

protocol HomeViewModelDelegate {
    var repositories: [NSManagedObject] { get set }
    var viewStatus: Box<ViewStatus> { get set }
    var alert: CreatableAlertDelegate? { get set }
    
    func getRepository(repositoryName: String)
}

class HomeViewModel {
    var repositories: [NSManagedObject] = []
    var viewStatus: Box<ViewStatus> = Box(.none)
    var alert: CreatableAlertDelegate?
    
    private var service: RepositoryServiceDelegate
    
    init(service: RepositoryServiceDelegate = RepositoryService()) {
        self.service = service
        testAddDefaultRepo()
    }
    
    func testAddDefaultRepo() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext

        let entity = NSEntityDescription.entity(forEntityName: "RepositoryEntity", in: managedContext)!
        
        let repo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        repo.setValue("Apple/swift", forKeyPath: "name")
        repo.setValue("https://files.tecnoblog.net/wp-content/uploads/2020/11/apple-logo.jpg", forKey: "full_name")
        repo.setValue(1, forKey: "id")
        
        do {
            try managedContext.save()
            repositories.append(repo)
            self.viewStatus.value = .loaded
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func getRepository(repositoryName: String) {
        guard !repositoryName.isEmpty else {
            viewStatus.value = .error("Please, do not search with the text field empty.")
            return
        }
        
//        if let _ = repositories.first(where: { $0.full_name == repositoryName }) {
//            viewStatus.value = .error("This repository has already been added.")
//            return
//        }
        
        self.viewStatus.value = .loading
        service.getRepository(with: repositoryName) { repository in
//            self.repositories.append(repository)
            self.viewStatus.value = .loaded
        } typeErro: { error in
            self.viewStatus.value = .error(error)
        }
    }
}

extension HomeViewModel: HomeViewModelDelegate {}
