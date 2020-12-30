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

    func setup() {
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
    }

    @objc func touchUp() {
        onTap()
    }
}
