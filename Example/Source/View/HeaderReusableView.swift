//
//  heightConstraint.swift
//  FluidableExample
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class HeaderReusableView: UICollectionReusableView {
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    var estimatedHeight: CGFloat { return self.captionLabel.frame.maxY + 15 }

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    static func instantiate(model: RootModel) -> HeaderReusableView {
        let view: HeaderReusableView = UINib.instantiate(nibName: className)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.configure(model: model)
        return view
    }

    func configure(model: RootModel) {
        self.indexLabel.text = "Case \(String(format: "%02d", model.rawValue + 1))"
        self.titleLabel.text = model.title
        self.captionLabel.text = model.caption
        self.frame.size.height = self.estimatedHeight
    }
}
