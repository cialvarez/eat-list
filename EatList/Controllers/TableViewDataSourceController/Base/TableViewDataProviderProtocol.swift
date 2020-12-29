//
//  TableViewDataProviderProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

protocol TableViewDataProviderProtocol {
    associatedtype TableViewCellModelType
    var dataSource: [TableViewCellDataSource<TableViewCellModelType>] { get set }
}
