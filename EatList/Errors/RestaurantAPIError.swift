//
//  RestaurantAPIError.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

enum RestaurantAPIError: Error {
    case generalFailure
}

extension RestaurantAPIError: PresentableError {
    var errorTitle: String {
        switch self {
        case .generalFailure: return R.string.localizable.errorRestaurantAPIGeneralFailureTitle()
        }
    }
    
    var errorMessage: String {
        switch self {
        case .generalFailure: return R.string.localizable.errorRestaurantAPIGeneralFailureMessage()
        }
    }
}
