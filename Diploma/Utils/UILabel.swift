//
//  UILabel.swift
//  Diploma
//
//  Created by Ульви Пашаев on 28.06.2023.
//

import UIKit

extension UILabel {
    
    func setupLabelAndAttributes(
        allText: String,
        highLighthedText: String,
        textColor: UIColor?
    ) {
        let attributedString = NSMutableAttributedString(string: allText)
        if let range = attributedString.string.range(of: highLighthedText) {
            let nsRange = NSRange(range, in: attributedString.string)
            attributedString.addAttribute(.foregroundColor, value: UIColor.loggedOutAttributeColor, range: nsRange)
        }
        self.attributedText = attributedString
        self.isUserInteractionEnabled = true
    }
}
