//
//  FavoritesInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol FavoritesRouting: ViewableRouting {
    
}

protocol FavoritesPresentable: Presentable {
    
    var listener: FavoritesViewControllerListener? { get set }
}

final class FavoritesInteractor: PresentableInteractor<FavoritesPresentable>, FarovitesInteractable {
    
    weak var router: FavoritesRouting?
    
    override init(presenter: FavoritesPresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
    }
    
    override func willResignActive() {
        logDeactivate()
    }
}

// MARK: - FavoritesViewContollerListener

extension FavoritesInteractor: FavoritesViewControllerListener {
    
}
