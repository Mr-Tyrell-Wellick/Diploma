//
//  HomeViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift

protocol HomeViewContollerListener: AnyObject {
    func didTapOnButton(_ type: HomeTabBarButtonType)

}

final class HomeViewController: UIViewController {

    weak var listener: HomeViewContollerListener?

    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green

        addView()
    }

    // MARK: - Functions

    private func addView() {
//        view.addSubview(tabBar)

    }

    private func addConstraints() {


    }


    private enum Constats {

    }


    // MARK: - Properties

//    private lazy var tabBar: UITabBar = {
//        let firstTab = UITabBarItem(title: "", image: <#T##UIImage?#>, tag: 0)
//        let secondTab = UITabBarItem(title: "", image: <#T##UIImage?#>, tag: 1)
//        let thirdTab = UITabBarItem(title: "", image: <#T##UIImage?#>, tag: 2)
//
//        tabBar.setItems([firstTab, secondTab, thirdTab], animated: false)
//        return $0
//    }(UITabBar())












    private let disposeBag = DisposeBag()






}

// MARK: - HomePresentable

extension HomeViewController: HomePresentable {

}

// MARK: - HomeViewControllable

extension HomeViewController: HomeViewControllable {

}
