//
//  RestaurantNetworkService.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya
import Unrealm

protocol RestaurantNetworkProvider {
    func fetchTrendingRestaurants(
        parameters: TrendingSearchRequestParams,
        completion: @escaping (RestaurantNetworkService.State) -> Void)
}

class RestaurantNetworkService: RestaurantNetworkProvider {
    
    enum DataSource {
        case network
        case cache
    }
    
    enum State {
        case loading
        case error(EatListError)
        case finished(restaurant: [Restaurant], source: DataSource)
    }
    
    private let provider: MoyaProvider<RestaurantAPI>
    
    init(provider: MoyaProvider<RestaurantAPI> = .init()) {
        self.provider = provider
    }
    
    func fetchTrendingRestaurants(
        parameters: TrendingSearchRequestParams,
        completion: @escaping (State) -> Void) {
        guard let realm = try? Realm() else {
            assertionFailure("Expected a non-nil realm instance!")
            return
        }
        let target = RestaurantAPI.search(parameters: parameters)
        
        NetworkRequestManager.fetchData(
            target: target,
            provider: provider,
            onSuccess: { response in
                guard let moyaResponse = try? response.filterSuccessfulStatusCodes() else {
                    completion(.error(.api(type: RestaurantAPIError.generalFailure)))
                    return
                }
                
                guard let searchResponse = try? moyaResponse.map(SearchResponse.self) else {
                    completion(.error(.jsonParsing))
                    return
                }
                
                try? realm.write {
                    realm.add(searchResponse.restaurants, update: true)
                }
                // Get on-disk location of the default Realm
                DebugLoggingService.log(status: .success, message: "Realm file is located here: \(realm.configuration.fileURL?.debugDescription ?? "n/a")")
                completion(.finished(restaurant: searchResponse.restaurants, source: .network))
            }, onFailure: { error in
                switch error {
                case .networkConnectivity:
                    let cachedResult = realm.objects(Restaurant.self).compactMap { $0 }
                    guard !cachedResult.isEmpty else {
                        DebugLoggingService.log(status: .warning, message: "No network detected, and no cached data is available.")
                        completion(.error(.networkConnectivity))
                        return
                    }
                    DebugLoggingService.log(status: .warning, message: "No network detected. Using cached data for now.")
                    completion(.finished(restaurant: cachedResult, source: .cache))
                default:
                    DebugLoggingService.log(status: .warning)
                    completion(.error(.networkConnectivity))
                }
            })
    }
}
