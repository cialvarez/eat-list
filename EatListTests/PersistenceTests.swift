//
//  PersistenceTests.swift
//  EatListTests
//
//  Created by Christian Alvarez on 12/31/20.
//

import XCTest
import RealmSwift
@testable import EatList

class PersistenceTests: XCTestCase {

    override func setUp() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    override class func tearDown() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    /// Expectation: after successfully retrieving data, when the user goes offline, the offline cache should be used.
    func testOfflineCache() throws {
        let stubbedData = loadStub(name: "getTrending-SanFrancisco", fileExtension: "json")
        let networkService = RestaurantNetworkService(requestManager: MockNetworkRequestProvider(mockData: stubbedData))
        let offlineNetworkService = RestaurantNetworkService(requestManager: MockNetworkRequestProvider(mockData: nil))
        networkService.fetchTrendingRestaurants(parameters: .init(lat: 0, lon: 0, start: 0)) { state in
            switch state {
            case let .finished(onlineResponse, onlineSource):
                XCTAssert(!onlineResponse.restaurants.isEmpty)
                XCTAssertEqual(onlineSource, .network)
                
                offlineNetworkService.fetchTrendingRestaurants(parameters: .init(lat: 0, lon: 0, start: 0)) { state in
                    switch state {
                    case let .finished(offlineResponse, offlineSource):
                        XCTAssertEqual(onlineResponse.restaurants, offlineResponse.restaurants)
                        XCTAssertEqual(offlineSource, .cache)
                    case .loading: break
                    default: XCTFail("Expected to get offline results!")
                    }
                }
                
            default: break
            }
        }
    }
}
