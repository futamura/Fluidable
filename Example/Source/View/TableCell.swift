//
//  TableCell.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    private struct Const {
        static let titleTrailingMargin: CGFloat = 20
    }

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

    func layoutTextLabels(forContentWidth contentWidth: CGFloat) {
        self.contentView.layoutIfNeeded()
        self.titleLabel.lineBreakMode = .byTruncatingTail
        self.captionLabel.lineBreakMode = .byTruncatingTail

        let titleWidth: CGFloat = contentWidth - self.titleLabel.frame.minX - Const.titleTrailingMargin
        let captionWidth: CGFloat = contentWidth - self.captionLabel.frame.minX - self.contentView.layoutMargins.right
        self.titleLabel.frame.size.width = max(0, titleWidth)
        self.captionLabel.frame.size.width = max(0, captionWidth)
    }
}
