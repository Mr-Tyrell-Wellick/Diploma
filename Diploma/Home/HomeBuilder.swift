//
//  HomeBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs

protocol HomeDependency: EmptyDependency {

}

final class HomeComponent: Component<EmptyDependency> {

}

protocol HomeBuildable: Buildable {
    func build() -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    func build() -> HomeRouting {
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController)
        return HomeRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
