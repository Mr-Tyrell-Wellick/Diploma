//
//  LoggedOutInteractor.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol LoggedOutRouting: ViewableRouting {
}

protocol LoggedOutPresentable: Presentable {
    var listener: LoggedOutViewControllerListener? { get set }
}

final class LoggedOutInteractor: PresentableInteractor<LoggedOutPresentable>, LoggedOutInteractable {

    weak var router: LoggedOutRouting?

    override init(presenter: LoggedOutPresentable) {
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

// MARK: - LoggedOutViewControllerListener
extension LoggedOutInteractor: LoggedOutViewControllerListener {
    
}
