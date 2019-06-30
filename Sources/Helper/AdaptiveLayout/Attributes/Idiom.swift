//
//  Idiom.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `UITraitCollection.init(userInterfaceIdiom idiom: UIUserInterfaceIdiom)`
 */
public enum Idiom: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(userInterfaceIdiom: .phone)` */
    case phone
    /** Correlates to `UITraitCollection(userInterfaceIdiom: .pad)` */
    case pad
    /** Correlates to `UITraitCollection(userInterfaceIdiom: .tv)` */
    case tv
    /** Correlates to `UITraitCollection(userInterfaceIdiom: .carPlay)` */
    case carPlay

    /**
     Creates `UITraitCollection` with correlating `UIUserInterfaceIdiom`

     - returns: New `UITraitCollection` with correlating `userInterfaceIdiom`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .phone: return UITraitCollection(userInterfaceIdiom: .phone)
        case .pad: return UITraitCollection(userInterfaceIdiom: .pad)
        case .tv: return UITraitCollection(userInterfaceIdiom: .tv)
        case .carPlay: return UITraitCollection(userInterfaceIdiom: .carPlay)
        }
    }
}
