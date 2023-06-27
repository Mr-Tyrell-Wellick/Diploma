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
         loggedOutBuilder: LoggedOutBuildable
    ) {
        self.loggedOutBuilder = loggedOutBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }


    // TODO: - Дописать!
    //    func routeToHome() {
    //
    //    }

    func routeToLoggedOut() {
        guard loggedOut == nil else { return }
        let loggedOut = loggedOutBuilder.build()
        viewController.show(loggedOut.viewControllable.uiviewController)
        attachChild(loggedOut)
        self.loggedOut = loggedOut
    }

    // MARK: - Properties

    private let loggedOutBuilder: LoggedOutBuildable
    private weak var loggedOut: LoggedOutRouting?

}
