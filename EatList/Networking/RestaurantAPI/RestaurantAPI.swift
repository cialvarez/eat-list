//
//  RestaurantAPI.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya

enum RestaurantAPI {
    case search(parameters: TrendingSearchRequestParams)
}

extension RestaurantAPI: TargetType {
    var baseURL: URL {
        return APIConstants.baseUrl
    }
    
    var path: String {
        switch self {
        case .search:
            return "search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case let .search(parameters):
            return .requestParameters(parameters: parameters.asDictionary, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["user-key": APIConstants.key]
    }
}
