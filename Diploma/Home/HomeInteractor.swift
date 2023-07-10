//
//  HomeInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs
import RxSwift
import RxRelay
import UIKit

struct TabBarItemViewModel {
    let name: String
    let image: UIImage
    let tag: Int
}

protocol HomeRouting: ViewableRouting {
    func routeToGeneral()
    func routeToProfile()
    func routeToFavorites()
}

protocol HomePresentable: Presentable {
    var listener: HomeViewContollerListener? { get set }
    
    func setupTabBarItems(_ viewModel: [TabBarItemViewModel])
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable {
    
    weak var router: HomeRouting?
    
    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnUiReady()
    }
    
    override func willResignActive() {
        logDeactivate()
        
    }
    
    private func subscribeOnUiReady() {
        uiReady.filter { $0 }
            .bind { [unowned self] _ in
                presenter.setupTabBarItems(
                    [
                        TabBarItemViewModel(
                            name: "General",
                            image: .homeTabBarImage,
                            tag: 0
                        ),
                        TabBarItemViewModel(
                            name: "Profile",
                            image: .profileTabBarImage,
                            tag: 1
                        ),
                        TabBarItemViewModel(
                            name: "Favorites",
                            image: .favoritesTabBarImage,
                            tag: 2
                        )
                    ]
                )
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private let uiReady = BehaviorRelay<Bool>(value: false)
}

// MARK: - HomeViewControllerListener

extension HomeInteractor: HomeViewContollerListener {
    func didTapOnButton(/*_ type: HomeTabBarButtonType*/) {
        //        switch type {
        //        case .general:
        //            router?.routeToGeneral()
        //        case .favorites:
        //            router?.routeToFavorites()
        //        case .profile:
        //            router?.routeToProfile()
        //        }
    }
    
    func didLoad() {
        uiReady.accept(true)
    }
}
