//
//  MainBuilder.swift
//  Diploma
//
//  Created by Ульви Пашаев on 09.07.2023.
//

import RIBs

protocol MainDependecy: EmptyDependency {
    
}

final class MainComponent: EmptyComponent {
    
}

protocol MainBuildable: Buildable {
    func build() -> MainRouting
}

final class MainBuilder: Builder<MainDependecy>, MainBuildable {
    func build() -> MainRouting {
        let viewController = MainViewController()
        let interactor = MainInteractor(presenter: viewController)
        return MainRouter(
            interactor: interactor,
            viewController: viewController
        )
    }
}
