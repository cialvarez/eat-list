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
        showEatList()
    }
    
    private func showEatList() {
        let viewModel = EatListViewModel()
        let input = EatListViewController.Input(viewModel: viewModel)
        let output = EatListViewController.Output { [weak self] restaurantDetails in
            self?.showDetails(restaurantDetails: restaurantDetails)
        }
        let eatListVC = EatListViewController.generateFromStoryboard(input: input, output: output)
        navigationController.pushViewController(eatListVC, animated: false)
    }
    
    private func showDetails(restaurantDetails: RestaurantDetails) {
        let input = TargetDetailsViewController.Input(restaurantDetails: restaurantDetails)
        let targetDetailsVC = TargetDetailsViewController.generateFromStoryboard(input: input)
        navigationController.pushViewController(targetDetailsVC, animated: true)
    }
}
