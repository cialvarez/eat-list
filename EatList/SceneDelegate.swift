//
//  SceneDelegate.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit
import Unrealm

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var coordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = scene as? UIWindowScene else {
            return
        }
        
        let navigationController = UINavigationController()
        setupCoordinator(with: navigationController)
        setupWindow(with: navigationController, and: windowsScene)
        setupRealm()
    }
    
    private func setupCoordinator(with navigationController: UINavigationController) {
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
    }
    
    private func setupWindow(with rootViewController: UIViewController,
                             and windowScene: UIWindowScene) {
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func setupRealm() {
        Realm.registerRealmables(Restaurant.self)
    }

}
