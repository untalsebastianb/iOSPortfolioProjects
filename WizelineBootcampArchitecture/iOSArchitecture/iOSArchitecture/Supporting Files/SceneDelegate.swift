//
//  SceneDelegate.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 22/06/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    private let appDependecyContainer = AppDependecyContainer()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        
        if let window = window {
            
            window.rootViewController = appDependecyContainer.makeInitialViewController()
            window.makeKeyAndVisible()
        }
    }
}

