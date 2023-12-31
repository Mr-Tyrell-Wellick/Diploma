//
//  UIView.swift
//  Diploma
//
//  Created by Ульви Пашаев on 27.06.2023.
//

import UIKit

extension UIView {
    
    class var identifier: String {
        String(describing: type(of: self))
        
    }
    
    func setBottomBorder(
        offset: CGFloat = 2,
        color: UIColor,
        cornerRadius: CGFloat = 0
    ) {
        let borderView = UIView()
        borderView.backgroundColor = color
        borderView.layer.cornerRadius = cornerRadius
        addSubview(borderView)
        
        borderView.trailingToSuperview()
        borderView.leadingToSuperview()
        borderView.bottomToSuperview(offset: offset)
        borderView.height(1)
    }
}
