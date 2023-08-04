//
//  HomeRouter.swift
//  Diploma
//
//  Created by Ульви Пашаев on 30.06.2023.
//

import RIBs
import UIKit

protocol HomeInteractable: Interactable {
    var router: HomeRouting? { get set }
}

protocol HomeViewControllable: ViewControllable {
    
    func setChild(_ child: UIViewController)
}

final class HomeRouter: ViewableRouter<HomeInteractable, HomeViewControllable>, HomeRouting {
    
    init(
        interactor: HomeInteractable,
        viewController: HomeViewControllable,
        mainBuilder: MainBuildable,
        profileBuilder: ProfileBuildable,
        favoritesBuilder: FavoritesBuildable
    ) {
        self.mainBuilder = mainBuilder
        self.profileBuilder = profileBuilder
        self.favoritesBuilder = favoritesBuilder
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func routeToMain() {
        if main == nil {
            let main = mainBuilder.build()
            attachChild(main)
            self.main = main
        }
        if mainNavigationController == nil {
            mainNavigationController = UINavigationController(
                rootViewController: main!.viewControllable.uiviewController
            )
        }
        viewController.setChild(mainNavigationController!)
    }
    
    func routeToProfile() {
        if profile == nil {
            let profile = profileBuilder.build()
            attachChild(profile)
            self.profile = profile
        }
        if profileNavigationController == nil {
            profileNavigationController = UINavigationController(
                rootViewController: profile!.viewControllable.uiviewController
            )
        }
        viewController.setChild(profileNavigationController!)
    }
    
    func routeToFavorites() {
        if favorites == nil {
            let favorites = favoritesBuilder.build()
            attachChild(favorites)
            self.favorites = favorites
        }
        if favoritesNavigationController == nil {
            favoritesNavigationController = UINavigationController(
                rootViewController: favorites!.viewControllable.uiviewController
            )
        }
        viewController.setChild(favoritesNavigationController!)
    }
    
    // MARK: - Properties
    
    private var favoritesNavigationController: UINavigationController?
    private var mainNavigationController: UINavigationController?
    private var profileNavigationController: UINavigationController?
    
    private let mainBuilder: MainBuildable
    private let profileBuilder: ProfileBuildable
    private let favoritesBuilder: FavoritesBuildable
    
    private weak var main: MainRouting?
    private weak var profile: ProfileRouting?
    private weak var favorites: FavoritesRouting?
}
