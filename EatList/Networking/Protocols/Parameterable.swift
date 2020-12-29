//
//  Parameterable.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

protocol Parameterable {
    var asDictionary: [String: Any] { get }
}

extension Parameterable where Self: Codable {
    var asDictionary: [String: Any] {
        return self.toDictionary(encodingStrategy: .convertToSnakeCase)
    }
}
