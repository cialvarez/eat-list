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
    
    var dataSource = [TableViewCellDataSource<TableViewCellModelType>]()
    
    var model: TableViewCellModelType? {
        didSet {
            self.updateSectionModels(oldModel: oldValue, newModel: model)
        }
    }
    
    var reloadData: (() -> Void)?
    
    var reloadRows: ((_ at: [Int]) -> Void)?
        
    init(model: TableViewCellModelType? = nil) {
        self.model = model
    }
    
    var currentSections = [TableViewCellType]()
    
    func setItems(sections: [TableViewCellType]) {
        currentSections = sections
        let updatedDataSource: [TableViewCellDataSource] = currentSections.map { row -> TableViewCellDataSource<TableViewCellModelType> in
            let cellDataSource = TableViewCellDataSource<TableViewCellModelType>()
            cellDataSource.identifier = row.reuseIdentifier
            cellDataSource.data = model
            cellDataSource.setupCell = row.cellSetupBlock as? (UIView?, TableViewDataManager<T, U>.TableViewCellModelType?) -> Void
            cellDataSource.rowHeight = row.height
            cellDataSource.needsReload = true
            return cellDataSource
        }

        self.dataSource = updatedDataSource
        self.reloadData?()
    }
    
    func updateSectionModels(oldModel: TableViewCellModelType?, newModel: TableViewCellModelType?) {
        let updatedDataSource: [TableViewCellDataSource] = currentSections.map { row -> TableViewCellDataSource<TableViewCellModelType> in
            let cellDataSource = TableViewCellDataSource<TableViewCellModelType>()
            cellDataSource.identifier = row.reuseIdentifier
            cellDataSource.data = model
            cellDataSource.setupCell = row.cellSetupBlock as? (UIView?, TableViewDataManager<T, U>.TableViewCellModelType?) -> Void
            cellDataSource.rowHeight = row.height
            return cellDataSource
        }
        
        self.dataSource = updatedDataSource
        let indicesForReload = self.dataSource.indices.filter { self.dataSource[$0].needsReload }
        self.reloadRows?(indicesForReload)
    }
}
