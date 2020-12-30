//
//  EatListTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit
import Kingfisher

struct EatListItem {
    let imageHeroId: String
    let imageUrl: URL?
    let name: String
    let cuisine: String
    let location: String
    let rating: String
    let averageCostForTwo: Int
    let currency: String
}

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
    
    func configure(with data: EatListItem) {
        if let imageUrl = data.imageUrl {
            featuredImageView.kf.indicatorType = .activity
            featuredImageView.kf.setImage(with: imageUrl, placeholder: nil, options: [.transition(.fade(1.0))], progressBlock: nil)
            featuredImageView.hero.id = data.imageHeroId

        }
        restaurantNameLabel.text = data.name
        cuisineLabel.text = data.cuisine
        locationLabel.text = data.location
        ratingLabel.text = "\(data.rating) /5"
        priceDetailsLabel.text = "\(data.currency)\(data.averageCostForTwo) for two"
    }
}
