//
//  TrendingSearchRequestParams.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
// swiftlint:disable identifier_name
struct TrendingSearchRequestParams: Codable, Parameterable {
//    var entityId: Int
//    var entityType: LocationType
    var lat: Double
    var lon: Double
    var collectionId: String = "1"
}
// swiftlint:enable identifier_name
