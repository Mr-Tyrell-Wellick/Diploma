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
    
    func removeChildFromParent() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    
    
    // MARK: - NavigationTabBar
    
    func setupNavigationBar(_ title: String) {
        navigationItem.title = title
        customizeAppearance()
        enableLargeTitles()
    }
    
    private func customizeAppearance() {
        let appearance = UINavigationBarAppearance()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    private func enableLargeTitles() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
}
