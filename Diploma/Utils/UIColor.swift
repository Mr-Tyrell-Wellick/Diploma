//
//  UIColor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 04.06.2023.
//

import UIKit

extension UIColor {

    // MARK: - LoggedOut Screen

    class var loggedOutBackgroundColor: UIColor {
        UIColor(named: "loggedOutBackgroundColor") ?? gray
    }

    // Title
    class var titleColor: UIColor {
        UIColor(named: "titleColor") ?? systemBackground
    }


// Buttons and TextFields
    class var buttonBackgroundColor: UIColor {
        UIColor(named: "buttonBackgroundColor") ?? systemBackground
    }

    class var buttonColor: UIColor {
        UIColor(named: "buttonColor") ?? .black
    }


    class var textFieldBackgroundColor: UIColor {
        UIColor(named: "textFieldBackgroundColor") ?? .gray
    }


    // StackView
    class var stackViewTextFieldColor: UIColor {
        UIColor(named: "stackViewTextFieldColor") ?? black
    }

    class var lineColor: UIColor {
        UIColor(named: "lineColor") ?? green
    }
}
