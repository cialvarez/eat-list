//
//  TableViewCellTypeProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

typealias ViewSetupBlock = ((_ view: UIView?) -> Void)
typealias RowSelectedBlock = ((_ view: UIView?, _ indexPath: IndexPath) -> Void)

protocol TableViewCellTypeProtocol {
    var reuseIdentifier: String { get }
    var height: CGFloat { get }
    var estimatedHeight: CGFloat { get }
    var cellSetupBlock: ViewSetupBlock? { get }
    var cellSelectBlock: RowSelectedBlock? { get }
}
