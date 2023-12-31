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
    func routeToMain()
    func routeToProfile()
    func routeToFavorites()
}

protocol HomePresentable: Presentable {
    var listener: HomeViewContollerListener? { get set }
    
    func setupTabBarItems(_ viewModel: [TabBarItemViewModel])
}

protocol HomeListener: AnyObject {
    func closeHome()
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable {
    
    weak var router: HomeRouting?
    weak var listener: HomeListener?
    
    init(presenter: HomePresentable,
         coreDataService: CoreDataService
    ) {
        self.coreDataService = coreDataService
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        setupIfNeeded()
            .subscribe(onCompleted: { [unowned self] in
                subscribeOnUiReady()
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    override func willResignActive() {
        logDeactivate()
    }
    
    private func setupIfNeeded() -> Completable {
        guard !UserDefaults.standard.bool(forKey: "isFirstLoad") else { return .empty() }
        UserDefaults.standard.set(true, forKey: "isFirstLoad")
        return coreDataService.initStorage()
    }
    
    private func subscribeOnUiReady() {
        uiReady.filter { $0 }
            .bind { [unowned self] _ in
                router?.routeToMain()
                presenter.setupTabBarItems(
                    [
                        TabBarItemViewModel(
                            name: Strings.mainItemName.localized,
                            image: .homeTabBarImage,
                            tag: 0
                        ),
                        TabBarItemViewModel(
                            name: Strings.profileItemName.localized,
                            image: .profileTabBarImage,
                            tag: 1
                        ),
                        TabBarItemViewModel(
                            name: Strings.favoritesItemName.localized,
                            image: .favoritesTabBarImage,
                            tag: 2
                        )
                    ]
                )
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private let coreDataService: CoreDataService
    private let uiReady = BehaviorRelay<Bool>(value: false)
}

// MARK: - HomeViewControllerListener

extension HomeInteractor: HomeViewContollerListener {
    func didTapOnButton(_ type: TabBarButtonType) {
        switch type {
        case .main:
            router?.routeToMain()
        case .profile:
            router?.routeToProfile()
        case .favorites:
            router?.routeToFavorites()
        }
    }
    
    func didLoad() {
        uiReady.accept(true)
    }
}
