//
//  HomeInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs

protocol HomeRouting: ViewableRouting {
    func routeToGeneral()
    func routeToProfile()
    func routeToFavorites()
}

protocol HomePresentable: Presentable {
    var listener: HomeViewContollerListener? { get set }
}

final class HomeInteractor: PresentableInteractor<HomePresentable>, HomeInteractable {

    weak var router: HomeRouting?

    override init(presenter: HomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        logActivate()
    }

    override func willResignActive() {
        logDeactivate()
    }
}

// MARK: - HomeViewControllerListener

extension HomeInteractor: HomeViewContollerListener {
    func didTapOnButton(_ type: HomeTabBarButtonType) {
        switch type {
        case .general:
            router?.routeToGeneral()
        case .favorites:
            router?.routeToFavorites()
        case .profile:
            router?.routeToProfile()
        }


    }
}
