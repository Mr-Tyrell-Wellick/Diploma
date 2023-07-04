////
////  HomeTabBar.swift
////  Diploma
////
////  Created by Ульви Пашаев on 02.07.2023.
////
//
import UIKit
import TinyConstraints
import RxSwift

enum HomeTabBarButtonType {
    case general
    case profile
    case favorites
}
//
//protocol HomeTabBarControllable: UITabBar {
//    var didTapOnButton: PublishSubject<HomeTabBarButtonType> { get }
//}
//
//final class HomeTabBar: UITabBar, HomeTabBarControllable {
//
//    // MARK: - LifeCycle
//
//    convenience init() {
//        self.init(frame: .zero)
//        setupViewAppearance()
//
//
//    }
//
//
//
//    // MARK: - Private
//
//    private func setupViewAppearance() {
//        backgroundColor = .red
//        layer.borderColor = UIColor.black.cgColor
//        layer.borderWidth = 1
//        layer.cornerRadius = 5
//        layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
//        clipsToBounds = true
//    }
//
//    private func configureTabBar() {
//
//
//
////        generalViewController.tabBarItem = UITabBarItem(
////                title: "Market",
////                image: .marketImage,
////                selectedImage: nil
////            )
////            cartViewController.tabBarItem = UITabBarItem(
////                title: "Cart",
////                image: .cartImage,
////                selectedImage: nil
////            )
////            profileViewController.tabBarItem = UITabBarItem(
////                title: "Profile",
////                image: .profileImage,
////                selectedImage: nil
////            )
//
//
//
////        let generalViewController = GeneralViewController()
////        let profileViewController = ProfileViewController()
////        let favoritesViewController = FavoritesViewController()
////    }
//
//    private func configureButtons() {
//
//    }
//
//
//    private func subscribeOnButtons() {
//
//    }
//
//
//}
