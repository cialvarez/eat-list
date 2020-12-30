//
//  UIView+Animations.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

extension UIView {
    func animateShadow(isShown: Bool, timing: CAMediaTimingFunctionName = .default, duration: CFTimeInterval = 0.3, lowValue: Float = 0) {
        let shadowOpacityAnimation = CABasicAnimation()
        shadowOpacityAnimation.fromValue = isShown ? lowValue : self.layer.shadowOpacity
        shadowOpacityAnimation.toValue = isShown ? self.layer.shadowOpacity : lowValue
        shadowOpacityAnimation.isRemovedOnCompletion = false
        shadowOpacityAnimation.fillMode = .forwards
        shadowOpacityAnimation.duration = duration
        shadowOpacityAnimation.timingFunction = CAMediaTimingFunction(name: timing)
        self.layer.add(shadowOpacityAnimation, forKey: "shadowOpacity")
    }
    
    func animateTouchDown(duration: Double = 0.1) {
        self.transform = .identity
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .init(scaleX: 0.95, y: 0.95)
            }, completion: nil)
        animateShadow(isShown: false, timing: .easeOut, duration: duration, lowValue: self.layer.shadowOpacity / 2.0)
    }
    
    func animateTouchUp(duration: Double = 0.2) {
        self.transform = .init(scaleX: 0.95, y: 0.95)
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: [.curveEaseOut, .allowUserInteraction],
            animations: { [weak self] in
                self?.transform = .identity
            }, completion: nil)
        animateShadow(isShown: true, timing: .easeOut, duration: duration, lowValue: self.layer.shadowOpacity / 2.0)
    }
    
    func shake() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.08
        animation.repeatCount = 2
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 4, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 4, y: self.center.y))
        
        self.layer.add(animation, forKey: "position")
    }
}
