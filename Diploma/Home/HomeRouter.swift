//
//  HomeRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs
import UIKit

protocol HomeInteractable: Interactable {
    var router: HomeRouting? { get set }
}

protocol HomeViewControllable: ViewControllable {
    
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {

    override init(interactor: HomeInteractable, viewController: HomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }

    // TODO: - прописать функционал

    func routeToGeneral() {

    }

    func routeToProfile() {

    }

    func routeToFavorites() {

    }
}
