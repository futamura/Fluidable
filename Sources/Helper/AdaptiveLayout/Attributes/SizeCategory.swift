//
//  SizeCategory.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 `AdaptiveAttribute` correlating to `init(preferredContentSizeCategory: UIContentSizeCategory)`
 */
@available(iOS 10.0, *)
public enum SizeCategory: AdaptiveAttribute {

    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .extraSmall) */
    case extraSmall
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .small) */
    case small
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .medium) */
    case medium
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .large) */
    case large
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .extraLarge) */
    case extraLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .extraExtraLarge) */
    case extraExtraLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge) */
    case extraExtraExtraLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .accessibilityMedium) */
    case accessibilityMedium
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .accessibilityLarge) */
    case accessibilityLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .accessibilityExtraLarge) */
    case accessibilityExtraLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraLarge) */
    case accessibilityExtraExtraLarge
    /** Correlates to `UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge) */
    case accessibilityExtraExtraExtraLarge

    /**
     Creates `UITraitCollection` with correlating `UIUserInterfaceSizeCategory`

     - returns: New `UITraitCollection` with correlating `sizeCategory`
     */
    public func generateTraitCollection() -> UITraitCollection {
        switch self {
        case .extraSmall: return UITraitCollection(preferredContentSizeCategory: .extraSmall)
        case .small: return UITraitCollection(preferredContentSizeCategory: .small)
        case .medium: return UITraitCollection(preferredContentSizeCategory: .medium)
        case .large: return UITraitCollection(preferredContentSizeCategory: .large)
        case .extraLarge: return UITraitCollection(preferredContentSizeCategory: .extraLarge)
        case .extraExtraLarge: return UITraitCollection(preferredContentSizeCategory: .extraExtraLarge)
        case .extraExtraExtraLarge: return UITraitCollection(preferredContentSizeCategory: .extraExtraExtraLarge)
        case .accessibilityMedium: return UITraitCollection(preferredContentSizeCategory: .accessibilityMedium)
        case .accessibilityLarge: return UITraitCollection(preferredContentSizeCategory: .accessibilityLarge)
        case .accessibilityExtraLarge: return UITraitCollection(preferredContentSizeCategory: .accessibilityExtraLarge)
        case .accessibilityExtraExtraLarge: return UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraLarge)
        case .accessibilityExtraExtraExtraLarge: return UITraitCollection(preferredContentSizeCategory: .accessibilityExtraExtraExtraLarge)
        }
    }
}
