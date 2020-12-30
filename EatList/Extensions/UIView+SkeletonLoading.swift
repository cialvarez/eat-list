//
//  UIView+SkeletonLoading.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

enum SkeletonLoadingConstants {
    static let gradientBaseColor = R.color.gradientBase() ?? UIColor.lightGray
    static let gradientSecondaryColor = R.color.gradientSecondary() ?? UIColor.darkGray
}

extension UIView {
    func toggleSkeleton(isShown: Bool, cornerRadius: CGFloat = 0) {
        DispatchQueue.main.async {
            self.layer.sublayers?.removeAll(where: { $0.name == "skeleton" })
            
            guard isShown else { return }
            
            let movingAnimationDuration = CFTimeInterval(1.5)
            let delayBetweenAnimationLoops = CFTimeInterval(0)
            
            self.layoutIfNeeded()
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.bounds
            gradientLayer.colors = [SkeletonLoadingConstants.gradientBaseColor.cgColor,
                                    SkeletonLoadingConstants.gradientSecondaryColor.cgColor,
                                    SkeletonLoadingConstants.gradientBaseColor.cgColor]
            gradientLayer.locations = [-1, -0.5, 0]
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 1, y: 1)
            gradientLayer.masksToBounds = true
            gradientLayer.cornerRadius = cornerRadius
            self.clipsToBounds = true
            self.layer.addSublayer(gradientLayer)
            
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-1, -0.5, 0]
            animation.toValue = [1, 1.5, 2]
            animation.duration = movingAnimationDuration
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = movingAnimationDuration + delayBetweenAnimationLoops
            animationGroup.animations = [animation]
            animationGroup.repeatCount = .infinity
            
            gradientLayer.add(animationGroup, forKey: animation.keyPath)
            gradientLayer.name = "skeleton"
        }
    }
}
