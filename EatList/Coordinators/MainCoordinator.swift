//
//  MainCoordinator.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        guard let eatListVC = R.storyboard.eatList.instantiateInitialViewController() else {
            fatalError("Expected an instantiable storyboard but got nil!")
        }
        navigationController.pushViewController(eatListVC, animated: false)
    }
}
