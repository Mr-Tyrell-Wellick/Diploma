//
//  SceneDelegate.swift
//  Diploma
//
//  Created by Ульви Пашаев on 02.06.2023.
//
import RIBs
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var launchRouter: LaunchRouting!
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        launchRouter = RootBuilder(dependency: EmptyComponent()).build()
        launchRouter.launch(from: window)
        self.window = window
    }
}







//
//        // MARK: - 1
//        // Создаем coordinator и передаем в него transitionHandler
//        rootCoordinator = RootCoordinator()
//        let rootVC = rootCoordinator.build()
//
//        // MARK: - 2
//        // обращаемся к методу, который позволяет кастомизировать TabBar под себя
//        UITabBar.appearance().tintColor = UIColor .systemBlue
//        UITabBar.appearance().backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1)
//
//        // MARK: - 3
//        // заполняем окно, назначаем ему рутовый экран и делаем видимым
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = rootVC
//        window.makeKeyAndVisible()
//        self.window = window
//    }
//}
