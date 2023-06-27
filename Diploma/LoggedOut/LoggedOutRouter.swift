//
//  LoggedOutRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs
import UIKit

protocol LoggedOutInteractable: Interactable, SignUpListener {
    var router: LoggedOutRouting? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {
    func presentSheet(_ viewController: UIViewController)
}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>,
                             LoggedOutRouting {

    init(
        interactor: LoggedOutInteractable,
        viewController: LoggedOutViewControllable,
        signUpBuilder: SignUpBuildable
    ) {
        self.signUpBuilder = signUpBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    func routeToSignUp() {
        guard signUp == nil else { return }
        let signUp = signUpBuilder.build(with: interactor)
        viewController.presentSheet(signUp.viewControllable.uiviewController)
        attachChild(signUp)
        self.signUp = signUp
    }

    func signUpDidClose() {
        guard let signUp else { return }
        detachChild(signUp)
    }

    private let signUpBuilder: SignUpBuildable
    private weak var signUp: SignUpRouting?
}
