//
//  MultiCollectionView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class HorizontalCollectionView: UICollectionView {
    var initiallyScrollToRight: Bool = false
    let cellSpacing: CGFloat = 10
    var cellWidth: CGFloat { return self.cellHeight }
    var cellHeight: CGFloat { return 192 - 20 - 10 }
    var selectionHandler: ((IndexPath) -> Void)?

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* NOTE: Setup delegate */
        self.delegate = self
        self.dataSource = self
        /* NOTE: Layout */
        self.collectionViewLayout = {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
            layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = cellSpacing
            layout.minimumInteritemSpacing = cellSpacing
            return layout
        }()
        /* NOTE: Register nib */
        self.register(cellType: CollectionCell.self)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard self.initiallyScrollToRight else { return }
        self.contentOffset.x = self.contentSize.width - self.frame.width - self.effectiveContentInset.right
        self.initiallyScrollToRight = false
        Logger()?.log("🥏", [
            "contentSize:" + String(describing: contentSize),
            "frame:" + String(describing: frame),
            "contentOffset:" + String(describing: contentOffset),
        ])
    }

    deinit { Logger()?.log("🥏🧹🧹🧹", []) }
}

extension HorizontalCollectionView {
    func configure(scrollToRight: Bool, handler: ((IndexPath) -> Void)? = nil) {
        self.initiallyScrollToRight = scrollToRight
        self.selectionHandler = handler
    }
}

extension HorizontalCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CollectionCell = collectionView.dequeueReusableCell(with: CollectionCell.self, for: indexPath)
        cell.configure(row: indexPath.row, cornerRadius: 4)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.deselectItem(at: indexPath, animated: true)
        self.selectionHandler?(indexPath)
    }
}
