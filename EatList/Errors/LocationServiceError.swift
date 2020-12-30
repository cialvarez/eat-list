//
//  LocationServiceError.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import Foundation

enum LocationServiceError: Error {
    case generalFailure
    case permissionDenied
}

extension LocationServiceError: PresentableError {
    var errorTitle: String {
        switch self {
        case .generalFailure: return "We can't seem to find you!"
        case .permissionDenied: return "We couldn't get your location!"
        }
    }
    
    var errorMessage: String {
        switch self {
        case .generalFailure: return "Please try again in a bit."
        case .permissionDenied: return "Please allow Eat List to access your location for the app to work correctly!"
        }
    }
}
