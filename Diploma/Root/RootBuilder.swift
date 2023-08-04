//
//  RootBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 06.06.2023.
//

import RIBs

final class RootComponent: Component<EmptyDependency> {
    override init(dependency: EmptyDependency) {
        self.userMutableStream = UserMutableStreamImpl()
        self.keychainService = KeychainServiceImpl()
        super.init(dependency: dependency)
    }
    
    var userMutableStream: UserMutableStream
    var keychainService: KeychainService
}

extension RootComponent: HomeDependency {
}

extension RootComponent: LoggedOutDependency {
}

protocol RootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    func build() -> LaunchRouting {
        let viewController = RootViewController()
        let component = RootComponent(dependency: EmptyComponent())
        let interactor = RootInteractor(
            presenter: viewController,
            userStream: component.userMutableStream
        )
        let homeBuilder = HomeBuilder(dependency: component)
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            homeBuilder: homeBuilder,
            loggedOutBuilder: loggedOutBuilder
        )
    }
}
