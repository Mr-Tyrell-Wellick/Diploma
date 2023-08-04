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
