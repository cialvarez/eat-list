//
//  TargetDetailsViewController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class TargetDetailsViewController: UIViewController {
    
    struct Input {
        var restaurantDetails: RestaurantDetails
    }
    
    struct Output { }
    
    var input: Input!
    var output: Output!
    
    @IBOutlet weak var tableView: UITableView!
    private var dataManager = TableViewDataManager<RestaurantDetails, TargetDetailsSectionType>()
    private lazy var dataSourceProvider =
        TableViewDataSourceController<RestaurantDetails, TargetDetailsSectionType>(dataManager: dataManager, for: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        setupSections()
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
    
    func setupSections() {
        dataManager.setItems(sections: [
            .imageHeader,
            .baseDetails,
            .addressDetails,
            .highlights
        ])
        dataManager.model = input.restaurantDetails
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
