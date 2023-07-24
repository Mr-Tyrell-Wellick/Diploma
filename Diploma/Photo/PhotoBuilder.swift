//
//  PhotoBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs

protocol PhotoDependency: EmptyDependency {
    
}

final class PhotoComponent: EmptyComponent {
    
}

protocol PhotoBuildable: Buildable {
    func build() -> PhotoRouting
}

final class PhotoBuilder: Builder<PhotoDependency>, PhotoBuildable {
    func build() -> PhotoRouting {
        let viewController = PhotoViewController()
        let interactor = PhotoInteractor(presenter: viewController)
        return PhotoRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
