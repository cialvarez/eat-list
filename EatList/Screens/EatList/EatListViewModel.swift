//
//  EatListViewModel.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya
import MapKit
import CoreLocation

protocol EatListProvider {
    var lastUpdatedList: [EatListSectionType] { get }
    var wantsToViewRestaurant: (RestaurantDetails) -> Void { get set }
    var wantsToUpdateState: (EatListViewModel.State) -> Void { get set }
    func fetchList()
}

class EatListViewModel: NSObject, EatListProvider {
    
    enum State {
        case loading
        case error(EatListError)
        case finished([EatListSectionType])
    }
    
    var lastUpdatedList = [EatListSectionType]()
    var wantsToViewRestaurant: (RestaurantDetails) -> Void = { _ in }
    var wantsToUpdateState: (EatListViewModel.State) -> Void = { _ in }
    
    private let networkService: RestaurantNetworkProvider
    private let locationService: LocationProvider
    
    init(networkService: RestaurantNetworkProvider = RestaurantNetworkService(provider: .init()),
         locationService: LocationProvider = LocationService()) {
        self.networkService = networkService
        self.locationService = locationService
    }
    
    func fetchList() {
        self.wantsToUpdateState(.loading)
        self.locationService.fetchUserLocation { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let location):
                self.fetchTrendingRestaurants(in: location)
            case .failure(let error):
                self.wantsToUpdateState(.error(error))
            }
        }
    }
    
    private func fetchTrendingRestaurants(in location: CLLocationCoordinate2D) {
        networkService
            .fetchTrendingRestaurants(
                parameters: .init(lat: location.latitude,
                                  lon: location.longitude)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.wantsToUpdateState(.finished(response.asEatListSection(wantsToViewRestaurant: self.wantsToViewRestaurant)))
                case .failure(let error):
                    self.wantsToUpdateState(.error(error))
                }
            }
    }
}

private extension Array where Element == Restaurant {
    func asEatListSection(wantsToViewRestaurant: @escaping (RestaurantDetails) -> Void) -> [EatListSectionType] {
        return self.map { restaurant in
            let parameters = EatListTableViewCell.Parameters(
                imageHeroId: "HeroImage\(restaurant.restaurant.id)",
                imageUrl: URL(string: restaurant.restaurant.thumb),
                name: restaurant.restaurant.name,
                cuisine: restaurant.restaurant.cuisines,
                location: restaurant.restaurant.location.localityVerbose,
                rating: restaurant.restaurant.userRating.aggregateRating,
                averageCostForTwo: restaurant.restaurant.averageCostForTwo,
                currency: restaurant.restaurant.currency
            )
            return .restaurantDetails(parameters: parameters,
                                      restaurantDetails: restaurant.restaurant,
                                      wantsToViewRestaurant: wantsToViewRestaurant)
        }
    }
}
