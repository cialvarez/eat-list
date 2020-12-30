//
//  UICollectionView+NibReusable.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import UIKit

extension UICollectionView {
    func register<Cell: NibReusable>(_ cellClass: Cell.Type) where Cell: UICollectionViewCell {
        register(UINib(nibName: cellClass.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: cellClass.reuseIdentifier)
    }
    
    func dequeueReusableCell<Cell: NibReusable>(of cellClass: Cell.Type, for indexPath: IndexPath) -> Cell where Cell: UICollectionViewCell {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellClass.reuseIdentifier, for: indexPath) as? Cell else {
            assertionFailure("\(Cell.self) is not registered. Please check cell registration.")
            register(cellClass.self)
            return cellClass.init()
        }
        return cell
    }
}
