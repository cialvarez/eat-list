//
//  UIViewController+AlertView.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

extension UIViewController {
    @discardableResult
    func showError(error: EatListError) -> AlertView? {
        view.window?.endEditing(true)
        let alertHash = (error.errorTitle + error.errorMessage).hashValue
        guard !view.subviews.contains(where: { $0.tag == alertHash }) else {
            return nil
        }
        
        let alertView = AlertView()
        alertView.tag = alertHash
        alertView.render(with: .init(image: R.image.errorIcon(),
                                     title: error.errorTitle,
                                     description: error.errorMessage,
                                     actions: [.init(title: error.dismissButtonTitle)]))
        alertView.translatesAutoresizingMaskIntoConstraints = false
        UIView.transition(
            with: view,
            duration: 0.2,
            options: [.curveEaseInOut, .transitionCrossDissolve],
            animations: {
                self.view.addSubview(alertView)
            }, completion: nil)
        
        view.bringSubviewToFront(alertView)
        
        NSLayoutConstraint.activate([
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertView.topAnchor.constraint(equalTo: view.topAnchor),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        alertView.alpha = 0
        alertView.containerView.transform = .init(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            alertView.alpha = 1
            alertView.containerView.transform = .identity
        }, completion: nil)
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
        
        return alertView
    }
}
