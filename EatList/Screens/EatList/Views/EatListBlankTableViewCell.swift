//
//  EatListBlankTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import UIKit

class EatListBlankTableViewCell: UITableViewCell, NibReusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
