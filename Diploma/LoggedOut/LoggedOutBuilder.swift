//
//  LoggedOutBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol LoggedOutDependency: EmptyDependency {

}

final class LoggedOutComponent: Component<EmptyDependency> {

}

protocol LoggedOutBuildable: Buildable {
    func build() -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    func build() -> LoggedOutRouting {
        let viewController = LoggedOutViewController()
        let interactor = LoggedOutInteractor(presenter: viewController)
        return LoggedOutRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
