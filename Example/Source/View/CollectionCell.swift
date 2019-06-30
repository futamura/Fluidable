//
//  CollectionCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class CollectionCell: UICollectionViewCell, FluidInteractiveView {
    @IBOutlet weak var imageView: UIImageView!

    func configure(row: Int, cornerRadius: CGFloat = 0) {
        self.backgroundColor = .white
        self.imageView.image = UIImage(row: row, size: .medium)
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = true
        self.imageView.layer.cornerRadius = cornerRadius
        self.imageView.layer.masksToBounds = true
    }
}
