//
//  MainRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol MainInteractable: Interactable {
    var router: MainRouting? { get set }
}

protocol MainViewControllable: ViewControllable {
    
}

final class MainRouter: ViewableRouter<MainInteractable, MainViewControllable>, MainRouting {
    override init(
        interactor: MainInteractable,
        viewController: MainViewControllable
    ) {
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
}
