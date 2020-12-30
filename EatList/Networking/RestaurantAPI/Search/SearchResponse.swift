//
//  SearchResponse.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import Unrealm
// MARK: - SearchResponse
struct SearchResponse: Codable {
    
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case restaurants
    }
}

// MARK: - RestaurantElement
struct Restaurant: Codable, Realmable {
    
    var restaurant = RestaurantDetails()
    var derivedId = ""
    
    static func primaryKey() -> String? {
        return "derivedId"
    }
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurant = try values.decode(RestaurantDetails.self, forKey: .restaurant)
        derivedId = restaurant.id
    }
}

// MARK: - RestaurantDetails
struct RestaurantDetails: Codable, Realmable {
    var id = ""
    var name = ""
    var location = Location()
    var cuisines = ""
    var timings = ""
    var averageCostForTwo = 0
    var currency = ""
    var highlights = [String]()
    var thumb = ""
    var userRating = UserRating()
    var featuredImage = ""
    var establishment = [String]()
    
    enum CodingKeys: String, CodingKey {
        case id, name, location
        case cuisines, timings
        case averageCostForTwo = "average_cost_for_two"
        case currency, highlights
        case thumb
        case userRating = "user_rating"
        case featuredImage = "featured_image"
        case establishment
    }
    
    static func primaryKey() -> String? {
        return CodingKeys.id.rawValue
    }
    
    init() { }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        location = try values.decode(Location.self, forKey: .location)
        location.derivedId = id
        cuisines = try values.decode(String.self, forKey: .cuisines)
        timings = try values.decode(String.self, forKey: .timings)
        averageCostForTwo = try values.decode(Int.self, forKey: .averageCostForTwo)
        currency = try values.decode(String.self, forKey: .currency)
        highlights = try values.decode([String].self, forKey: .highlights)
        thumb = try values.decode(String.self, forKey: .thumb)
        userRating = try values.decode(UserRating.self, forKey: .userRating)
        userRating.derivedId = id
        featuredImage = try values.decode(String.self, forKey: .featuredImage)
        establishment = try values.decode([String].self, forKey: .establishment)
    }
}

// MARK: - Location
struct Location: Codable, Realmable {
    var latitude = ""
    var longitude = ""
    var localityVerbose = ""
    var derivedId = ""
    
    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case localityVerbose = "locality_verbose"
    }
    
    static func primaryKey() -> String? {
        return "derivedId"
    }
}

// MARK: - UserRating
struct UserRating: Codable, Realmable {
    var aggregateRating = ""
    var votes = 0
    var derivedId = ""
    
    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case votes
    }
    
    static func primaryKey() -> String? {
        return "derivedId"
    }
}
