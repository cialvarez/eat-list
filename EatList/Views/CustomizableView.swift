//
//  CustomizableView.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

@IBDesignable
class CustomizableView: UIView {
    
    @IBInspectable var primaryColor: UIColor = .clear {
        didSet {
            if let layer = self.layer as? CAGradientLayer {
                layer.colors = [self.primaryColor.cgColor, self.secondaryColor.cgColor]
            }
        }
    }
    
    @IBInspectable var secondaryColor: UIColor = .clear {
        didSet {
            if let layer = self.layer as? CAGradientLayer {
                layer.colors = [self.primaryColor.cgColor, self.secondaryColor.cgColor]
            }
        }
    }
    
    @IBInspectable var gradientStart: CGPoint = CGPoint(x: 0.0, y: 1.0) {
        didSet {
            if let layer = self.layer as? CAGradientLayer {
                layer.startPoint = self.gradientStart
            }
        }
    }
    
    @IBInspectable var gradientEnd: CGPoint = CGPoint(x: 1.0, y: 0.0) {
        didSet {
            if let layer = self.layer as? CAGradientLayer {
                layer.endPoint = self.gradientEnd
            }
        }
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    @IBInspectable var hasCurvedTopLeftCorner: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var hasCurvedTopRightCorner: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var hasCurvedBottomLeftCorner: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
    
    @IBInspectable var hasCurvedBottomRightCorner: Bool = false {
        didSet {
            updateCornerMask()
        }
    }
}

extension CustomizableView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
            setNeedsDisplay()
            setNeedsLayout()
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            guard let currentBorderColor = self.layer.borderColor else {
                return UIColor.clear
            }
            
            return UIColor(cgColor: currentBorderColor)
        }
        
        set {
            UIView.transition(with: self, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.layer.borderColor = newValue.cgColor
                self.setNeedsDisplay()
                self.setNeedsLayout()
            },
            completion: nil)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable private var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable private var masksToBounds: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
    
    private func updateCornerMask() {
        var cornerMask = CACornerMask.init()
        if hasCurvedTopLeftCorner { cornerMask.insert(.layerMinXMinYCorner) }
        if hasCurvedTopRightCorner { cornerMask.insert(.layerMaxXMinYCorner) }
        if hasCurvedBottomLeftCorner { cornerMask.insert(.layerMinXMaxYCorner) }
        if hasCurvedBottomRightCorner { cornerMask.insert(.layerMaxXMaxYCorner) }
        layer.maskedCorners = cornerMask
    }
    
}
