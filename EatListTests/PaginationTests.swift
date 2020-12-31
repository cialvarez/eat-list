//
//  PaginationTests.swift
//  EatListTests
//
//  Created by Christian Alvarez on 12/31/20.
//

import XCTest
@testable import EatList
import Unrealm

class PaginationTests: XCTestCase {

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

    func testPagination() throws {
        // Initial page
        let networkService = getPaginatedRestaurantService()
        let viewModel = EatListViewModel(networkService: networkService, locationService: MockLocationProvider())
        viewModel.wantsToUpdateState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case let .finished(sections, _):
                // Restaurant count iteration: 20
                // Loading indicator: 1
                
                if sections.count == 21 {
                    // In the first page, we get 20 + 1 sections, with the loader at the 20th index.
                    XCTAssertEqual(viewModel.lastUpdatedList.count, 20)
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[0])?.id, "16851686")
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[19])?.id, "16852987")
                    XCTAssertTrue(self.checkIfLoader(section: sections[20]))
                    viewModel.nextPage()
                } else if sections.count == 41 {
                    // In the second page, we get 40 + 1 sections, with the loader at the 40th index.
                    XCTAssertEqual(viewModel.lastUpdatedList.count, 40)
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[20])?.id, "16851232")
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[39])?.id, "16859729")
                    XCTAssertTrue(self.checkIfLoader(section: sections[40]))
                    viewModel.nextPage()
                } else {
                    // In the third page, we get a zero from the backend, which means that we no longer have anything to load.
                    // We remove the loader and keep the rest of the elements intact.
                    XCTAssertEqual(viewModel.lastUpdatedList.count, 40)
                    XCTAssertEqual(sections.count, 40)
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[20])?.id, "16851232")
                    XCTAssertEqual(self.getRestaurantDetails(from: sections[39])?.id, "16859729")
                }
            case .error(let error):
                XCTFail("Expected a successful state change! Error: \(error.errorMessage)")
            case .loading: break
            }
        }
        viewModel.fetchList()
    }
    
    private func getRestaurantDetails(from section: EatListSectionType) -> RestaurantDetails? {
        guard case let .restaurantDetails(_, restaurantDetails, _) = section else {
            return nil
        }
        return restaurantDetails
    }
    
    private func checkIfLoader(section: EatListSectionType) -> Bool {
        if case .skeletonLoader = section { return true }
        return false
    }
    
    private func nextPage() {
        
    }
    
    func getPaginatedRestaurantService() -> RestaurantNetworkProvider {
        let page1 = loadStub(name: "getTrending-Page1", fileExtension: "json")
        let page2 = loadStub(name: "getTrending-Page2", fileExtension: "json")
        let page3 = loadStub(name: "getTrending-Page3", fileExtension: "json")
        let decoder = JSONDecoder()
        guard let page1Response = try? decoder.decode(SearchResponse.self, from: page1),
              let page2Response = try? decoder.decode(SearchResponse.self, from: page2),
              let page3Response = try? decoder.decode(SearchResponse.self, from: page3) else {
            fatalError("Expected decodable responses!")
        }
        
        return MockRestaurantService(mockResponses: [page1Response, page2Response, page3Response])
    }
}

struct MockRestaurantService: RestaurantNetworkProvider {
    
    var mockResponses = [SearchResponse]()
    
    func fetchTrendingRestaurants(parameters: TrendingSearchRequestParams, completion: @escaping (RestaurantNetworkService.State) -> Void) {
        switch parameters.start {
        // Page 1 - Has more to load
        case 0: completion(.finished(response: mockResponses[0], source: .network))
        // Page 2 - Has more to load
        case 20: completion(.finished(response: mockResponses[1], source: .network))
        // Page 3 - Has no more to load
        case 40: completion(.finished(response: mockResponses[2], source: .network))
        default: break
        }
    }
}
