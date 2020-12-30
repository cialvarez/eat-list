//
//  LocationService.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import Foundation
import CoreLocation

protocol LocationProvider: AnyObject {
    var lastReceivedLocation: CLLocationCoordinate2D? { get }
    func fetchUserLocation(completion: @escaping (Result<CLLocationCoordinate2D, EatListError>) -> Void)
}

class LocationService: NSObject, LocationProvider {
    
    private let locationManager = CLLocationManager()
    
    fileprivate var locationRequestCompletion: (Result<CLLocationCoordinate2D, EatListError>) -> Void = { _ in }
    private(set) var lastReceivedLocation: CLLocationCoordinate2D?
    
    func fetchUserLocation(completion: @escaping (Result<CLLocationCoordinate2D, EatListError>) -> Void) {
        locationManager.requestWhenInUseAuthorization()
        guard CLLocationManager.locationServicesEnabled() else {
            completion(.failure(.api(type: LocationServiceError.permissionDenied)))
            return
        }
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.startUpdatingLocation()
        locationRequestCompletion = completion
    }
}

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationRequestCompletion(.failure(.api(type: LocationServiceError.generalFailure)))
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        lastReceivedLocation = currentLocation
        locationRequestCompletion(.success(currentLocation))
        locationManager.stopUpdatingLocation()
    }
}
