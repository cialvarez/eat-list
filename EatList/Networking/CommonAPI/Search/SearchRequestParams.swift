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
}
// swiftlint:enable identifier_name
