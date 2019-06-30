//
//  SizeClass.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `UITraitCollection.init(horizontalSizeClass: UIUserInterfaceSizeClass)` and `UITraitCollection.init(verticalSizeClass: UIUserInterfaceSizeClass)`
 */
public enum SizeClass: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(horizontalSizeClass: .compact)` */
    case horizontalCompact
    /** Correlates to `UITraitCollection(horizontalSizeClass: .regular)` */
    case horizontalRegular
    /** Correlates to `UITraitCollection(verticalSizeClass: .compact)` */
    case verticalCompact
    /** Correlates to `UITraitCollection(verticalSizeClass: .regular)` */
    case verticalRegular

    /**
     Creates `UITraitCollection` with correlating `UIUserInterfaceSizeClass`

     - returns: New `UITraitCollection` with correlating `horizontalSizeClass` or `verticalSizeClass`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .horizontalCompact: return UITraitCollection(horizontalSizeClass: .compact)
        case .horizontalRegular: return UITraitCollection(horizontalSizeClass: .regular)
        case .verticalCompact: return UITraitCollection(verticalSizeClass: .compact)
        case .verticalRegular: return UITraitCollection(verticalSizeClass: .regular)
        }
    }
}
