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
        // TODO:
        let eatListVC = EatListViewController()
        navigationController.pushViewController(eatListVC, animated: false)
    }
}
