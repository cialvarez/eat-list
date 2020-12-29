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
        setupNavigation()
    }
    
    func setupTableView() {
        tableView.register(UINib(resource: R.nib.imageHeaderTableViewCell),
                           forCellReuseIdentifier: R.nib.imageHeaderTableViewCell.name)
        tableView.register(UINib(resource: R.nib.baseDetailsTableViewCell),
                           forCellReuseIdentifier: R.nib.baseDetailsTableViewCell.name)
        tableView.register(UINib(resource: R.nib.addressDetailsTableViewCell),
                           forCellReuseIdentifier: R.nib.addressDetailsTableViewCell.name)
        tableView.register(UINib(resource: R.nib.highlightsTableViewCell),
                           forCellReuseIdentifier: R.nib.highlightsTableViewCell.name)
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
    
    func setupNavigation() {
        navigationController?.navigationBar.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
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
