//
//  TargetDetailsViewModel.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

class TargetDetailsViewModel {
    
    struct Input {
        let restaurantDetails: RestaurantDetails
    }
    
    struct Output {
        let tableViewCellItems: [TargetDetailsSectionType]
    }
    
    func transform(input: Input) -> Output {
        let restaurantDetails = input.restaurantDetails
        let imageHeader = ImageHeaderTableViewCell.Parameters(imageUrl: URL(string: restaurantDetails.featuredImage))
        let baseDetails = getBaseDetails(from: restaurantDetails)
        let addressDetails = AddressDetailsTableViewCell.Parameters(fullAddress: restaurantDetails.location.localityVerbose)
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
}
