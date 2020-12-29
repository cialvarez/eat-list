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
    let switchToOrderMenu: Int
    let cuisines, timings: String
    let averageCostForTwo, priceRange: Int
    let currency: String
    let highlights: [String]
    let opentableSupport, isZomatoBookRes: Int
    let thumb: String
    let userRating: UserRating
    let allReviewsCount: Int
    let photosURL: String?
    let photoCount: Int
    let menuURL: String?
    let featuredImage: String
    let hasOnlineDelivery, isDeliveringNow: Int
    let isTableReservationSupported, hasTableBooking: Int
    let phoneNumbers: String
    let establishment: [String]

    enum CodingKeys: String, CodingKey {
        case name, location
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines, timings
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case currency, highlights
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case thumb
        case userRating = "user_rating"
        case allReviewsCount = "all_reviews_count"
        case photosURL = "photos_url"
        case photoCount = "photo_count"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case phoneNumbers = "phone_numbers"
        case establishment
    }
}

// MARK: - Location
struct Location: Codable {
    let address, locality: String
    let city: String
    let cityID: Int
    let latitude, longitude, zipcode: String
    let countryID: Int
    let localityVerbose: String

    enum CodingKeys: String, CodingKey {
        case address, locality, city
        case cityID = "city_id"
        case latitude, longitude, zipcode
        case countryID = "country_id"
        case localityVerbose = "locality_verbose"
    }
}

// MARK: - UserRating
struct UserRating: Codable {
    let aggregateRating: String
    let ratingText: RatingText
    let ratingColor: RatingColor
    let ratingObj: RatingObj
    let votes: Int

    enum CodingKeys: String, CodingKey {
        case aggregateRating = "aggregate_rating"
        case ratingText = "rating_text"
        case ratingColor = "rating_color"
        case ratingObj = "rating_obj"
        case votes
    }
}

enum RatingColor: String, Codable {
    case the3F7E00 = "3F7E00"
    case the5Ba829 = "5BA829"
    case the9Acd32 = "9ACD32"
}

// MARK: - RatingObj
struct RatingObj: Codable {
    let title: Title
    let bgColor: BgColor

    enum CodingKeys: String, CodingKey {
        case title
        case bgColor = "bg_color"
    }
}

// MARK: - BgColor
struct BgColor: Codable {
    let type: TypeEnum
    let tint: String
}

enum TypeEnum: String, Codable {
    case lime = "lime"
}

// MARK: - Title
struct Title: Codable {
    let text: String
}

enum RatingText: String, Codable {
    case excellent = "Excellent"
    case good = "Good"
    case veryGood = "Very Good"
}
