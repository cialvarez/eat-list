//
//  EatListTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class EatListTableViewCell: UITableViewCell {

    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceDetailsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
}
