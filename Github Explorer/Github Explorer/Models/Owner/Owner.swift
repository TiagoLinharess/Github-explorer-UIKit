//
//  Owner.swift
//  Github Explorer
//
//  Created by inchurch on 12/06/21.
//

import Foundation

class Owner: Codable {
  var login: String
  var avatar_url: String
  
  init(login: String, avatar_url: String) {
    self.login = login
    self.avatar_url = avatar_url
  }
}
