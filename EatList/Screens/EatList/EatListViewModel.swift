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
    
    enum State {
        case loading
        case error
        case finished
    }
    
    var stateChanged: (State) -> Void = { _ in }
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
    
    func start() {
        setupLocation()
    }
    
    private func refreshData(location: CLLocationCoordinate2D) {
        networkService
            .fetchTrendingRestaurants(
                parameters: .init(lat: location.latitude,
                                  lon: location.longitude)) { result in
                switch result {
                case .success(let response): print("Success! \(response)")
                case .failure(let error): print("Failed with error: \(error)")
                }
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
