//
//  EatListTableViewCell.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit
import Kingfisher

class EatListTableViewCell: UITableViewCell, NibReusable {
    
    struct Parameters {
        let imageHeroId: String
        let imageUrl: URL?
        let name: String
        let cuisine: String
        let location: String
        let rating: String
        let priceDetails: String
        let containerHeroId: String
    }

    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var cuisineLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingIconImageView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceDetailsLabel: UILabel!
    @IBOutlet weak var containerView: CustomizableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        toggleLoadingState(isLoading: false)
    }
    
    func render(with parameters: EatListTableViewCell.Parameters) {
        featuredImageView.kf.indicatorType = .activity
        featuredImageView.kf.setImage(with: parameters.imageUrl,
                                      placeholder: R.image.placeholder(),
                                      options: [.transition(.fade(1.0))],
                                      progressBlock: nil)
        featuredImageView.hero.id = parameters.imageHeroId
        restaurantNameLabel.text = parameters.name
        cuisineLabel.text = parameters.cuisine
        locationLabel.text = parameters.location
        ratingLabel.text = parameters.rating
        priceDetailsLabel.text = parameters.priceDetails
        containerView.hero.id = parameters.containerHeroId
    }
    
    func toggleLoadingState(isLoading: Bool) {
        featuredImageView.toggleSkeleton(isShown: isLoading)
        restaurantNameLabel.toggleSkeleton(isShown: isLoading, cornerRadius: 5)
        cuisineLabel.toggleSkeleton(isShown: isLoading, cornerRadius: 5)
        locationLabel.toggleSkeleton(isShown: isLoading, cornerRadius: 5)
        ratingLabel.toggleSkeleton(isShown: isLoading, cornerRadius: 5)
        priceDetailsLabel.toggleSkeleton(isShown: isLoading, cornerRadius: 5)
        ratingIconImageView.image = isLoading ? nil : R.image.rating()
        isLoading ? containerView.animateTouchDown() : containerView.animateTouchUp()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        containerView.animateTouchDown()
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        containerView.animateTouchUp()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            super.touchesEnded(touches, with: event)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        containerView.animateTouchUp()
        super.touchesCancelled(touches, with: event)
    }
}
