//
//  TargetDetailsViewModel.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import CoreLocation

protocol TargetDetailsProvider {
    var lastUpdatedList: [TargetDetailsSectionType] { get }
    var navBarTitle: String { get }
    var backgroundHeroId: String { get }
    var wantsToUpdateState: (TargetDetailsViewModel.State) -> Void { get set }
    func processDetails()
}

class TargetDetailsViewModel: TargetDetailsProvider {
    
    enum State {
        case loading
        case error(EatListError)
        case finished([TargetDetailsSectionType])
    }
    
    private let restaurantDetails: RestaurantDetails

    private(set) var lastUpdatedList = [TargetDetailsSectionType]()
    var wantsToUpdateState: (TargetDetailsViewModel.State) -> Void = { _ in }
    private(set) var navBarTitle = ""
    private(set) var backgroundHeroId: String = ""
    
    init(restaurantDetails: RestaurantDetails) {
        self.restaurantDetails = restaurantDetails
    }
    
    func processDetails() {
        let imageHeader = ImageHeaderTableViewCell.Parameters(imageUrl: URL(string: restaurantDetails.featuredImage),
                                                              heroId: "HeroImage\(restaurantDetails.id)")
        let baseDetails = getBaseDetails(from: restaurantDetails)
        let addressDetails = getAddressDetails(from: restaurantDetails)
        let highlights = HighlightsTableViewCell.Parameters(highlightsList: restaurantDetails.highlights)
        
        lastUpdatedList = [
            .imageHeader(parameters: imageHeader),
            .baseDetails(parameters: baseDetails),
            .addressDetails(parameters: addressDetails),
            .highlights(parameters: highlights)
        ]
        navBarTitle = restaurantDetails.name
        backgroundHeroId = "HeroBackground\(restaurantDetails.id)"
        wantsToUpdateState(.finished(lastUpdatedList))
    }
    
    private func getBaseDetails(from restaurantDetails: RestaurantDetails) -> BaseDetailsTableViewCell.Parameters {
        let cuisineText = (restaurantDetails.establishment.first ?? "").isEmpty ? "" : "\(restaurantDetails.establishment.first ?? "") - "
        let hasAlcohol = restaurantDetails.highlights.contains("Serves Alcohol")
        let timings = restaurantDetails.timings.replacingOccurrences(of: "), ", with: ")\n")
        
        return BaseDetailsTableViewCell.Parameters(
            rating: restaurantDetails.userRating.aggregateRating,
            reviewCount: "\(restaurantDetails.userRating.votes) Review(s)",
            restaurantName: restaurantDetails.name,
            cuisine: "\(cuisineText)\(restaurantDetails.cuisines)",
            location: "\(restaurantDetails.location.localityVerbose)",
            operatingHours: "\(timings)",
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
