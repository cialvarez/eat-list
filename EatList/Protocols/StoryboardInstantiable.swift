//
//  StoryboardInstantiable.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import Foundation
import UIKit

protocol StoryboardInstantiable: UIViewController {
    associatedtype Input
    associatedtype Output
    static func generateFromStoryboard(input: Input, output: Output) -> UIViewController
}
