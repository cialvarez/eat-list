//
//  EatListVMTests.swift
//  EatListTests
//
//  Created by Christian Alvarez on 12/31/20.
//

import XCTest
@testable import EatList
import Unrealm

class EatListVMTests: XCTestCase {
    
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

    func testCellInfo() throws {
        let stubbedData = loadStub(name: "getTrending-SanFrancisco", fileExtension: "json")
        let networkService = RestaurantNetworkService(requestManager: MockNetworkRequestProvider(mockData: stubbedData))
        let viewModel = EatListViewModel(networkService: networkService, locationService: MockLocationProvider())
        viewModel.wantsToUpdateState = { state in
            switch state {
            case let .finished(sections, _):
                // Restaurant count: 20
                // Loading indicator: 1
                XCTAssertEqual(sections.count, 21)
                switch sections[0] {
                case let .restaurantDetails(parameters, restaurantDetails, _):
                    XCTAssertEqual(parameters.imageHeroId, "HeroImage16851686")
                    XCTAssertEqual(parameters.imageUrl, URL(string: restaurantDetails.thumb))
                    XCTAssertEqual(parameters.name, "Tartine Bakery")
                    XCTAssertEqual(parameters.cuisine, "Bakery, Cafe")
                    XCTAssertEqual(parameters.location, "Mission District, San Francisco")
                    XCTAssertEqual(parameters.rating, "4.7 /5")
                    XCTAssertEqual(parameters.priceDetails, "$25 for two")
                    XCTAssertEqual(parameters.containerHeroId, "HeroBackground16851686")
                default: break
                }
                
            case .error(let error):
                XCTFail("Expected a successful state change! Error: \(error.errorMessage)")
            case .loading: break
            }
        }
        viewModel.fetchList()
    }
    
    func testLocationAccessDenied() throws {
        let mockLocationProvider = MockLocationProvider()
        mockLocationProvider.hasLocationAccess = false
        let stubbedData = loadStub(name: "getTrending-SanFrancisco", fileExtension: "json")
        let networkService = RestaurantNetworkService(requestManager: MockNetworkRequestProvider(mockData: stubbedData))
        let viewModel = EatListViewModel(networkService: networkService, locationService: mockLocationProvider)
        viewModel.wantsToUpdateState = { state in
            switch state {
            case let .finished(sections, _):
                XCTAssertEqual(sections.count, 0)
            case .error(let error):
                XCTAssertEqual(error.errorTitle, EatListError.api(type: LocationServiceError.permissionDenied).errorTitle)
                XCTAssertEqual(error.errorMessage, EatListError.api(type: LocationServiceError.permissionDenied).errorMessage)
            case .loading: break
            }
        }
        viewModel.fetchList()
    }
}
