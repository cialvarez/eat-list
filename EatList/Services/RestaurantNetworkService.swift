//
//  RestaurantNetworkService.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Moya
import Unrealm
class RestaurantNetworkService {
    let provider: MoyaProvider<RestaurantAPI>
    
    init(provider: MoyaProvider<RestaurantAPI> = .init()) {
        self.provider = provider
    }
    
    func fetchTrendingRestaurants(
        parameters: TrendingSearchRequestParams,
        completion: @escaping (Result<[Restaurant], EatListError>) -> Void) {
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
                    completion(.failure(.api(type: RestaurantAPIError.generalFailure)))
                    return
                }
                
                guard let searchResponse = try? moyaResponse.map(SearchResponse.self) else {
                    completion(.failure(.jsonParsing))
                    return
                }
                
                try? realm.write {
                    realm.add(searchResponse.restaurants, update: true)
                }
                // Get on-disk location of the default Realm
                print("Realm is located at: \(realm.configuration.fileURL)")
                completion(.success(searchResponse.restaurants))
            }, onFailure: { error in
                switch error {
                case .networkConnectivity:
                    // try to load cached data
                    let cachedResult = realm.objects(Restaurant.self).compactMap { $0 }
                    guard !cachedResult.isEmpty else {
                        completion(.failure(.networkConnectivity))
                        return
                    }
                    completion(.success(cachedResult))
                default: completion(.failure(.networkConnectivity))
                }
            })
    }
}
