//
//  ProfileBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol ProfileDependency: EmptyDependency {
    
}

final class ProfileComponent: EmptyComponent {
    
}

protocol ProfileBuildable: Buildable {
    func build() -> ProfileRouting
}

final class ProfileBuilder: Builder<ProfileDependency>, ProfileBuildable {
    func build() -> ProfileRouting {
        let viewController = ProfileViewController()
        let interactor = ProfileInteractor(presenter: viewController)
        return ProfileRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
