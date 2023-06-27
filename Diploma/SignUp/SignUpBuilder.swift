//
//  SignUpBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol SignUpDependency: EmptyDependency {
    var firebaseAuthenticationService: FirebaseAuthenticationService { get }
}

final class SignUpComponent: Component<SignUpDependency> {
    
}

protocol SignUpBuildable: Buildable {
    func build(with listener: SignUpListener) -> SignUpRouting
}

final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {
    func build(with listener: SignUpListener) -> SignUpRouting {
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(
            presenter: viewController,
            firebaseAuthenticationService: dependency.firebaseAuthenticationService
        )
        interactor.listener = listener
        return SignUpRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
