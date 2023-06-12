//
//  RootInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs

protocol RootRouting: ViewableRouting {
    //    func routeToHome()
    func routeToLoggedOut()
}

protocol RootPresentable: Presentable {
    var listener: RootViewControllerListener? { get set }
}

final class RootInteractor:
    PresentableInteractor<RootPresentable>, RootInteractable {
        weak var router: RootRouting?

        override init(presenter: RootPresentable) {
            super.init(presenter: presenter)
            presenter.listener = self
        }

        override func didBecomeActive() {
            logActivate()
            router?.routeToLoggedOut()
        }

        override func willResignActive() {
            logDeactivate()
        }
    }

    // MARK: - RootViewControllerListener

extension RootInteractor: RootViewControllerListener {

}
