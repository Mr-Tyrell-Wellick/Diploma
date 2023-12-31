//
//  SignUpRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol SignUpInteractable: Interactable {
    var router: SignUpRouting? { get set }
    var listener: SignUpListener? { get set }
}

protocol SignUpViewControllable: ViewControllable {
    
}

final class SignUpRouter: ViewableRouter<SignUpInteractable,SignUpViewControllable>,
                          SignUpRouting {
    
    override init(interactor: SignUpInteractable, viewController: SignUpViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
