//
//  Repository.swift
//  Github Explorer
//
//  Created by inchurch on 12/06/21.
//

import Foundation

class Repository: Codable {
  let id: Int
  let name: String
  let full_name: String
  let owner: Owner
  let language: String
  let open_issues_count: Int
  let forks: Int
  let subscribers_count: Int
  
  init(id: Int, name: String, full_name: String, owner: Owner, language: String, open_issues_count: Int, forks: Int, subscribers_count: Int) {
    self.id = id
    self.name = name
    self.full_name = full_name
    self.owner  = owner
    self.language = language
    self.open_issues_count = open_issues_count
    self.forks = forks
    self.subscribers_count = subscribers_count
  }
}
