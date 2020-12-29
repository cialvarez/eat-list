//
//  TableViewDataSourceAndDelegateProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class TableViewCellDataSource<T>: NSObject, TableViewCellProtocol {
    var identifier: String = ""
    var data: T?
    var setupCell: ViewSetupBlock<T>?
    var didSelectCell: RowSelectedBlock<T>?
    var rowHeight: CGFloat = UITableView.automaticDimension
    var allowsDynamicHeightAdjustment: Bool = false
    var needsReload: Bool = true
}
