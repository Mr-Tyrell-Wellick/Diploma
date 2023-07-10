//
//  GeneralBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol GeneralDependecy: EmptyDependency {

}

final class GeneralComponent: EmptyComponent {

}

protocol GeneralBuildable: Buildable {
    func build() -> GeneralRouting
}

final class GeneralBuilder: Builder<GeneralDependecy>, GeneralBuildable {
    func build() -> GeneralRouting {
        let viewController = GeneralViewController()
        let interactor = GeneralInteractor(presenter: viewController)
        return GeneralRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
