//
//  TableViewDataProviderProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

protocol TableViewDataProviderProtocol {
    var dataSource: [TableViewCellDataSource] { get set }
}