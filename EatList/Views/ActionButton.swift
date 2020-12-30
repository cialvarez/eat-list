//
//  ActionButton.swift
//  EatList
//
//  Created by Christian Alvarez on 12/30/20.
//

import UIKit

class ActionButton: UIButton {
    var onTap: () -> Void = { }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    private func setup() {
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }

    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        self.animateTouchDown()
        return true
    }

    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        self.animateTouchUp()
    }
    
    @objc func touchUp() {
        onTap()
    }
}
