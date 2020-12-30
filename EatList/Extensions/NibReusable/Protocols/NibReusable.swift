//
//  NibReusable.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import Foundation

protocol NibReusable: class {
    static var reuseIdentifier: String { get }
}

extension NibReusable {
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
}
