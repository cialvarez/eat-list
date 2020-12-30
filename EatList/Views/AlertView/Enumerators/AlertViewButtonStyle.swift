//
//  AlertViewButtonStyle.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

enum AlertViewButtonStyle {
    case primary
    case secondary
}

extension AlertViewButtonStyle {
    var contentEdgeInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
    }
    
    var titleColor: UIColor {
        switch self {
        case .primary:
            return .white
        case .secondary:
            return .black
        }
    }
    
    var font: UIFont {
        switch self {
        case .primary: return .systemFont(ofSize: 12, weight: .semibold)
        case .secondary: return .systemFont(ofSize: 12, weight: .medium)
        }
    }
    
    var backgroundColor: UIColor? {
        switch self {
        case .primary: return .black
        case .secondary: return nil
        }
    }
    
    var borderColor: UIColor {
        switch self {
        case .primary,
             .secondary:
            return .clear
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .primary,
             .secondary:
            return 0
        }
    }
}
