//
//  UIImageView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 13.07.2023.
//

import UIKit

extension UIImageView {

    func setupAvatar(userImage: UIImage) {
        isUserInteractionEnabled = true
        layer.cornerRadius = 50
        layer.masksToBounds = true
        layer.borderWidth = 3
        layer.borderColor = UIColor.white.cgColor
    }
}
