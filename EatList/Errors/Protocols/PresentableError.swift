//
//  PresentableError.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation

protocol PresentableError: Error {
    var errorTitle: String { get }
    var errorMessage: String { get }
    var primaryButtonTitle: String { get }
    var dismissButtonTitle: String { get }
}

extension PresentableError {
    var primaryButtonTitle: String {
        return ""
    }
    var dismissButtonTitle: String {
        return R.string.localizable.buttonTitleClose()
    }
}
