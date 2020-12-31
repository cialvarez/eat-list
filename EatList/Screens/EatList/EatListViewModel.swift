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
    func nextPage()
}

class EatListViewModel: NSObject, EatListProvider {
    
    enum State {
        case loading
        case error(EatListError)
        case finished([EatListSectionType], source: RestaurantNetworkService.DataSource)
    }
    
    var lastUpdatedList = [EatListSectionType]()
    var wantsToViewRestaurant: (RestaurantDetails) -> Void = { _ in }
    var wantsToUpdateState: (EatListViewModel.State) -> Void = { _ in }
    
    private let networkService: RestaurantNetworkProvider
    private let locationService: LocationProvider
    private var canLoadMore: Bool = true
    
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
            case .success:
                self.fetchTrendingRestaurants(startingAt: 0)
            case .failure(let error):
                self.wantsToUpdateState(.error(error))
            }
        }
    }
    
    func nextPage() {
        fetchTrendingRestaurants(startingAt: max(lastUpdatedList.count - 1, 0))
    }
    
    private func fetchTrendingRestaurants(startingAt index: Int) {
        guard canLoadMore else {
            return
        }
        guard let currentLocation = locationService.lastReceivedLocation else {
            return
        }
        networkService
            .fetchTrendingRestaurants(
                parameters: .init(lat: currentLocation.latitude,
                                  lon: currentLocation.longitude,
                                  start: index)) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case let .finished(response, source):
                    self.canLoadMore = response.resultsShown < response.resultsFound && response.resultsShown != 0
                    // We need to make this check due to an API bug wherein even if the results found are much much higher, the cap is actually much lower
                    // and when you reach that cap you get a blank list
                    guard response.resultsShown != 0 else {
                        return
                    }
                    if index == 0 { self.lastUpdatedList = [] }
                    self.lastUpdatedList.append(contentsOf: response.restaurants.asEatListSection(wantsToViewRestaurant: self.wantsToViewRestaurant))
                    self.wantsToUpdateState(.finished(self.lastUpdatedList,
                                                      source: source))
                case let .error(error):
                    self.wantsToUpdateState(.error(error))
                case .loading: break
                }
            }
    }
}

private extension Array where Element == Restaurant {
    func asEatListSection(wantsToViewRestaurant: @escaping (RestaurantDetails) -> Void) -> [EatListSectionType] {
        return self.map { restaurant in
            let restaurantDetails = restaurant.restaurant
            let parameters = EatListTableViewCell.Parameters(
                imageHeroId: "HeroImage\(restaurantDetails.id)",
                imageUrl: URL(string: restaurantDetails.thumb),
                name: restaurantDetails.name,
                cuisine: restaurantDetails.cuisines,
                location: restaurantDetails.location.localityVerbose,
                rating: "\(restaurantDetails.userRating.aggregateRating) /5",
                priceDetails: "\(restaurantDetails.currency)\(restaurantDetails.averageCostForTwo) for two",
                containerHeroId: "HeroBackground\(restaurantDetails.id)"
            )
            return .restaurantDetails(parameters: parameters,
                                      restaurantDetails: restaurant.restaurant,
                                      wantsToViewRestaurant: wantsToViewRestaurant)
        }
    }
}
