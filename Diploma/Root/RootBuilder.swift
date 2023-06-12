//
//  RootBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs

final class RootComponent: Component<EmptyDependency> {
}
// TODO: - если что удалить!
//extension RootComponent: HomeDependency {

extension RootComponent: LoggedOutDependency {
    
}

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    func build() -> LaunchRouting {
let viewController = RootViewController()
        let interactor = RootInteractor(presenter: viewController)
        let component = RootComponent(dependency: EmptyComponent())
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOutBuilder
        )
    }
}
