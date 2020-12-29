//
//  EatListError.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

enum EatListError {
    case unknown
    case networkConnectivity
    case jsonParsing
    case custom(title: String, message: String)
    case api(type: PresentableError)
}

extension EatListError: PresentableError {
    var errorTitle: String {
        switch self {
        case .api(let type):
            return type.errorTitle
        case .unknown,
             .jsonParsing:
            return "Oops!"
        case .networkConnectivity:
            return "We lost you!"
        case let .custom(title, _):
            return title
        }
    }
    
    var errorMessage: String {
        switch self {
        case .api(let type):
            return type.errorMessage
        case .unknown,
             .jsonParsing:
            return "Something went wrong. Please try again in a bit. "
        case let .custom(_, message):
            return message
        case .networkConnectivity:
            return "You're currently offline! Please check your internet connection and try again."
        }
    }
    
    var primaryButtonTitle: String {
        switch self {
        case .api(let type):
            return type.primaryButtonTitle
        case .unknown,
             .jsonParsing,
             .custom:
            return ""
        case .networkConnectivity:
            return "Retry"
        }
    }
    
    var dismissButtonTitle: String {
        switch self {
        case .api(let type):
            return type.dismissButtonTitle
        case .unknown,
             .networkConnectivity,
             .jsonParsing,
             .custom:
            return "Close"
        }
    }
}
