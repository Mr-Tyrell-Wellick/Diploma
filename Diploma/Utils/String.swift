//
//  String.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import Foundation

enum Strings: String {
    
    // MARK: - LoggedOut Sceen
    
    case loginButton
    case signUpText
    case highLighthedText
    case passwordTextField
    case loginTextField
    case biometryUsageDescription
    
    // MARK: - SignUp Screen
    
    case signUpButton
    case signUpLabel
    
    // MARK: - Alerts
    
    case alertMailNoteTitle
    case alertMailNoteText
    
    // MARK: - TabBar
    
    case mainItemName
    case profileItemName
    case favoritesItemName
    
    // MARK: - Profile Screen
    
    case userName
    case statusTextField
    case statusButton
    case photoLabel
    case photoGalleryLabel
    
    // MARK: - Author name
    
    case friendOne
    case friendTwo
    case friendThree
    case friendFour
    case friendFive
    case friendSix
    
    // MARK: - Author post
    
    case friendOneDescription
    case friendTwoDescription
    case friendThreeDescription
    case friendFourDescription
    case friendFiveDescription
    case friendSixDescription
    
    // MARK: - Main Screen
    
    case MainNavigationItem
    
    // MARK: - My post
    
    case myPostOne
    case myPostTwo
    case myPostThree
    
    var localized: String {
        self.rawValue.localizedString()
    }
}
