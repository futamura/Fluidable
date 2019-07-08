//
//  RootBaseCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class RootBaseCollectionCell: UICollectionViewCell, FluidInteractiveView {
    var model: RootModel!
    var touchHandler: ((Int) -> Void)?

    func configure(model: RootModel, handler: @escaping (Int) -> Void) {
        self.model = model
        self.touchHandler = handler

        self.isAccessibilityElement = true
        self.accessibilityIdentifier = model.description + "Cell"

        self.contentView.layer.cornerRadius = ExampleConst.cornerRadius
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = Float(ExampleConst.shadowOpacity)
        self.layer.cornerRadius = ExampleConst.cornerRadius
        self.layer.shadowRadius = ExampleConst.shadowRadius
        self.layer.shadowOffset = ExampleConst.shadowOffset
        self.layer.masksToBounds = true

        self.clipsToBounds = false
        self.selectedBackgroundView = nil
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.shrink()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: { [weak self] in
            guard let `self`: RootBaseCollectionCell = self else { return }
            self.touchHandler?(self.model.rawValue)
            self.restore()
        })
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.restore()
    }
}
