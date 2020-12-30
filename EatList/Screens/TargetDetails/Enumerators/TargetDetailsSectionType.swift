//
//  TargetDetailsSectionType.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import UIKit

enum TargetDetailsSectionType {
    case imageHeader
    case baseDetails
    case addressDetails
    case highlights
}

extension TargetDetailsSectionType: TableViewCellTypeProtocol {
    
    typealias TableViewCellModelType = RestaurantDetails
    
    var reuseIdentifier: String {
        switch self {
        case .imageHeader: return R.nib.imageHeaderTableViewCell.name
        case .baseDetails: return R.nib.baseDetailsTableViewCell.name
        case .addressDetails: return R.nib.addressDetailsTableViewCell.name
        case .highlights: return R.nib.highlightsTableViewCell.name
        }
    }
    
    var height: CGFloat {
        switch self {
        case .imageHeader:
            return 250
        case .baseDetails,
             .addressDetails,
             .highlights:
            return UITableView.automaticDimension
        }
    }
    
    var cellSetupBlock: ViewSetupBlock<RestaurantDetails>? {
        switch self {
        case .imageHeader:
            return { cell, model in
                if let cell = cell as? ImageHeaderTableViewCell,
                   let model = model,
                   let imageUrl = URL(string: model.featuredImage) {
                    cell.headerImageView.kf.indicatorType = .activity
                    cell.headerImageView.kf.setImage(with: imageUrl, placeholder: nil, options: [.transition(.fade(1.0))], progressBlock: nil)
                }
            }
        case .baseDetails:
            return { cell, model in
                if let cell = cell as? BaseDetailsTableViewCell,
                   let model = model {
                    cell.ratingLabel.text = model.userRating.aggregateRating
                    cell.reviewCountLabel.text = "\(model.userRating.votes) Review(s)" // TODO: Pluralize
                    cell.restaurantNameLabel.text = model.name
                    let cuisineText = (model.establishment.first ?? "").isEmpty ? "" : "\(model.establishment.first ?? "") - "
                    cell.cuisineLabel.text = "\(cuisineText)\(model.cuisines)"
                    cell.locationLabel.text = "\(model.location.localityVerbose)"
                    cell.operatingHoursLabel.text = "\(model.timings)"
                    let hasAlcohol = model.highlights.contains("Serves Alcohol")
                    cell.costForTwoLabel.text = "Cost for two - \(model.currency)\(model.averageCostForTwo) approx." + (hasAlcohol ? "" : "without alcohol")
                }
            }
        case .addressDetails:
            return { cell, model in
                if let cell = cell as? AddressDetailsTableViewCell,
                   let model = model {
                    cell.addressLabel.text = model.location.localityVerbose
                }
            }
        case .highlights:
            return { cell, model in
                if let cell = cell as? HighlightsTableViewCell,
                   let model = model {
                    cell.simpleCarouselView.updateDataSource(with: model.highlights)
                }
            }
        }
    }
}
