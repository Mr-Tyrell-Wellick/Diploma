//
//  LoggedOutBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol LoggedOutDependency: EmptyDependency {
    var userMutableStream: UserMutableStream { get }
    var keychainService: KeychainService { get }
}

final class LoggedOutComponent: Component<LoggedOutDependency> {
    
    override init(dependency: LoggedOutDependency) {
        biometryAuthenticationService = BiometryAuthenticationServiceImpl()
        firebaseAuthenticationService = FirebaseAuthenticationServiceImpl(
            userStream: dependency.userMutableStream,
            keychainService: dependency.keychainService
        )
        userDefaultsStorage = UserDefaultsStorageImpl()
        super.init(dependency: dependency)
    }
    
    var biometryAuthenticationService: BiometryAuthenticationService
    
    var firebaseAuthenticationService: FirebaseAuthenticationService
    
    var userDefaultsStorage: UserDefaultsMutableStorage
}

extension LoggedOutComponent: SignUpDependency {
    
}

protocol LoggedOutBuildable: Buildable {
    func build(with listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {
    func build(with listener: LoggedOutListener) -> LoggedOutRouting {
        let viewController = LoggedOutViewController()
        let component = LoggedOutComponent(dependency: dependency)
        let interactor = LoggedOutInteractor(
            presenter: viewController,
            biometryAuthenticationService: component.biometryAuthenticationService,
            firebaseAuthentication: component.firebaseAuthenticationService,
            keychainService: dependency.keychainService,
            userDefaults: component.userDefaultsStorage
        )
        interactor.listener = listener
        let signUpBuilder = SignUpBuilder(dependency: component)
        return LoggedOutRouter(
            interactor: interactor,
            viewController: viewController,
            signUpBuilder: signUpBuilder
        )
    }
}
