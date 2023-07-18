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

extension HomeComponent: MainDependecy {
}

extension HomeComponent: ProfileDependency {
}

extension HomeComponent: FavoritesDependency {
}


protocol HomeBuildable: Buildable {
    func build(with listener: HomeListener) -> HomeRouting
}

final class HomeBuilder: Builder<HomeDependency>, HomeBuildable {
    func build(with listener: HomeListener) -> HomeRouting {
        let viewController = HomeViewController()
        let interactor = HomeInteractor(presenter: viewController)
        interactor.listener = listener
        let component = HomeComponent(dependency: EmptyComponent())
        let mainBuilder = MainBuilder(dependency: component)
        let profileBuilder = ProfileBuilder(dependency: component)
        let favoritesBuilder = FavoritesBuilder(dependency: component)

        return HomeRouter(
            interactor: interactor,
            viewController: viewController,
            mainBuilder: mainBuilder,
            profileBuilder: profileBuilder,
            favoritesBuilder: favoritesBuilder
        )
    }
}
