//
//  EatListViewController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class EatListViewController: UIViewController {

    struct Input {
        var viewModel: EatListViewModel
    }

    struct Output {
        var wantsToViewRestaurant: (RestaurantDetails) -> Void
    }
    
    var input: Input!
    var output: Output!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        input.viewModel.start()
    }
}

extension EatListViewController: StoryboardInstantiable {
    static func generateFromStoryboard(input: Input,
                                       output: Output) -> UIViewController {
        guard let eatListVC = R.storyboard.eatList.instantiateInitialViewController() else {
            fatalError("Expected an instantiable storyboard but got nil!")
        }
        eatListVC.input = input
        return eatListVC
    }
}
