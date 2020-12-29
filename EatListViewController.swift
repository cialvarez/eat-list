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
    
    // MARK: - Convenience accessors
    var viewModel: EatListViewModel {
        return input.viewModel
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView() {
        let eatListCell = R.nib.eatListTableViewCell
        tableView.register(UINib(resource: eatListCell), forCellReuseIdentifier: eatListCell.name)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
    
    private func setupViewModel() {
        viewModel.start(
            output: .init(
                list: [],
                restaurants: [],
                stateChanged: { [weak self] state in
                    guard let self = self else { return }
                    switch state {
                    case .loading: print("Loading") // TODO: - Add loading indicator
                    case .finished: self.tableView.reloadData()
                    case .error(let error): print("Error occured with \(error)")
                    }
                }
            ))
    }
}

extension EatListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.output.restaurants.count else {
            fatalError("Expected selected index to be lower than the restaurant count!")
        }
        output.wantsToViewRestaurant(viewModel.output.restaurants[indexPath.row].restaurant)
    }
}

extension EatListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.output.list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.eatListTableViewCell.name) as? EatListTableViewCell,
              indexPath.row < viewModel.output.list.count else {
            fatalError("EatListTableViewCell is not configured properly!")
        }
        cell.configure(with: viewModel.output.list[indexPath.row])
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
        eatListVC.output = output
        return eatListVC
    }
}
