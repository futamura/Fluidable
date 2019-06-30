//
//  RootImageTextCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class RootImageTextCell: RootImageCell {
    @IBOutlet weak var textLabel: UILabel!

    override func configure(model: RootModel, handler: @escaping (Int) -> Void) {
        super.configure(model: model, handler: handler)
    }
}

