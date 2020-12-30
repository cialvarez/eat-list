//
//  AppDelegate.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit
import Unrealm
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var coordinator: MainCoordinator?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        setupCoordinator(with: navigationController)
        setupWindow(with: navigationController)
        setupRealm()
        return true
    }
    
    private func setupCoordinator(with navigationController: UINavigationController) {
        coordinator = MainCoordinator(navigationController: navigationController)
        coordinator?.start()
    }
    
    private func setupWindow(with rootViewController: UIViewController) {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    
    private func setupRealm() {
        Realm.registerRealmables(Restaurant.self)
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
