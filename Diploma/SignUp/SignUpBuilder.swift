//
//  SignUpBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 07.06.2023.
//

import RIBs

protocol SignUpDependency: EmptyDependency {

}

final class SignUpComponent: Component<EmptyDependency> {

}

protocol SignUpBuildable: Buildable {
    func build() -> SignUpRouting
}

final class SignUpBuilder: Builder<SignUpDependency>, SignUpBuildable {
    func build() -> SignUpRouting {
        let viewController = SignUpViewController()
        let interactor = SignUpInteractor(presenter: viewController)
        return SignUpRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
