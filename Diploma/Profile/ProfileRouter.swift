//
//  ProfileRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs
import UIKit

protocol ProfileInteractable: Interactable {
    var router: ProfileRouting? { get set }
}

protocol ProfileViewControllable: ViewControllable {
    func push(_ vc: UIViewController)
}

final class ProfileRouter: ViewableRouter<ProfileInteractable, ProfileViewControllable>, ProfileRouting {
    init(
        interactor: ProfileInteractable,
        viewController: ProfileViewControllable,
        photosBuilder: PhotoBuildable
    ) {
        self.photosBuilder = photosBuilder
        super.init(
            interactor: interactor,
            viewController: viewController
        )
        interactor.router = self
    }
    
    func openPhotosScreen() {
        guard photos == nil else { return }
        let photos = photosBuilder.build(with: self)
        attachChild(photos)
        viewController.push(photos.viewControllable.uiviewController)
        self.photos = photos
    }
    
    private let photosBuilder: PhotoBuildable
    private weak var photos: PhotoRouting?
}

// MARK: - PhotoListener

extension ProfileRouter: PhotoListener {
    func photoDidClose() {
        guard let photos else { return }
        detachChild(photos)
    }
}
