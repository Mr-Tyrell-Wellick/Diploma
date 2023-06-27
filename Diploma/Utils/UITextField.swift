//
//  UITextField.swift
//  Diploma
//
//  Created by Ульви Пашаев on 16.06.2023.
//

import UIKit

extension UITextField {

    func addLeftImage(_ image: UIImage?) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .center
        imageView.frame.size = CGSize(width: 16, height: self.frame.height)
        let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 39, height: self.frame.height))
        containerView.addSubview(imageView)
        imageView.center = containerView.center
        leftView = containerView
        leftViewMode = .always
    }

    //TODO: - добавить нужные цвета!!!!!!
    func setupTextFieldAndAttributes(placeholder: String, textColor: UIColor) {
        layer.borderColor = UIColor.lightGray.cgColor
        font = .systemFont(ofSize: 16)
        self.textColor = textColor

        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.yellow,
            .font: self.font!
        ]
        attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: placeholderAttributes
        )
        autocapitalizationType = .none
    }
}
