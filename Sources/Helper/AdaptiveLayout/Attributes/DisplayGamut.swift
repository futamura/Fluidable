//
//  DisplayGamut.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `init(displayGamut: UIDisplayGamut)`
 */
@available(iOS 10.0, *)
public enum DisplayGamut: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(displayGamut: .SRGB)` */
    case SRGB
    /** Correlates to `UITraitCollection(displayGamut: .P3)` */
    case P3

    /**
     Creates `UITraitCollection` with correlating `UIUserInterfaceDisplayGamut`

     - returns: New `UITraitCollection` with correlating `displayGamut`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .SRGB: return UITraitCollection(displayGamut: .SRGB)
        case .P3: return UITraitCollection(displayGamut: .P3)
        }
    }
}
