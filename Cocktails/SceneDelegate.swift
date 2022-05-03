//
//  SceneDelegate.swift
//  Cocktails
//
//  Created by Andrew on 27.04.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let firstScreenViewController = CocktailsListFabric.createViewController()
        let navigationController = UINavigationController(rootViewController: firstScreenViewController)
      
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }
}

