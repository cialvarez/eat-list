//
//  TargetDetailsVMTests.swift
//  EatListTests
//
//  Created by Christian Alvarez on 12/30/20.
//

import XCTest
@testable import EatList
import Unrealm

class TargetDetailsVMTests: XCTestCase {
    
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
    
    func testSectionCreation() throws {
        getStubbedRestaurant(at: 0) { details in
            let viewModel = TargetDetailsViewModel(restaurantDetails: details)
            viewModel.wantsToUpdateState = { state in
                switch state {
                case .finished(let sections):
                    XCTAssertEqual(sections[0], .imageHeader(parameters: .init(imageUrl: URL(string: "https://b.zmtcdn.com/data/reviews_photos/4f4/f2ab38e7def8a090053963ed47dd64f4_1541520823.jpg"), heroId: "HeroImage16851686")))
                    XCTAssertEqual(sections[1], .baseDetails(parameters: .init(rating: "4.7",
                                                                               reviewCount: "722 Review(s)",
                                                                               restaurantName: "Tartine Bakery",
                                                                               cuisine: "Bakery - Bakery, Cafe",
                                                                               location: "Mission District, San Francisco",
                                                                               operatingHours: "8 AM to 7 PM (Mon)\n7:30 AM to 7 PM (Tue-Wed)\n7:30 AM to 8 PM (Thu-Fri)\n8 AM to 8 PM (Sat-Sun)",
                                                                               costForTwo: "Cost for two - $25 approx.")))
                    XCTAssertEqual(sections[2], .addressDetails(parameters: .init(fullAddress: "Mission District, San Francisco",
                                                                                  location: .init(latitude: 37.7614861111,
                                                                                                  longitude: -122.42395))))
                    XCTAssertEqual(sections[3], .highlights(parameters: .init(highlightsList: ["Cash", "Breakfast", "Debit Card", "Serves Alcohol", "Takeaway Available", "Credit Card", "Lunch", "Vegetarian Friendly", "Wine", "Indoor Seating", "Brunch", "Beer", "Kid Friendly"])))
                default: break
                }
            }
            viewModel.processDetails()
        }
    }

    private func getStubbedRestaurant(at index: Int, completion: @escaping (RestaurantDetails) -> Void) {
        let stubbedData = loadStub(name: "getTrending-SanFrancisco", fileExtension: "json")
        let networkService = RestaurantNetworkService(requestManager: MockNetworkRequestProvider(mockData: stubbedData))
        networkService.fetchTrendingRestaurants(parameters: .init(lat: 0, lon: 0, start: 0)) { state in
            switch state {
            case let .finished(response, _):
                completion(response.restaurants[index].restaurant)
            default: break
            }
        }
    }
}
