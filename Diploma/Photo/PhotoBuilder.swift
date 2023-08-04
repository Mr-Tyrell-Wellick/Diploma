//
//  PhotoBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 19.07.2023.
//

import RIBs

protocol PhotoDependency {
    var photoService: PhotoService { get }
}

final class PhotoComponent: Component<PhotoDependency> {
}

protocol PhotoBuildable: Buildable {
    func build(with listener: PhotoListener) -> PhotoRouting
}

final class PhotoBuilder: Builder<PhotoDependency>, PhotoBuildable {
    func build(with listener: PhotoListener) -> PhotoRouting {
        let viewController = PhotoViewController()
        let interactor = PhotoInteractor(
            presenter: viewController,
            photoService: dependency.photoService
        )
        interactor.listener = listener
        return PhotoRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
