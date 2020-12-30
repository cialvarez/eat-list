//
//  TableViewCellProtocol.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

typealias ViewSetupBlock = ((_ view: UIView?) -> Void)
typealias RowSelectedBlock = ((_ view: UIView?,_ indexPath: IndexPath) -> Void)

protocol TableViewCellProtocol {
    var identifier: String { get }
    var setupCell: ViewSetupBlock? { get set }
    var didSelectCell: RowSelectedBlock? { get set }
    var rowHeight: CGFloat { get }
}
