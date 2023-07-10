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

    var localized: String {
        self.rawValue.localizedString()
    }
}
