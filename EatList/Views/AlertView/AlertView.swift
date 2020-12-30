//
//  AlertView.swift
//  EatList
//
//  Created by Christian Alvarez on 12/29/20.
//

import UIKit

class AlertView: UIView, UIGestureRecognizerDelegate {

    struct ButtonParameters {
        let title: String
        let style = AlertViewButtonStyle.primary
        let onTap: (() -> Void) = { }
    }

    struct Parameters {
        var image: UIImage?
        var title: String
        var description: String
        var actions: [ButtonParameters]
    }
    
    // MARK: - Properties
    @IBOutlet weak var stackViewButtonContainer: UIStackView!
    @IBOutlet weak var stackViewContentContainer: UIStackView!
    @IBOutlet weak var imageTitle: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var containerView: CustomizableView!
    @IBOutlet weak var topMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMarginConstraint: NSLayoutConstraint!
    @IBOutlet weak var tapGestureRecognizer: UITapGestureRecognizer!
    @IBAction func didTap(_ sender: UITapGestureRecognizer) {
        self.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        viewLoadFromNib()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        viewLoadFromNib()
    }
    
    private func viewLoadFromNib() {
        guard let view = R.nib.alertView.firstView(owner: self) else {
            return
        }
        
        addSubview(view)
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    // MARK: - UIGestureRecognizerDelegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         if touch.view?.isDescendant(of: containerView) == true {
            return false
         }
         return true
    }

    // MARK: - Setup
    func render(with parameters: Parameters) {
        imageTitle.tintColor = .red
        imageTitle.image = parameters.image
        
        UIView.animate(withDuration: 0.5,
                       delay: 0.5,
                       options: .curveEaseInOut,
                       animations: {
            self.imageTitle.tintColor = .black
        })
        
        labelTitle.text = parameters.title
        labelDescription.text = parameters.description
        labelDescription.alpha = 0.7
        rightMarginConstraint.constant = 30
        leftMarginConstraint.constant = 30
        
        parameters.actions.forEach { action in
            let button = UIButton.actionButton(parameters: action)
            button.onTap = { [weak self] in
                self?.removeFromSuperview()
                action.onTap()
            }
            stackViewButtonContainer.addArrangedSubview(button)
        }
        
        blurBackground()
    }
    
    private func blurBackground() {
        backgroundColor = .clear
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            self?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        }, completion: nil)
    }
}

private extension UIButton {
    /// Generic method for action buttons with custom titles
    static func actionButton(parameters: AlertView.ButtonParameters) -> ActionButton {
        let button = ActionButton()
        button.contentEdgeInsets = parameters.style.contentEdgeInsets
        button.setTitle(parameters.title, for: .normal)
        button.backgroundColor = parameters.style.backgroundColor
        button.setTitleColor(parameters.style.titleColor, for: .normal)
        button.titleLabel?.textColor = parameters.style.titleColor
        button.titleLabel?.font = parameters.style.font
        button.layer.borderWidth = parameters.style.borderWidth
        button.layer.borderColor = parameters.style.borderColor.cgColor
        button.sizeToFit()
        button.layoutIfNeeded()
        button.layer.cornerRadius = button.frame.height / 2
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true

        return button
    }
}
