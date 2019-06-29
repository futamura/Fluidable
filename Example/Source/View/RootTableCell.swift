//
//  RootTableCell.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class RootTableCell: RootBaseCollectionCell {
    @IBOutlet weak var tableView: TableView!

    override func configure(model: RootModel, handler: @escaping (Int) -> Void) {
        super.configure(model: model, handler: handler)

        self.tableView.layer.cornerRadius = ExampleConst.cornerRadius
        self.tableView.layer.borderColor = UIColor.clear.cgColor
        self.tableView.layer.masksToBounds = true

        self.tableView.isUserInteractionEnabled = false
        self.tableView.clipsToBounds = false
        
        self.tableView.configure(model: self.model)
    }
}
