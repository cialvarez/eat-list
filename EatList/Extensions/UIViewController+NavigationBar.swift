//
//  UIViewController+NavigationBar.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

extension UIViewController {
    func setupNavigation(title: String? = nil,
                         navBarBackgroundColor: UIColor = .clear,
                         backButtonColor: UIColor = .black) {
        self.title = title
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.backgroundColor = navBarBackgroundColor
        navigationController?.navigationBar.barTintColor = navBarBackgroundColor
        navigationController?.navigationBar.isTranslucent = navBarBackgroundColor == .clear ? true : false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        setupImageBackButton(color: backButtonColor)
    }
    
    func setupImageBackButton(color: UIColor) {
        // Setup back button only if the view controller isn't t he root view controller
        guard (navigationController?.viewControllers ?? []).count > 1 else {
            return
        }
        // Apple recommends a minimum target size of 44 pixels (px) wide 44 pixels for touch area.
        let backButton = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 44, height: 44)))
        backButton.setImage(R.image.back(), for: .normal)
        backButton.tintColor = color
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        let barBackButtonItem = UIBarButtonItem(customView: backButton)
        
        navigationItem.leftBarButtonItem = barBackButtonItem
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.layoutIfNeeded()
    }
    
    @objc func goBack() {
        navigationController?.popViewController(animated: true)
    }
}
