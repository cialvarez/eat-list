//
//  TableViewDataSourceController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

// Inspired by: https://www.alfianlosari.com/posts/slim-view-controller-through-uitableview-datasource-delegate-encapsulation/
class TableViewDataSourceController<T, U: TableViewCellTypeProtocol>: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    typealias TableViewCellModelType = T
    typealias TableViewCellType = U
    
    let tableViewDataSource: TableViewDataManager<TableViewCellModelType, TableViewCellType>
    var tableView: UITableView
    
    init(dataManager: TableViewDataManager<TableViewCellModelType, TableViewCellType>, for tableView: UITableView) {
        self.tableViewDataSource = dataManager
        self.tableView = tableView
        self.tableViewDataSource.reloadData = { [weak tableView] in
            guard let tableView = tableView else { return }
            UIView.transition(with: tableView,
                              duration: 0.2,
                              options: .transitionCrossDissolve,
                              animations: { tableView.reloadData() })
        }
        
        self.tableViewDataSource.reloadRows = { [weak tableView] indices in
            guard let tableView = tableView else { return }
            let indexPaths = indices.map { IndexPath(row: $0, section: 0) }
            tableView.reloadRows(at: indexPaths, with: .none)
        }
        super.init()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < tableViewDataSource.dataSource.count else {
            return 0
        }
        return tableViewDataSource.dataSource.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < tableViewDataSource.dataSource.count else {
            return UITableViewCell()
        }
        let cellDataSource = tableViewDataSource.dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDataSource.identifier, for: indexPath)
        cellDataSource.setupCell?(cell, cellDataSource.data)
        cell.layoutIfNeeded()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < tableViewDataSource.dataSource.count else {
            return .leastNormalMagnitude
        }
      
        return tableViewDataSource.dataSource[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < tableViewDataSource.dataSource.count else {
            return .leastNormalMagnitude
        }
        
        return tableViewDataSource.dataSource[indexPath.row].rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < tableViewDataSource.dataSource.count else {
            return
        }
        let cellDataSource = tableViewDataSource.dataSource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cellDataSource.didSelectCell?(cell, cellDataSource.data)
    }
}
