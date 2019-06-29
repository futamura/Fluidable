//
//  AlignedCollectionView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class AlignedCollectionView: UICollectionView {
    var model: RootModel!
    var headerPosition: RootHeaderPosition = .top
    var selectionHandler: ((IndexPath) -> Void)?
    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
}

extension AlignedCollectionView {
    func configure(model: RootModel, headerPosition: RootHeaderPosition = .top, handler: ((IndexPath) -> Void)? = nil) {
        self.model = model
        self.headerPosition = headerPosition
        self.selectionHandler = handler
        /* NOTE: Delegate */
        self.delegate = self
        self.dataSource = self
        /* NOTE: View */
        self.backgroundColor = .white
        self.backgroundView = UIView()
        self.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 20, right: 10)
        if let layout: AlignedCollectionLayout = self.collectionViewLayout as? AlignedCollectionLayout {
            let headerHeight: CGFloat = headerPosition == .none ? 0 : HeaderReusableView.instantiate(model: self.model).estimatedHeight
            layout.configure(delegate: self, headerHeight: headerHeight)
        }
        /* NOTE: Register nib */
        self.register(cellType: CollectionCell.self)
        self.register(reusableViewType: HeaderReusableView.self)
        self.reloadData()
    }
}

extension AlignedCollectionView: AlignedCollectionLayoutDelegate {
    var numberOfColumns: Int {
        let size: CGSize = UIApplication.shared.keyWindow?.bounds.size ?? CGSize(width: 6, height: 4)
        let isLandscape: Bool = size.width > size.height
        switch isLandscape {
        case true:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad: return 5
            default:   return 4
            }
        case false:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad: return 4
            default:   return 3
            }
        }
    }

    var cellPadding: CGFloat { return 5 }

    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        guard let layout: AlignedCollectionLayout = self.collectionViewLayout as? AlignedCollectionLayout,
              let image: UIImage = UIImage(row: indexPath.row, size: .small) else { return 0 }
        let ratio: CGFloat = layout.columnWidth / image.size.width
        return ratio * image.size.height
    }
}

extension AlignedCollectionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { return 30 }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch ElementKind(from: kind) {
        case .header where headerPosition != .none:
            let cell: HeaderReusableView = collectionView.dequeueReusableView(with: HeaderReusableView.self, for: indexPath)
            cell.configure(model: self.model)
            return cell
        default: return UICollectionReusableView()
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionCell = collectionView.dequeueReusableCell(with: CollectionCell.self, for: indexPath)
        cell.configure(row: indexPath.row)
        return cell
    }
}

extension AlignedCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.deselectItem(at: indexPath, animated: true)
        self.selectionHandler?(indexPath)
    }
}
