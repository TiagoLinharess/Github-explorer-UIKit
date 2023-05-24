//
//  LocalizableString.swift
//  Github Explorer
//
//  Created by Tiago Linhares Souza on 23/05/23.
//

import Foundation

enum LocalizableString {
    
    enum Core {}
    enum Home {}
}

extension LocalizableString.Core {
    
    // MARK: - Core
    
    /// Github image
    static let backgroundImageName: String = LocalizableString.tr(key: "Core.githubImage")
    
    /// Logo image
    static let logoImage: String = LocalizableString.tr(key: "Core.logoImage")
    
    /// Init coder
    static let initCoder: String = LocalizableString.tr(key: "Core.initCoder")
    
    /// Error title
    static let errorTitle: String = LocalizableString.tr(key: "Core.errorTitle")
    
    /// OK title
    static let okTitle: String = LocalizableString.tr(key: "Core.okTitle")
}

extension LocalizableString.Home {
    
    // MARK: - Home
    
    /// Home text field placeholder
    static let textFieldPlaceholder: String = LocalizableString.tr(key: "Home.textFieldPlaceholder")
    
    /// Home search button title
    static let searchButtonTitle: String = LocalizableString.tr(key: "Home.searchButtonTitle")
    
    /// Home repository table view cell identifier
    static let repositoryTableViewCellIdentifier: String = LocalizableString.tr(key: "Home.repositoryTableViewCellIdentifier")
}

extension LocalizableString {
    
    // MARK: - Bundle
    
    private static func tr(key: String) -> String {
        return NSLocalizedString(key, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
}
