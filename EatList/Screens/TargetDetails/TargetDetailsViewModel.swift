//
//  TargetDetailsViewModel.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import CoreLocation
class TargetDetailsViewModel {
    
    struct Input {
        let restaurantDetails: RestaurantDetails
    }
    
    struct Output {
        let tableViewCellItems: [TargetDetailsSectionType]
    }
    
    func transform(input: Input) -> Output {
        let restaurantDetails = input.restaurantDetails
        let imageHeader = ImageHeaderTableViewCell.Parameters(imageUrl: URL(string: restaurantDetails.featuredImage),
                                                              heroId: "HeroImage\(restaurantDetails.id)")
        let baseDetails = getBaseDetails(from: restaurantDetails)
        let addressDetails = getAddressDetails(from: restaurantDetails)
        let highlights = HighlightsTableViewCell.Parameters(highlightsList: restaurantDetails.highlights)
        
        return .init(tableViewCellItems: [
            .imageHeader(parameters: imageHeader),
            .baseDetails(parameters: baseDetails),
            .addressDetails(parameters: addressDetails),
            .highlights(parameters: highlights)
        ])
    }
    
    private func getBaseDetails(from restaurantDetails: RestaurantDetails) -> BaseDetailsTableViewCell.Parameters {
        let cuisineText = (restaurantDetails.establishment.first ?? "").isEmpty ? "" : "\(restaurantDetails.establishment.first ?? "") - "
        let hasAlcohol = restaurantDetails.highlights.contains("Serves Alcohol")

        return BaseDetailsTableViewCell.Parameters(
            rating: restaurantDetails.userRating.aggregateRating,
            reviewCount: "\(restaurantDetails.userRating.votes) Review(s)",
            restaurantName: restaurantDetails.name,
            cuisine: "\(cuisineText)\(restaurantDetails.cuisines)",
            location: "\(restaurantDetails.location.localityVerbose)",
            operatingHours: "\(restaurantDetails.timings)",
            costForTwo: "Cost for two - \(restaurantDetails.currency)\(restaurantDetails.averageCostForTwo) approx." + (hasAlcohol ? "" : "without alcohol"))
    }
    
    private func getAddressDetails(from restaurantDetails: RestaurantDetails) -> AddressDetailsTableViewCell.Parameters {
        let fullAddress = restaurantDetails.location.localityVerbose
        guard let latitude = Double(restaurantDetails.location.latitude),
              let longitude = Double(restaurantDetails.location.longitude) else {
            return .init(fullAddress: fullAddress, location: nil)
        }
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        return AddressDetailsTableViewCell.Parameters(fullAddress: fullAddress, location: location)
    }
}
