//
//  SignUpInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol SignUpRouting: ViewableRouting {
}

protocol SignUpPresentable: Presentable {
    var listener: SignUpViewControllerListener? { get set }
}

final class SignUpInteractor: PresentableInteractor<SignUpPresentable>, SignUpInteractable {

    weak var router: SignUpRouting?

    override init(presenter: SignUpPresentable) {
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

// MARK: - LoggedInViewControllerListener
extension SignUpInteractor: SignUpViewControllerListener {

}
