//
//  RootImageCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class RootImageCell: RootBaseCollectionCell {
    @IBOutlet weak var imageView: UIImageView!
    var headerView: HeaderView!

    var headerHeightConstraint: NSLayoutConstraint!
    var headerPositionConstraint: NSLayoutConstraint!

    override func configure(model: RootModel, handler: @escaping (Int) -> Void) {
        super.configure(model: model, handler: handler)
        /* Image */
        self.imageView.image = UIImage(row: model.rawValue, size: .medium)
        if self.headerView == nil {
            /* Header */
            self.headerView = .instantiate(model: model)
            self.contentView.addSubview(self.headerView)
            /* Constraint */
            self.headerHeightConstraint = self.headerView.heightAnchor.constraint(equalToConstant: self.headerView.estimatedHeight).activate()
            self.headerView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).activate()
            self.headerView.widthAnchor.constraint(equalTo: self.imageView.widthAnchor).activate()
        } else {
            self.headerView.configure(model: model)
        }
        self.layoutIfNeeded()
    }
}
