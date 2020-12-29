//
//  Encodable+ToDictionary.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

extension Encodable {
    func toDictionary(encodingStrategy: JSONEncoder.KeyEncodingStrategy) -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = encodingStrategy
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
}
