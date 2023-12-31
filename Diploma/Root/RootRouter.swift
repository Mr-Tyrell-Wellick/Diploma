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
    func dismiss(_ completionHandler: @escaping () -> ())
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
        viewController.dismiss { [unowned self] in
            detachChild(loggedOut)
            showHome()
        }
    }
    
    func routeToLoggedOut() {
        guard let home else {
            showLoggedOut()
            return
        }
        viewController.dismiss { [unowned self] in
            detachChild(home)
            showLoggedOut()
        }
    }
    
    private func showHome() {
        guard home == nil,
              let interactor = interactor as? HomeListener else { return }
        let home = homeBuilder.build(with: interactor)
        viewController.show(home.viewControllable.uiviewController)
        attachChild(home)
        self.home = home
    }
    
    private func showLoggedOut() {
        guard loggedOut == nil,
              let interactor = interactor as? LoggedOutListener else { return }
        let loggedOut = loggedOutBuilder.build(with: interactor)
        viewController.show(loggedOut.viewControllable.uiviewController)
        attachChild(loggedOut)
        self.loggedOut = loggedOut
    }
    
    // MARK: - Properties
    
    private let homeBuilder: HomeBuildable
    private let loggedOutBuilder: LoggedOutBuildable
    private weak var home: HomeRouting?
    private weak var loggedOut: LoggedOutRouting?
}
