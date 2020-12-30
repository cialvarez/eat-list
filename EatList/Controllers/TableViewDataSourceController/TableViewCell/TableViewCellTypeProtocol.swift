//
//  TableViewCellTypeProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

protocol TableViewCellTypeProtocol {
    associatedtype TableViewCellModelType
    var reuseIdentifier: String { get }
    var height: CGFloat { get }
    var cellSetupBlock: ViewSetupBlock? { get }
}
