//
//  CloseButton.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class CloseButton: UIButton, FluidInteractiveView {
    var shrinkScale: CGFloat { return 0.8 }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.shrink()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.restore()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.restore()
    }
}

class RoundButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let titleLabel: UILabel = self.titleLabel {
            titleLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize, weight: .semibold)
            titleLabel.baselineAdjustment = .none
            titleLabel.sizeToFit()
            titleLabel.textColor = .darkGray
        }
        self.layer.borderColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 4
//        self.layer.borderWidth = 1.0 / UIScreen.main.scale
        self.layer.borderWidth = 1.0
        self.layer.masksToBounds = true
        self.layer.displayIfNeeded()
        self.setNeedsUpdateConstraints()
    }
}
