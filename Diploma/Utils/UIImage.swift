//
//  UIImage.swift
//  Diploma
//
//  Created by Ульви Пашаев on 20.06.2023.
//

import UIKit

extension UIImage {

    // MARK: - LoggedOut Screen

    // Logo
    class var logoImage: UIImage {
        UIImage(named: "loginLogo") ?? UIImage()
    }

    // FaceID
    class var faceIDImage: UIImage {
        UIImage(named: "faceid") ?? UIImage()
    }

    // TextFieldImage
    class var atImage: UIImage {
        UIImage(named: "at") ?? UIImage()
    }

    class var lockImage: UIImage {
        UIImage(named: "lock") ?? UIImage()
    }


    // MARK: - SignUp Screen

    class var launchImage: UIImage {
        UIImage(named: "launchScreen") ?? UIImage()
    }
}
