//
//  LoggedOutRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs
import UIKit

protocol LoggedOutInteractable: Interactable {
    var router: LoggedOutRouting? { get set }
}

protocol LoggedOutViewControllable: ViewControllable {

}

final class LoggedOutRouter: ViewableRouter<LoggedOutInteractable, LoggedOutViewControllable>, LoggedOutRouting {

    override init(interactor: LoggedOutInteractable, viewController: LoggedOutViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
