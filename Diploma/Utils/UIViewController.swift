//
//  UIViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import UIKit

extension UIViewController {
    func presentViewControllerFullScreen(
        viewController: UIViewController,
        animated: Bool = true,
        completionHandler: (() -> Void)? = nil
    ) {
        viewController.modalPresentationStyle = .fullScreen
        present(
            viewController,
            animated: animated,
            completion: completionHandler
        )
    }
}
