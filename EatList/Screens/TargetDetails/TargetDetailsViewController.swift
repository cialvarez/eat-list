//
//  TargetDetailsViewController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class TargetDetailsViewController: UIViewController {
    
    struct Input {
        var viewModel: TargetDetailsViewModel
        var restaurantDetails: RestaurantDetails
    }
    
    struct Output { }
    
    private var input: Input!
    private var output: Output!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var dataSourceProvider = TableViewDataSourceController<TargetDetailsSectionType>(for: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation(title: input.restaurantDetails.name)
    }
    
    func setupTableView() {
        tableView.register(ImageHeaderTableViewCell.self)
        tableView.register(BaseDetailsTableViewCell.self)
        tableView.register(AddressDetailsTableViewCell.self)
        tableView.register(HighlightsTableViewCell.self)
        tableView.separatorStyle = .none
    }
    
    func setupDataSource() {
        tableView.dataSource = dataSourceProvider
        tableView.delegate = dataSourceProvider
    }
    
    func setupViewModel() {
        let output = input.viewModel.transform(input: .init(restaurantDetails: input.restaurantDetails))
        dataSourceProvider.update(sections: output.tableViewCellItems)
    }
}

extension TargetDetailsViewController: StoryboardInstantiable {
    static func generateFromStoryboard(input: Input, output: Output = .init()) -> UIViewController {
        guard let targetDetailsVC = R.storyboard.targetDetails.instantiateInitialViewController() else {
            fatalError("Expected an instantiable storyboard but got nil!")
        }
        targetDetailsVC.input = input
        targetDetailsVC.output = output
        return targetDetailsVC
    }
}
