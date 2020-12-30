//
//  TargetDetailsViewController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/28/20.
//

import UIKit

class TargetDetailsViewController: UIViewController {
    
    struct Input {
        var viewModel: TargetDetailsProvider
    }
    
    struct Output { }
    
    private var viewModel: TargetDetailsProvider!
    
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var dataSourceProvider = TableViewDataSourceController<TargetDetailsSectionType>(for: tableView)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupDataSource()
        setupViewModelBindings()
        viewModel.processDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation(title: viewModel.navBarTitle)
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
    
    func setupViewModelBindings() {
        viewModel.wantsToUpdateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .loading: break
            case .error(let error): self.showError(error: error)
            case .finished(let sections):
                self.dataSourceProvider.update(sections: sections)
                self.view.hero.id = self.viewModel.backgroundHeroId
            }
        }
    }
}

extension TargetDetailsViewController: StoryboardInstantiable {
    static func generateFromStoryboard(input: Input, output: Output = .init()) -> UIViewController {
        guard let targetDetailsVC = R.storyboard.targetDetails.instantiateInitialViewController() else {
            fatalError("Expected an instantiable storyboard but got nil!")
        }
        targetDetailsVC.viewModel = input.viewModel
        return targetDetailsVC
    }
}
