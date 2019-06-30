//
//  TableView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class TableView: UITableView {
    var model: RootModel!

    var selectionHandler: ((IndexPath) -> Void)?

    var headerHeight: CGFloat = 0
    var headerView: HeaderCell?
    var headerPositionConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
}

extension TableView {
    func configure(model: RootModel, headerPosition: RootHeaderPosition = .top, handler: ((IndexPath) -> Void)? = nil) {
        self.model = model
        /* NOTE: Delegates */
        self.selectionHandler = handler
        self.delegate = self
        self.dataSource = self
        /* NOTE: Views */
        self.headerView = headerPosition == .none ? nil : HeaderCell.instantiate(model: model)
        self.headerHeight = self.headerView?.estimatedHeight ?? 0
        /* NOTE: Register */
        self.register(cellType: TableCell.self)
        self.register(cellType: HeaderCell.self)
        /* NOTE: Reload */
        self.reloadData()
    }
}

extension TableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return 30 }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = self.dequeueReusableCell(with: TableCell.self, for: indexPath)
        cell.configure(row: indexPath.row)
        return cell
    }
}

extension TableView: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.headerView
    }

    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat { return 0 }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { return 64 }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.deselectRow(at: indexPath, animated: true)
        self.selectionHandler?(indexPath)
    }
}
