//
//  Scale.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `UITraitCollection.init(displayScale scale: CGFloat)`
 */
public enum Scale: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(displayScale: 1.0)` */
    case oneX
    /** Correlates to `UITraitCollection(displayScale: 2.0)` */
    case twoX
    /** Correlates to `UITraitCollection(displayScale: 3.0)` */
    case threeX
    /** SO FUTURE!!! Correlates to `UITraitCollection(displayScale: 4.0)` */
    case fourX

    /**
     Creates `UITraitCollection` with correlating `CGFloat` scale

     - returns: New `UITraitCollection` with correlating `displayScale`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .oneX: return UITraitCollection(displayScale: 1.0)
        case .twoX: return UITraitCollection(displayScale: 2.0)
        case .threeX: return UITraitCollection(displayScale: 3.0)
        case .fourX: return UITraitCollection(displayScale: 4.0)
        }
    }
}
