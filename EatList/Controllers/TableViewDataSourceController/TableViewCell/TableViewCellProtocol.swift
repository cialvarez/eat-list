//
//  TableViewCellProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

typealias ViewSetupBlock<T> = ((_ view: UIView?, _ data: T?) -> Void)
typealias RowSelectedBlock<T> = ((_ view: UIView?, _ data: T?) -> Void)

protocol TableViewCellProtocol {
    associatedtype TableViewCellModelType
    
    var identifier: String { get }
    var data: TableViewCellModelType? { get set }
    var setupCell: ViewSetupBlock<TableViewCellModelType>? { get set }
    var didSelectCell: RowSelectedBlock<TableViewCellModelType>? { get set }
    var rowHeight: CGFloat { get }
    var allowsDynamicHeightAdjustment: Bool { get }
}

