//
//  ForceTouch.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `UITraitCollection.init(forceTouchCapability capability: UIForceTouchCapability)`
 */
public enum ForceTouch: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(forceTouchCapability: .unavailable) */
    case unavailable
    /** Correlates to `UITraitCollection(forceTouchCapability: .available) */
    case available

    /**
     Creates `UITraitCollection` with correlating `UIForceTouchCapability`

     - returns: New `UITraitCollection` with correlating `forceTouchCapability`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .unavailable: return UITraitCollection(forceTouchCapability: .unavailable)
        case .available: return UITraitCollection(forceTouchCapability: .available)
        }
    }
}
