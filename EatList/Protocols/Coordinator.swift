//
//  Coordinator.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
