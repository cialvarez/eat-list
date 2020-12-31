//
//  NetworkRequestManager+Mocks.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import Foundation
import Moya

struct MockNetworkRequestProvider: NetworkRequestProvider {
    var mockData: Data?
    func fetchData<RestaurantAPI>(
        target: RestaurantAPI,
        provider: MoyaProvider<RestaurantAPI>,
        onSuccess: @escaping RequestSuccessBlock,
        onFailure: @escaping RequestFailedBlock) {
        guard let mockData = mockData else {
            onFailure(.networkConnectivity)
            return
        }
        onSuccess(.init(statusCode: 200, data: mockData))
    }
}
