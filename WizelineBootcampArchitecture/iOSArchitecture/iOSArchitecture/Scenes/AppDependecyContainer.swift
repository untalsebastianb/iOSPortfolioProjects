//
//  AppDependecyContainer.swift
//  iOSArchitecture
//
//  Created by Osmar Hernandez on 28/06/22.
//

import UIKit

final class AppDependecyContainer {
    
    let signInDependencyContainer: SignInDependencyContainer
    let searchDependencyContainer: SearchDependencyContainer
    
    init() {
        self.signInDependencyContainer = SignInDependencyContainer()
        self.searchDependencyContainer = SearchDependencyContainer()
    }
    
    private func makeSearchScene() -> UINavigationController {
        let searchViewController = searchDependencyContainer.makeSearchViewController()
        let navigationController = makeNavigationController(searchViewController)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return navigationController
    }
    
    private func makeFavoriteScene() -> UINavigationController {
        let searchViewController = searchDependencyContainer.makeSearchViewController()
        let navigationController = makeNavigationController(searchViewController)
        navigationController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        return navigationController
    }
    
    private func makeHomeScene() -> UITabBarController {
        let searchScreen = makeSearchScene()
        let mockFavoriteScreen = makeFavoriteScene()
        
        let homeVC = UITabBarController()
        homeVC.modalPresentationStyle = .fullScreen
        homeVC.viewControllers = [searchScreen, mockFavoriteScreen]
        
        return homeVC
    }
    
    private func makeNavigationController(_ rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController.navigationBar.backgroundColor = .black
        navigationController.navigationBar.barTintColor = .black
        navigationController.navigationBar.isTranslucent = false
        return navigationController
    }
    
    func makeInitialViewController() -> SignInViewController {
        let home = makeHomeScene()
        return signInDependencyContainer.makeSignInViewController(home)
    }
}
