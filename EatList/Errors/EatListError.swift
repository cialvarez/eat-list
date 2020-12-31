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
            return R.string.localizable.errorCommonTitle()
        case .networkConnectivity:
            return R.string.localizable.errorConnectivityTitle()
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
            return R.string.localizable.errorCommonMessage()
        case let .custom(_, message):
            return message
        case .networkConnectivity:
            return R.string.localizable.errorConnectivityMessage()
        }
    }
    
    var primaryButtonTitle: String {
        switch self {
        case .api(let type):
            return type.primaryButtonTitle
        case .unknown,
             .jsonParsing,
             .custom,
             .networkConnectivity:
            return ""
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
            return R.string.localizable.buttonTitleClose()
        }
    }
}
