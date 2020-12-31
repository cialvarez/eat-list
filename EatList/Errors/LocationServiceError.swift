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
        case .generalFailure: return R.string.localizable.errorLocationGeneralFailureTitle()
        case .permissionDenied: return R.string.localizable.errorLocationPermissionDeniedTitle()
        }
    }
    
    var errorMessage: String {
        switch self {
        case .generalFailure: return R.string.localizable.errorLocationGeneralFailureMessage()
        case .permissionDenied: return R.string.localizable.errorLocationPermissionDeniedMessage()
        }
    }
    
    var primaryButtonTitle: String {
        switch self {
        case .generalFailure: return ""
        case .permissionDenied: return R.string.localizable.errorLocationPermissionDeniedPrimaryButtonTitle()
        }
    }
    
    var dismissButtonTitle: String {
        switch self {
        case .generalFailure,
             .permissionDenied: return R.string.localizable.buttonTitleClose()
        }
    }
}
