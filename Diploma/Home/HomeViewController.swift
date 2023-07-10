//
//  HomeViewController.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.ёё
//

import RIBs
import UIKit
import TinyConstraints
import RxSwift


//enum ButtonType (прописать здесь)


protocol HomeViewContollerListener: AnyObject {
    func didTapOnButton(/*_ type: HomeTabBarButtonType*/)
    func didLoad()
}

final class HomeViewController: UIViewController {
    
    weak var listener: HomeViewContollerListener?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .loggedOutBackgroundColor
        addView()
        addConstraints()
        listener?.didLoad()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        tabBar.layer.shadowColor = UIColor.shadowTabBarColor.cgColor
    }

    // MARK: - Functions
    
    private func addView() {
        view.addSubview(tabBar)
    }

    private func addConstraints() {
        tabBar.bottomToSuperview(usingSafeArea: true)
        tabBar.leftToSuperview()
        tabBar.rightToSuperview()
        tabBar.height(Constants.TAbBar.heightOffset)
    }

    private enum Constants {
        enum TAbBar {
            static let heightOffset: CGFloat = 49
        }
    }

    // MARK: - Properties
    
    private lazy var tabBar: UITabBar = {

        // TODO: - создать в UIColor цветовую гамму
        $0.backgroundColor = .gray
        $0.layer.shadowColor = UIColor.shadowTabBarColor.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: -2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.5
        return $0
    }(UITabBar())

    private let disposeBag = DisposeBag()
}

// MARK: - HomePresentable

extension HomeViewController: HomePresentable {
    func setupTabBarItems(_ viewModel: [TabBarItemViewModel]) {
        let items = viewModel.map {
            UITabBarItem(
                title: $0.name,
                image: $0.image,
                tag: $0.tag
            )
        }
        tabBar.setItems(items, animated: true)
        tabBar.tintColor = .tabBarTintColor
        tabBar.selectedItem = items.first
    }
}

// MARK: - HomeViewControllable

extension HomeViewController: HomeViewControllable {

    // TODO: - перепечатать функцию для child Set Child
}
