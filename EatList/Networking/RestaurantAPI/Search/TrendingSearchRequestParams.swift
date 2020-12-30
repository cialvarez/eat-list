//
//  TrendingSearchRequestParams.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

struct TrendingSearchRequestParams: Codable, Parameterable {
    var lat: Double
    var lon: Double
    var collectionId: String = "1"
    var start: Int
    var count: Int = 20
}
