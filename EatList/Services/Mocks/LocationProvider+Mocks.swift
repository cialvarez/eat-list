//
//  LocationProvider+Mocks.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import Foundation
import CoreLocation

class MockLocationProvider: LocationProvider {
    var lastReceivedLocation: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var hasLocationAccess: Bool = true
    func fetchUserLocation(completion: @escaping (Result<CLLocationCoordinate2D, EatListError>) -> Void) {
        if hasLocationAccess {
            completion(.success(CLLocationCoordinate2D(latitude: 0, longitude: 0)))
        } else {
            completion(.failure(.api(type: LocationServiceError.permissionDenied)))
        }
    }
}
