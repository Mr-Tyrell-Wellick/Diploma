//
//  ProfileBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol ProfileDependency {
    var postsService: PostsService { get }
    var myPostsStream: PostsStream { get }
}

final class ProfileComponent: EmptyComponent {
    
}

protocol ProfileBuildable: Buildable {
    func build() -> ProfileRouting
}

final class ProfileBuilder: Builder<ProfileDependency>, ProfileBuildable {
    func build() -> ProfileRouting {
        let viewController = ProfileViewController()
        let interactor = ProfileInteractor(
            presenter: viewController,
            postsService: dependency.postsService,
            myPostsStream: dependency.myPostsStream
        )
        return ProfileRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
