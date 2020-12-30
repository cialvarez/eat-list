//
//  EatListViewController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class EatListViewController: UIViewController {
    
    struct Input {
        var viewModel: EatListProvider
    }
    
    struct Output {
        var wantsToViewRestaurant: (RestaurantDetails) -> Void
    }
    
    private var wantsToViewRestaurant: (RestaurantDetails) -> Void = { _ in }
    private var viewModel: EatListProvider!
    private lazy var dataSourceProvider = TableViewDataSourceController<EatListSectionType>(for: tableView)
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupLocationUpdateControl()
        setupBindings()
        viewModel.fetchList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation(title: "Eat List")
    }
    
    private func setupTableView() {
        tableView.register(EatListTableViewCell.self)
        tableView.dataSource = dataSourceProvider
        tableView.delegate = dataSourceProvider
        tableView.separatorStyle = .none
    }
    
    private func setupBindings() {
        viewModel.wantsToUpdateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading:
                let skeletonCells = Array(repeating: EatListSectionType.skeletonLoader, count: 20)
                self.dataSourceProvider.update(sections: skeletonCells)
                self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                self.tableView.isUserInteractionEnabled = false
                self.navigationItem.rightBarButtonItem?.isEnabled = false
            case .error(let error):
                self.showError(error: error)
                self.tableView.isUserInteractionEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            case let .finished(sections, source):
                self.dataSourceProvider.update(sections: sections)
                if source == .cache { self.showOfflineBanner() }
                self.tableView.isUserInteractionEnabled = true
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        }
        viewModel.wantsToViewRestaurant = wantsToViewRestaurant
    }
    
    private func setupLocationUpdateControl() {
        setupCustomRightBarButton(image: R.image.locationUpdate()) { [weak self] in
            self?.viewModel.fetchList()
        }
    }
}

extension EatListViewController: StoryboardInstantiable {
    static func generateFromStoryboard(input: Input,
                                       output: Output) -> UIViewController {
        guard let eatListVC = R.storyboard.eatList.instantiateInitialViewController() else {
            fatalError("Expected an instantiable storyboard but got nil!")
        }
        eatListVC.viewModel = input.viewModel
        eatListVC.wantsToViewRestaurant = output.wantsToViewRestaurant
        return eatListVC
    }
}
