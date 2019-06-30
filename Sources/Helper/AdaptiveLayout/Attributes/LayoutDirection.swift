//
//  LayoutDirection.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `init(layoutDirection: UITraitEnvironmentLayoutDirection)`
 */
@available(iOS 10.0, *)
public enum LayoutDirection: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(layoutDirection: .leftToRight)` */
    case leftToRight
    /** Correlates to `UITraitCollection(layoutDirection: .rightToLeft)` */
    case rightToLeft

    /**
     Creates `UITraitCollection` with correlating `UIUserInterfaceLayoutDirection`

     - returns: New `UITraitCollection` with correlating `layoutDirection`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .leftToRight: return UITraitCollection(layoutDirection: .leftToRight)
        case .rightToLeft: return UITraitCollection(layoutDirection: .rightToLeft)
        }
    }
}
