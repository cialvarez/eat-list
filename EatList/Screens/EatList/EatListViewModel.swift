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

class EatListViewModel: NSObject {
    
    struct Output {
        var list: [EatListTableViewCell.Parameters]
        var restaurants: [Restaurant]
        var stateChanged: (State) -> Void
    }
    
    enum State {
        case loading
        case error(EatListError)
        case finished
    }
    
    var output: Output!
    private let networkService: RestaurantNetworkService
    private let locationManager = CLLocationManager()
    private var location: CLLocationCoordinate2D? {
        didSet {
            if let location = location,
               location.latitude != oldValue?.latitude,
               location.longitude != oldValue?.longitude {
                refreshData(location: location)
            }
        }
    }

    init(provider: MoyaProvider<RestaurantAPI> = .init()) {
        self.networkService = RestaurantNetworkService(provider: provider)
    }
    
    func start(output: Output) {
        setupLocation()
        self.output = output
    }
    
    private func refreshData(location: CLLocationCoordinate2D) {
        output.stateChanged(.loading)
        networkService
            .fetchTrendingRestaurants(
                parameters: .init(lat: location.latitude,
                                  lon: location.longitude)) { [weak self] result in
                self?.locationManager.stopUpdatingLocation()
                self?.location = nil
                guard let self = self else { return }
                switch result {
                case .success(let response):
                    self.output.restaurants = response
                    self.output.list = self.mapToCellListItems(restaurantList: response)
                    self.output.stateChanged(.finished)
                case .failure(let error):
                    self.output.stateChanged(.error(error))
                }
            }
    }
    
    private func mapToCellListItems(restaurantList: [Restaurant]) -> [EatListTableViewCell.Parameters] {
        return restaurantList.map { restaurant in
            return EatListTableViewCell.Parameters(
                imageHeroId: "HeroImage\(restaurant.restaurant.id)",
                imageUrl: URL(string: restaurant.restaurant.thumb),
                name: restaurant.restaurant.name,
                cuisine: restaurant.restaurant.cuisines,
                location: restaurant.restaurant.location.localityVerbose,
                rating: restaurant.restaurant.userRating.aggregateRating,
                averageCostForTwo: restaurant.restaurant.averageCostForTwo,
                currency: restaurant.restaurant.currency)
        }
    }
    
    private func setupLocation() {
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension EatListViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
         print("error: \(error.localizedDescription)")
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = currentLocation
    }
}
