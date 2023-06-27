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
        super.init(dependency: dependency)
    }

    var userMutableStream: UserMutableStream

}
// TODO: - потом добавить!
//extension RootComponent: HomeDependency {

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
        let loggedOutBuilder = LoggedOutBuilder(dependency: component)
        return RootRouter(
            interactor: interactor,
            viewController: viewController,
            loggedOutBuilder: loggedOutBuilder
        )
    }
}
