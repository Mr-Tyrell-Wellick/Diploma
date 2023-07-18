//
//  FavoritesViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift
import RxGesture

protocol FavoritesViewControllerListener: AnyObject {
    
}

final class FavoritesViewController: UIViewController {

    weak var listener: FavoritesViewControllerListener?


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        addView()
        addConstraints()
    }


    // TODO: - НАПИСАТЬ!

    // MARK: - Functions

    private func addView() {

    }

    private func addConstraints() {

    }


    // MARK: - Enums

    private enum Constants {

    }
}


// MARK: - Properties



// MARK: - FavoritesPresentable

extension FavoritesViewController: FavoritesPresentable {
    
}

// MARK: - FavoritesViewControllable

extension FavoritesViewController: FavoritesViewControllable {

}
