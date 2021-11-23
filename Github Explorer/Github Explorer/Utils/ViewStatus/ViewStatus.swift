//
//  ViewStatus.swift
//  UIKit GitHub Explorer
//
//  Created by inchurch on 20/09/21.
//

import Foundation

enum ViewStatus: Equatable {
    case loaded, loading, empty, none
    case error(String)
}
