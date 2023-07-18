//
//  FavoritesBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol FavoritesDependency: EmptyDependency {

}

protocol FavoritesComponent: EmptyComponent {

}

protocol FavoritesBuildable: Buildable {
    func build() -> FavoritesRouting
}

final class FavoritesBuilder: Builder<FavoritesDependency>, FavoritesBuildable {
    func build() -> FavoritesRouting {
        let viewController = FavoritesViewController()
        let interactor = FavoritesInteractor(presenter: viewController)
        return FavoritesRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
