//
//  RootRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs
import UIKit

protocol RootInteractable: Interactable {
    var router: RootRouting? { get set }
}

protocol RootViewControllable: ViewControllable {
    func show(_ vc: UIViewController)
    func dismiss(_ completionHandler: () -> ())
}

final class RootRouter: LaunchRouter<RootInteractable, RootViewControllable>, RootRouting {
    init(
        interactor: RootInteractable,
        viewController: RootViewControllable,
        homeBuilder: HomeBuildable,
        loggedOutBuilder: LoggedOutBuildable
    ) {
        self.homeBuilder = homeBuilder
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // MARK: - RootRouting

    func routeToHome() {
        guard let loggedOut else {
            showHome()
            return
        }
        viewController.dismiss {
            detachChild(loggedOut)
            showHome()
        }
    }

    func routeToLoggedOut() {
        guard let home else {
            showLoggedOut()
            return
        }
        viewController.dismiss {
            detachChild(home)
            showLoggedOut()
        }
    }

    private func showHome() {
        guard home == nil else { return }
        let home = homeBuilder.build()
        viewController.show(home.viewControllable.uiviewController)
        attachChild(home)
        self.home = home
    }

    private func showLoggedOut() {
        guard loggedOut == nil else { return }
        let loggedOut = loggedOutBuilder.build()
        viewController.show(loggedOut.viewControllable.uiviewController)
        attachChild(loggedOut)
        self.loggedOut = loggedOut
    }

    // MARK: - Properties

    private let homeBuilder: HomeBuildable
    private weak var home: HomeRouting?
    private let loggedOutBuilder: LoggedOutBuildable
    private weak var loggedOut: LoggedOutRouting?
}
