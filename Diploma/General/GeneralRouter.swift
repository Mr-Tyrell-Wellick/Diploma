//
//  GeneralRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol GeneralInteractable: Interactable {
    var router: GeneralRouting? { get set }
}

protocol GeneralViewControllable: ViewControllable {

}

final class GeneralRouter: ViewableRouter<GeneralInteractable, GeneralViewControllable>, GeneralRouting {
    override init(interactor: GeneralInteractable, viewController: GeneralViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
