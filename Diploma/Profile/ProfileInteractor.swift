//
//  ProfileInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol ProfileRouting: ViewableRouting {
    
}

protocol ProfilePresentable: Presentable {
    
    var listener: ProfileViewContollerListener? { get set }
}

final class ProfileInteractor: PresentableInteractor <ProfilePresentable>, ProfileInteractable {
    
    weak var router: ProfileRouting?
    
    override init(presenter: ProfilePresentable) {
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

// MARK: - ProfileViewControllerListener

extension ProfileInteractor: ProfileViewContollerListener {
    
}
