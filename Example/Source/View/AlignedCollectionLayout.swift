//
//  AlignedCollectionLayout.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

protocol AlignedCollectionLayoutDelegate: class {
    var numberOfColumns: Int { get }
    var cellPadding: CGFloat { get }
    func collectionView(_ collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat
}

//class AlignedCollectionLayout: UICollectionViewLayout {
class AlignedCollectionLayout: UICollectionViewFlowLayout {
    var headerHeight: CGFloat = 0

    /** The `AlignedCollectionLayoutDelegate` object */
    weak var delegate: AlignedCollectionLayoutDelegate?

    /** The `Array` object that stores the layout cache. */
    private var cache: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()

    /** The dimensions for layout */
    private(set) var contentHeight: CGFloat = 0
    var contentWidth: CGFloat {
        guard let collectionView: UICollectionView = self.collectionView else { return 0 }
        let insets: UIEdgeInsets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }
    var columnWidth: CGFloat { return self.contentWidth / CGFloat(self.delegate?.numberOfColumns ?? 1) }
    override var collectionViewContentSize: CGSize { return CGSize(width: contentWidth, height: contentHeight) }

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }

    deinit { Logger()?.log("🧰🧹🧹🧹", []) }
}

extension AlignedCollectionLayout {
    func configure(delegate: AlignedCollectionLayoutDelegate, headerHeight: CGFloat = 0) {
        self.delegate = delegate
        self.headerHeight = headerHeight
    }

    /** The function that clears layout cache. */
    func reset() {
        self.cache.removeAll()
        self.prepare()
        self.invalidateLayout()
    }

    /** The function that creates layout cache. */
    override public func prepare() {
        /* Calculate only once */
        guard self.cache.isEmpty == true,
              let delegate: AlignedCollectionLayoutDelegate = self.delegate,
              let collectionView: UICollectionView = collectionView else { return }

        /* Pre-calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column */
        let numberOfColumns: Int = delegate.numberOfColumns
        let columnWidth: CGFloat = self.columnWidth
        var xOffsets: [CGFloat] = [CGFloat]()
        var yOffsets: [CGFloat] = [CGFloat](repeating: 0, count: numberOfColumns)

        for column: Int in 0..<numberOfColumns { xOffsets.append(CGFloat(column) * columnWidth) }
        var columnIndex: Int = 0

        /* Iterates through the list of items in the first section */
        self.contentHeight = 0
        for item: Int in 0..<collectionView.numberOfItems(inSection: 0) {

            /* Creates an UICollectionViewLayoutItem with the frame and add it to the cache */
            let indexPath = IndexPath(item: item, section: 0)

            /* Add header if the `headerHeight` value is greater than zero */
            switch indexPath.row {
            case 0 where self.headerHeight > 0: /* Header */

                /* Create the attribute and add to the layout cache */
                let attributes: UICollectionViewLayoutAttributes = .init(forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                                                         with: indexPath)
                attributes.frame = CGRect(x: 0, y: 0, width: self.collectionView!.frame.width, height: self.headerHeight)
                self.cache.append(attributes)

                /* Updates the collection view content height */
                self.contentHeight += self.headerHeight

            default:                            /* Contents */

                /* Asks the delegate for the height of the picture and the annotation and calculates the cell frame. */
                let cellPadding: CGFloat = delegate.cellPadding
                let cellHeight: CGFloat = delegate.collectionView(collectionView, heightForItemAtIndexPath: indexPath)
                let height: CGFloat = cellPadding * 2 + cellHeight
                let frame: CGRect = .init(x: xOffsets[columnIndex], y: yOffsets[columnIndex] + self.headerHeight,
                                          width: columnWidth, height: height)
                let insetFrame: CGRect = frame.insetBy(dx: cellPadding, dy: cellPadding)

                /* Create the attribute and add to the layout cache */
                let attributes: UICollectionViewLayoutAttributes = .init(forCellWith: indexPath)
                attributes.frame = insetFrame
                self.cache.append(attributes)

                /* Updates the collection view content height */
                self.contentHeight = max(self.contentHeight, frame.maxY)
                yOffsets[columnIndex] = yOffsets[columnIndex] + height

                /* Increment the column index */
                columnIndex = columnIndex < (numberOfColumns - 1) ? (columnIndex + 1) : 0
            }
        }
    }
}

extension AlignedCollectionLayout {
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        /* Loop through the cache and search for items in the rect */
        var visibleLayoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
        self.cache.forEach { (attributes: UICollectionViewLayoutAttributes) in
            guard attributes.frame.intersects(rect) else { return }
            visibleLayoutAttributes.append(attributes)
        }
        return visibleLayoutAttributes
    }

    override open func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return self.cache[indexPath.item]
    }

    override open func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard self.headerHeight > 0 else { return super.layoutAttributesForSupplementaryView(ofKind: elementKind, at: indexPath) }
        return self.cache[indexPath.item]
    }
}
