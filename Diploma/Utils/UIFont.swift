//
//  UIFont.swift
//  Diploma
//
//  Created by Ульви Пашаев on 16.06.2023.
//

import UIKit

extension UIFont {

    // MARK: - LoggedOut Screen

    class var signUpLabelFont: UIFont {
        systemFont(ofSize: 19, weight: .regular)
    }

    class var signUpLabelInSignUpFont: UIFont {
        systemFont(ofSize: 25, weight: .bold)
    }

    // MARK: - Profile Screen

    class var fullNameFont: UIFont {
        systemFont(ofSize: 18, weight: .bold)
    }

    class var statusFont: UIFont {
        systemFont(ofSize: 14, weight: .regular)
    }

    class var photoHeaderFont: UIFont {
        systemFont(ofSize: 24, weight: .bold)
    }

    class var authorHeaderFont: UIFont {
        systemFont(ofSize: 18, weight: .bold)
    }

    class var descriptionTextFont: UIFont {
        systemFont(ofSize: 14, weight: .light)
    }

    class var viewsFont: UIFont {
        systemFont(ofSize: 16, weight: .light)
    }
}
