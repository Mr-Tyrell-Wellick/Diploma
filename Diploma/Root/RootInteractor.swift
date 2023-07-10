//
//  RootInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs

protocol RootRouting: ViewableRouting {
    func routeToHome()
    func routeToLoggedOut()
}

protocol RootPresentable: Presentable {
    var listener: RootViewControllerListener? { get set }
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable {
    
    weak var router: RootRouting?
    
    init(
        presenter: RootPresentable,
        userStream: UserStream
    ) {
        self.userStream = userStream
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        logActivate()
        subscribeOnUser()
    }
    
    override func willResignActive() {
        logDeactivate()
    }
    
    private func subscribeOnUser() {
        userStream
            .user
            .bind { [unowned self] user in
                guard user == nil else { return }
                router?.routeToLoggedOut()
            }
            .disposeOnDeactivate(interactor: self)
    }
    
    private var userStream: UserStream
}

// MARK: - RootViewControllerListener

extension RootInteractor: RootViewControllerListener {
    
}

// MARK: - LoggedOutListener

extension RootInteractor: LoggedOutListener {
    func didSuccessLogin() {
        router?.routeToHome()
    }
}
