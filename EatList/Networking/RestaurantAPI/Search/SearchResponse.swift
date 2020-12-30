//
//  SearchResponse.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case restaurants
    }
}

// MARK: - RestaurantElement
struct Restaurant: Codable {
    let restaurant: RestaurantDetails
}

// MARK: - RestaurantDetails
struct RestaurantDetails: Codable {
    let name: String
    let location: Location
    let cuisines, timings: String
    let averageCostForTwo: Int
    let currency: String
    let highlights: [String]
    let thumb: String
    let userRating: UserRating
    let featuredImage: String
    let establishment: [String]

    enum CodingKeys: String, CodingKey {
        case name, location
        case cuisines, timings
        case averageCostForTwo = "average_cost_for_two"
        case currency, highlights
        case thumb
        case userRating = "user_rating"
        case featuredImage = "featured_image"
        case establishment
    }
}

// MARK: - Location
struct Location: Codable {
    let latitude, longitude: String
    let localityVerbose: String

    enum CodingKeys: String, CodingKey {
        case latitude, longitude
        case localityVerbose = "locality_verbose"
    }
}

// MARK: - UserRating
struct UserRating: Codable {
    let aggregateRating: String
    let votes: Int

    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case votes
    }
}
