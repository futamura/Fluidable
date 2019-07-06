//
//  RootViewController+Collection.swift
//  Example
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

extension RootViewController {
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
            if let layout: AlignedCollectionLayout = self?.collectionView.collectionViewLayout as? AlignedCollectionLayout {
                layout.reset()
            }
        }, completion: { (context: UIViewControllerTransitionCoordinatorContext) in
        })
    }
}

extension RootViewController: AlignedCollectionLayoutDelegate {
    var numberOfColumns: Int { return ExampleConst.collectionNumberOfColumns }

    var cellPadding: CGFloat { return 12 }

    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        return RootModel(rawValue: indexPath.row)!.cellType.size.height
    }
}

extension RootViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return RootModel.allCases.count }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let model: RootModel = RootModel(rawValue: indexPath.row) else { return UICollectionViewCell() }
        switch model.cellType {
        case .image:
            let cell: RootImageCell = collectionView.dequeueReusableCell(with: RootImageCell.self, for: indexPath)
            cell.configure(model: model) { [weak self] (index: Int) in self?.didTapCell(index: index) }
            return cell
        case .imageText:
            let cell: RootImageTextCell = collectionView.dequeueReusableCell(with: RootImageTextCell.self, for: indexPath)
            cell.configure(model: model) { [weak self] (index: Int) in self?.didTapCell(index: index) }
            return cell
        case .table:
            let cell: RootTableCell = collectionView.dequeueReusableCell(with: RootTableCell.self, for: indexPath)
            cell.configure(model: model) { [weak self] (index: Int) in self?.didTapCell(index: index) }
            return cell
        }
    }

//    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let model: RootModel = RootModel(rawValue: indexPath.row) else { return }
//        Logger()?.log("👑💥", [
//            "indexPath.row: " + String(describing: indexPath.row),
//        ])
//        let cell: RootImageCell = collectionView.dequeueReusableCell(with: RootImageCell.self, for: indexPath)
//        cell.isAccessibilityElement = true
//        cell.accessibilityIdentifier = model.description
//    }

    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool { return false }
}
