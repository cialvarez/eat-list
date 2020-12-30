//
//  UITableView+NibReusable.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

protocol NibReusable: class {
    static var reuseIdentifier: String { get }
}

extension NibReusable {
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
}

extension UITableView {
    
    func register<Cell: NibReusable>(_ cellClass: Cell.Type) where Cell: UITableViewCell {
        register(UINib(nibName: cellClass.reuseIdentifier, bundle: nil), forCellReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: NibReusable>(of cellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: cellClass.reuseIdentifier, for: indexPath) as? Cell else {
            assertionFailure("\(Cell.self) is not registered. Please check cell registration.")
            register(cellClass.self)
            return cellClass.init(style: .default, reuseIdentifier: cellClass.reuseIdentifier)
        }
        return cell
    }
    
}
