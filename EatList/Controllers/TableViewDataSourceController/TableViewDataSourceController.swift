//
//  TableViewDataSourceController.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

protocol SectionUpdatable: UITableViewDataSource, UITableViewDelegate {
    associatedtype TableViewCellType
    func update(sections: [TableViewCellType])
}

protocol Paginatable {
    var reachedEndOfList: (IndexPath) -> Void { get set }
}

// Inspired by: https://www.alfianlosari.com/posts/slim-view-controller-through-uitableview-datasource-delegate-encapsulation/
class TableViewDataSourceController<U: TableViewCellTypeProtocol>: NSObject, UITableViewDataSource, UITableViewDelegate, SectionUpdatable, Paginatable {
    
    typealias TableViewCellType = U
    
    private var dataSource = [TableViewCellType]()
    private var tableView: UITableView
    var reachedEndOfList: (IndexPath) -> Void = { _ in }
    
    init(for tableView: UITableView) {
        self.tableView = tableView
        super.init()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard section < dataSource.count else {
            return 0
        }
        return dataSource.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard indexPath.row < dataSource.count else {
            return UITableViewCell()
        }
        let cellDataSource = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellDataSource.reuseIdentifier, for: indexPath)
        cellDataSource.cellSetupBlock?(cell)
        cell.layoutIfNeeded()
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < dataSource.count else {
            return .leastNormalMagnitude
        }
      
        return dataSource[indexPath.row].height
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard indexPath.row < dataSource.count else {
            return .leastNormalMagnitude
        }
        
        return dataSource[indexPath.row].estimatedHeight
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < dataSource.count else {
            return
        }
        let cellDataSource = dataSource[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath)
        cellDataSource.cellSelectBlock?(cell, indexPath)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < dataSource.count else {
            return
        }
        
        if indexPath.row == (dataSource.count - 1) { reachedEndOfList(indexPath) }
    }
}

extension TableViewDataSourceController {
    public func update(sections: [TableViewCellType]) {
        dataSource = sections
        
        UIView.transition(
            with: tableView,
            duration: 0.2,
            options: .transitionCrossDissolve,
            animations: {
                self.tableView.reloadData()
            }
        )
    }
}
