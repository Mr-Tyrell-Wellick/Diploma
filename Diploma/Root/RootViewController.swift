//
//  RootViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs
import UIKit

protocol RootViewControllerListener: AnyObject {

}

final class RootViewController: UIViewController {

    weak var listener: RootViewControllerListener?

}

// MARK: - RootPresentable

extension RootViewController: RootPresentable {

}

// MARK: - RootViewControllable

extension RootViewController: RootViewControllable {
    func show(_ vc: UIViewController) {
        presentViewControllerFullScreen(viewController: vc)
    }
    
    func dismiss(_ completionHandler: () -> ()) {
        dismiss(animated: true)
        completionHandler()
    }
}
