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

enum TabBarButtonType {
    case main
    case profile
    case favorites
}

protocol HomeViewContollerListener: AnyObject {
    func didTapOnButton(_ type: TabBarButtonType)
    func didLoad()
}

final class HomeViewController: UIViewController {
    
    weak var listener: HomeViewContollerListener?
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .allScreenBackgroundColor
        addView()
        addConstraints()
        listener?.didLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
    
    private func setupChildConstraints() {
        child?.view.topToSuperview()
        child?.view.leadingToSuperview()
        child?.view.trailingToSuperview()
        child?.view.bottomToTop(of: tabBar)
    }
    
    private enum Constants {
        enum TAbBar {
            static let heightOffset: CGFloat = 49
        }
    }
    
    // MARK: - Properties
    
    private lazy var tabBar: UITabBar = {
        $0.backgroundColor = .gray
        $0.layer.shadowColor = UIColor.shadowTabBarColor.cgColor
        $0.layer.shadowOffset = CGSize(width: 0, height: -2)
        $0.layer.shadowRadius = 1
        $0.layer.shadowOpacity = 0.5
        $0.delegate = self
        return $0
    }(UITabBar())
    
    private let disposeBag = DisposeBag()
    private weak var child: UIViewController?
}

// MARK: - UITabBarDelegate

extension HomeViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        switch item.tag {
        case 0:
            listener?.didTapOnButton(.main)
        case 1:
            listener?.didTapOnButton(.profile)
        case 2:
            listener?.didTapOnButton(.favorites)
        default: return
        }
    }
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
    
    func setChild(_ child: UIViewController) {
        self.child?.removeChildFromParent()
        self.child = child
        addChild(child)
        view.insertSubview(child.view, at: 0)
        setupChildConstraints()
        child.didMove(toParent: self)
    }
}
