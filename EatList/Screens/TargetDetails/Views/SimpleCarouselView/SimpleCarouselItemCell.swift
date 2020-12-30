//
//  SimpleCarouselItemCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class SimpleCarouselItemCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var customizableView: CustomizableView!

    func setup(name: String) {
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        nameLabel.text = name
        customizableView.cornerRadius = SimpleCarouselItemCell.calcSize(forName: name).height / 2
    }
    
    static func calcSize(forName: String) -> CGSize {
        var size = NSString(string: forName)
            .size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        
        size.width += 16.0
        size.height += 10.0
        
        return size
    }
}
