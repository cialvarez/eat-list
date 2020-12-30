//
//  TableViewDataSourceAndDelegateProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class TableViewCellDataSource: TableViewCellProtocol {
    var identifier: String = ""
    var setupCell: ViewSetupBlock?
    var didSelectCell: RowSelectedBlock?
    var rowHeight: CGFloat = UITableView.automaticDimension
}
