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
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        input.viewModel.start()
    }
    
    private func setupTableView() {
        let eatListCell = R.nib.eatListTableViewCell
        tableView.register(UINib(resource: eatListCell), forCellReuseIdentifier: eatListCell.name)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension EatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension EatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.eatListTableViewCell.name) as? EatListTableViewCell else {
            fatalError("Expected an EatListTableViewCell instance but got something else!")
        }
        return cell
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
