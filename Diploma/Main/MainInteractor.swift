//
//  MainInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol MainRouting: ViewableRouting {
    
}

protocol MainPresentable: Presentable {
    
    var listener: MainViewControllerListener? { get set }
}

final class MainInteractor: PresentableInteractor<MainPresentable>, MainInteractable {
    
    weak var router: MainRouting?
    
    override init(presenter: MainPresentable) {
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

// MARK: - MainViewControllerListener

extension MainInteractor: MainViewControllerListener {
    
}
