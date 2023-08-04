//
//  PhotoRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs

protocol PhotoInteractable: Interactable {
    var router: PhotoRouting? { get set }
}

protocol PhotoViewContollable: ViewControllable {
}

final class PhotoRouter: ViewableRouter<PhotoInteractable, PhotoViewContollable>, PhotoRouting {
    override init(
        interactor: PhotoInteractable,
        viewController: PhotoViewContollable
    ) {
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
}
