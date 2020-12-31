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
        case finished(response: SearchResponse, source: DataSource)
    }
    
    private let provider: MoyaProvider<RestaurantAPI>
    private let requestManager: NetworkRequestProvider
    
    init(provider: MoyaProvider<RestaurantAPI> = .init(),
         requestManager: NetworkRequestProvider = NetworkRequestManager()) {
        self.provider = provider
        self.requestManager = requestManager
    }
    
    func fetchTrendingRestaurants(
        parameters: TrendingSearchRequestParams,
        completion: @escaping (State) -> Void) {
        guard let realm = try? Realm() else {
            assertionFailure("Expected a non-nil realm instance!")
            return
        }
        let target = RestaurantAPI.search(parameters: parameters)
        
        requestManager.fetchData(
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
                completion(.finished(response: searchResponse, source: .network))
            }, onFailure: { error in
                switch error {
                case .networkConnectivity:
                    // Realm objects are naturally unsorted, so we have to sort them based on the dates in which they were created
                    let cachedResult = realm.objects(Restaurant.self)
                        .compactMap { $0 }
                        .sorted { $0.dateCreated < $1.dateCreated }
                    guard !cachedResult.isEmpty else {
                        DebugLoggingService.log(status: .warning, message: "No network detected, and no cached data is available.")
                        completion(.error(.networkConnectivity))
                        return
                    }
                    DebugLoggingService.log(status: .warning, message: "No network detected. Using cached data for now.")
                    let response = SearchResponse(resultsFound: cachedResult.count, resultsShown: cachedResult.count, restaurants: cachedResult)
                    completion(.finished(response: response, source: .cache))
                default:
                    DebugLoggingService.log(status: .warning)
                    completion(.error(.networkConnectivity))
                }
            })
    }
}
