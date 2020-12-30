//
//  UIViewController+Banner.swift
//  EatList
//
//  Created by Christian Alvarez on 12/31/20.
//

import UIKit

extension UIViewController {
    func showOfflineBanner() {
        showBanner(duration: 5,
                   color: UIColor(displayP3Red: 231/255, green: 79/255, blue: 87/255, alpha: 1),
                   text: "Poor network connection detected. Please check your connection and try again.")
    }
    
    func showBanner(duration: Double = 5,
                    color: UIColor,
                    text: String,
                    icon: UIImage? = nil) {
        let height: CGFloat = 60
        let insets = UIEdgeInsets(top: 10, left: 20, bottom: 0, right: 20)
        guard let topView = view.window,
              !topView.subviews.contains(where: { $0.tag == text.hashValue }) else {
            return
        }
        let bannerView = UIView()
        bannerView.tag = text.hashValue
        bannerView.backgroundColor = color
        topView.addSubview(bannerView)
        
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        bannerView.addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        let statusBarApproximateSize = CGFloat(20)
        let navigationBarApproximateSize = CGFloat(44)
        let hasNotch = view.safeAreaInsets.top > (statusBarApproximateSize + navigationBarApproximateSize)
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: bannerView.leadingAnchor, constant: insets.left),
            titleLabel.trailingAnchor.constraint(equalTo: bannerView.trailingAnchor, constant: -insets.right),
            titleLabel.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor, constant: insets.bottom),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: hasNotch ? insets.top + statusBarApproximateSize : insets.top),
            titleLabel.heightAnchor.constraint(equalToConstant: height),
            
            bannerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bannerView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
                
        bannerView.transform = .init(translationX: 0, y: -height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            bannerView.transform = .identity
        }, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                bannerView.transform = .init(translationX: 0, y: -height)
            }, completion: { _ in
                bannerView.removeFromSuperview()
            })
        }
    }
}
