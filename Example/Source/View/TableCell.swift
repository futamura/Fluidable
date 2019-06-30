//
//  TableCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    @IBOutlet weak var thumbView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    func configure(row: Int) {
        self.thumbView.image = UIImage(row: row, size: .small)
        self.thumbView.layer.cornerRadius = 4
        self.thumbView.layer.masksToBounds = true

        self.titleLabel.text = LoremIpsum.line(at: row)
        self.captionLabel.text = {
            let format: DateFormatter = DateFormatter()
            format.dateStyle = .full
            return format.string(from: Date())
        }()

        self.clipsToBounds = true
    }
}
