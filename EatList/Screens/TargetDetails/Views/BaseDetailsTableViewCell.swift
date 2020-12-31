//
//  BaseDetailsTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class BaseDetailsTableViewCell: UITableViewCell, NibReusable {
    
    struct Parameters: Equatable {
        let rating: String
        let reviewCount: String
        let restaurantName: String
        let cuisine: String
        let location: String
        let operatingHours: String
        let costForTwo: String
    }
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: UILabel!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var operatingHoursLabel: UILabel!
    @IBOutlet weak var costForTwoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    func render(with parameters: Parameters) {
        ratingLabel.text = parameters.rating
        reviewCountLabel.text = parameters.reviewCount
        restaurantNameLabel.text = parameters.restaurantName
        cuisineLabel.text = parameters.cuisine
        locationLabel.text = parameters.location
        operatingHoursLabel.text = parameters.operatingHours
        costForTwoLabel.text = parameters.costForTwo
    }
}
