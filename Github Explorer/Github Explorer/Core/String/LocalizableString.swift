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
    
    /// Init Coder
    static let initCoder: String = LocalizableString.tr(key: "Core.initCoder")
}

extension LocalizableString.Home {
    
    // MARK: - Home
    
    /// Home text field placeholder
    static let textFieldPlaceholder: String = LocalizableString.tr(key: "Home.textFieldPlaceholder")
    
    /// Home search button title
    static let searchButtonTitle: String = LocalizableString.tr(key: "Home.searchButtonTitle")
}

extension LocalizableString {
    
    // MARK: - Bundle
    
    private static func tr(key: String) -> String {
        return NSLocalizedString(key, tableName: "Localizable", bundle: Bundle.main, value: "", comment: "")
    }
}
