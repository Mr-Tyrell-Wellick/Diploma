//
//  CustomButtons.swift
//  Diploma
//
//  Created by Ульви Пашаев on 16.06.2023.
//

import UIKit

enum CustomButtonType {
    case defaultButton(title: String, titleColor: UIColor, backgroundColor: UIColor)
    case imageButton(imageButton: UIImage)
}

extension UIButton {

    func setupButton(_ type: CustomButtonType) {
        switch type {
        case .defaultButton(let title, let titleColor, let backgroundColor):
            setTitle(title, for: .normal)
            setTitleColor(titleColor, for: .normal)
            self.backgroundColor = backgroundColor
            setupConfig()
        case .imageButton(let imageButton):
            setImage(imageButton, for: .normal)

        }
    }

    private func setupConfig() {
        isUserInteractionEnabled = true
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
    }
}
