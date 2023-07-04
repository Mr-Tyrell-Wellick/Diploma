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

    class var buttonTextColor: UIColor {
        UIColor(named: "buttonTextColor") ?? .systemBackground
    }

    class var separatorColor: UIColor {
        UIColor(named: "separatorColor") ?? black
    }

    class var textFieldTextColor: UIColor {
        UIColor(named: "textFieldTextColor") ?? systemBackground
    }

    class var loggedOutLabelColor: UIColor {
        UIColor(named: "loggedOutLabelColor") ?? blue
    }

    class var loggedOutAttributeColor: UIColor {
UIColor(named: "loggedOutAttributeColor") ?? green
    }

    // MARK: - SignUp Screen

    class var stripColor: UIColor {
        UIColor(named: "stripColor") ?? .gray
    }

}
