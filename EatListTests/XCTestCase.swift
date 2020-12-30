//
//  XCTestCase.swift
//  EatListTests
//
//  Created by Christian Alvarez on 12/31/20.
//

import XCTest

extension XCTest {
    // MARK: - Helper Methods
    func loadStub(name: String, fileExtension: String) -> Data {
        // Obtain Reference to Bundle
        let bundle = Bundle(for: type(of: self))

        // Ask Bundle for URL of Stub
        let url = bundle.url(forResource: name, withExtension: fileExtension)

        // swiftlint:disable force_try
        return try! Data(contentsOf: url!)
    }
}
