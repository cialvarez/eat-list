//
//  SearchResponse.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

// MARK: - SearchResponse
struct SearchResponse: Codable {
    let resultsFound, resultsStart, resultsShown: Int
    let restaurants: [Restaurant]

    enum CodingKeys: String, CodingKey {
        case resultsFound = "results_found"
        case resultsStart = "results_start"
        case resultsShown = "results_shown"
        case restaurants
    }
}

// MARK: - RestaurantElement
struct Restaurant: Codable {
    let restaurant: RestaurantDetails
}

// MARK: - RestaurantDetails
struct RestaurantDetails: Codable {
    let id: Int
    let name: String
    let url: String
    let location: Location
    let switchToOrderMenu: Int
    let cuisines, timings: String
    let averageCostForTwo, priceRange: Int
    let currency: Currency
    let highlights: [String]
    let opentableSupport, isZomatoBookRes: Int
    let mezzoProvider: MezzoProvider
    let isBookFormWebView: Int
    let bookFormWebViewURL, bookAgainURL: String
    let thumb: String
    let userRating: UserRating
    let allReviewsCount: Int
    let photosURL: String
    let photoCount: Int
    let menuURL: String
    let featuredImage: String
    let medioProvider: Bool
    let hasOnlineDelivery, isDeliveringNow: Int
    let storeType: String
    let includeBogoOffers: Bool
    let deeplink: String
    let isTableReservationSupported, hasTableBooking: Int
    let eventsURL: String
    let phoneNumbers: String
    let establishment: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, url, location
        case switchToOrderMenu = "switch_to_order_menu"
        case cuisines, timings
        case averageCostForTwo = "average_cost_for_two"
        case priceRange = "price_range"
        case currency, highlights
        case opentableSupport = "opentable_support"
        case isZomatoBookRes = "is_zomato_book_res"
        case mezzoProvider = "mezzo_provider"
        case isBookFormWebView = "is_book_form_web_view"
        case bookFormWebViewURL = "book_form_web_view_url"
        case bookAgainURL = "book_again_url"
        case thumb
        case userRating = "user_rating"
        case allReviewsCount = "all_reviews_count"
        case photosURL = "photos_url"
        case photoCount = "photo_count"
        case menuURL = "menu_url"
        case featuredImage = "featured_image"
        case medioProvider = "medio_provider"
        case hasOnlineDelivery = "has_online_delivery"
        case isDeliveringNow = "is_delivering_now"
        case storeType = "store_type"
        case includeBogoOffers = "include_bogo_offers"
        case deeplink
        case isTableReservationSupported = "is_table_reservation_supported"
        case hasTableBooking = "has_table_booking"
        case eventsURL = "events_url"
        case phoneNumbers = "phone_numbers"
        case establishment
    }
}

enum Currency: String, Codable {
    case empty = "$"
}

// MARK: - Location
struct Location: Codable {
    let address, locality: String
    let city: City
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

enum City: String, Codable {
    case newYorkCity = "New York City"
}

enum MezzoProvider: String, Codable {
    case other = "OTHER"
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
