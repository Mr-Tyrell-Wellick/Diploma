//
//  LoggedOutBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol LoggedOutDependency: EmptyDependency {
    var userMutableStream: UserMutableStream { get }
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    
    override init(dependency: LoggedOutDependency) {
        biometryAuthenticationService = BiometryAuthenticationServiceImpl()
        firebaseAuthenticationService = FirebaseAuthenticationServiceImpl(
            userStream: dependency.userMutableStream
        )
        super.init(dependency: dependency)
    }
    
    var biometryAuthenticationService: BiometryAuthenticationService
    
    var firebaseAuthenticationService: FirebaseAuthenticationService
}

extension LoggedOutComponent: SignUpDependency {
    
}

protocol LoggedOutBuildable: Buildable {
    func build() -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    func build() -> LoggedOutRouting {
        let viewController = LoggedOutViewController()
        let component = LoggedOutComponent(dependency: dependency)
        let interactor = LoggedOutInteractor(
            presenter: viewController,
            biometryAuthenticationService: component.biometryAuthenticationService,
            firebaseAuthentication: component.firebaseAuthenticationService
        )
        let signUpBuilder = SignUpBuilder(dependency: component)
        return LoggedOutRouter(
            interactor: interactor,
            viewController: viewController,
            signUpBuilder: signUpBuilder
        )
    }
}
