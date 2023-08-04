//
//  FavoritesRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol FarovitesInteractable: Interactable {
    var router: FavoritesRouting? { get set }
}

protocol FavoritesViewControllable: ViewControllable {

}

final class FavoritesRouter: ViewableRouter<FarovitesInteractable, FavoritesViewControllable>, FavoritesRouting {
    override init(
        interactor: FarovitesInteractable,
        viewController: FavoritesViewControllable) {
            super.init(
                interactor: interactor,
                viewController: viewController
            )
            interactor.router = self
        }
}
