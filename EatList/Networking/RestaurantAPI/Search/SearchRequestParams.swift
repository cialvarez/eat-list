//
//  SearchRequestParams.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
// swiftlint:disable identifier_name
struct SearchRequestParams: Codable, Parameterable {
    var entityId: Int
    var entityType: LocationType
    var q: String
    var start: Int
    var count: Int
    var lat: Double
    var lon: Double
    var radius: Double
    var cuisines: String
    var establishmentType: String
    var collectionId: String
    var category: String
    var sort: SortType
    var order: OrderType
}
// swiftlint:enable identifier_name
