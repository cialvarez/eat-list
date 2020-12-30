//
//  TableViewDataManager.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class TableViewDataManager<T, U: TableViewCellTypeProtocol>: TableViewDataProviderProtocol {
    
    typealias TableViewCellModelType = T
    typealias TableViewCellType = U
    
    var dataSource = [TableViewCellDataSource]()
    
    var reloadData: (() -> Void)?
    
    var reloadRows: ((_ at: [Int]) -> Void)?
    
    var currentSections = [TableViewCellType]()
    
    func setItems(sections: [TableViewCellType]) {
        currentSections = sections
        let updatedDataSource: [TableViewCellDataSource] = currentSections.map { row -> TableViewCellDataSource in
            let cellDataSource = TableViewCellDataSource()
            cellDataSource.identifier = row.reuseIdentifier
            cellDataSource.setupCell = row.cellSetupBlock
            cellDataSource.didSelectCell = row.cellSelectBlock
            cellDataSource.rowHeight = row.height
            return cellDataSource
        }

        self.dataSource = updatedDataSource
        self.reloadData?()
    }
}
