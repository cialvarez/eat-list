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
        let eatListVC = createEatListVC()
        navigationController.pushViewController(eatListVC, animated: false)
    }
    
    func createEatListVC() -> UIViewController {
        let viewModel = EatListViewModel()
        let input = EatListViewController.Input(viewModel: viewModel)
        let output = EatListViewController.Output { restaurantDetails in
            print("Wants to go to restaurant: \(restaurantDetails)")
        }
        return EatListViewController.generateFromStoryboard(input: input, output: output)
    }
}
