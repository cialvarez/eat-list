//
//  RestaurantNetworkService.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya
class RestaurantNetworkService {
    let provider: MoyaProvider<RestaurantAPI>
    
    init(provider: MoyaProvider<RestaurantAPI> = .init()) {
        self.provider = provider
    }
    
    func fetchTrendingRestaurants(
        parameters: TrendingSearchRequestParams,
        completion: @escaping (Result<SearchResponse, EatListError>) -> Void) {
        let target = RestaurantAPI.search(parameters: parameters)
        NetworkRequestManager.fetchData(
            target: target,
            provider: provider,
            onSuccess: { response in
                guard let moyaResponse = try? response.filterSuccessfulStatusCodes() else {
                    completion(.failure(.api(type: RestaurantAPIError.generalFailure)))
                    return
                }
                
                guard let searchResponse = try? moyaResponse.map(SearchResponse.self) else {
                    completion(.failure(.jsonParsing))
                    return
                }
                
                completion(.success(searchResponse))
            }, onFailure: { _ in
                completion(.failure(.networkConnectivity))
            })
    }
}
