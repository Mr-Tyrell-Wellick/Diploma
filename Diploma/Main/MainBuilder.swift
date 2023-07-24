//
//  MainBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol MainDependecy {
    var postsService: PostsService { get }
    var friendsPostsStream: PostsStream { get }
}

final class MainComponent: EmptyComponent {
    
}

protocol MainBuildable: Buildable {
    func build() -> MainRouting
}

final class MainBuilder: Builder<MainDependecy>, MainBuildable {
    func build() -> MainRouting {
        let viewController = MainViewController()
        let interactor = MainInteractor(
            presenter: viewController,
            postsService: dependency.postsService,
            friendsPostsStream: dependency.friendsPostsStream
        )
        return MainRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
