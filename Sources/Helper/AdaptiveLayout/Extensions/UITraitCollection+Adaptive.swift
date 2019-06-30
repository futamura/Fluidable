//
//  UITraitCollection+Adaptive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 This extension provides a mapping between `AdaptiveAttribute` and `UITraitCollection`.
 */
public extension UITraitCollection {
    /**
     Create a `UITraitCollection` from one or more `AdaptiveAttribute`s.

     - parameter attributes: Array of `AdaptiveAttribute` from which a new `UITraitCollection` will be created
     */
    convenience init(attributes: [AdaptiveAttribute]) {
        let traitCollections: [UITraitCollection] = attributes.map { $0.generateTraitCollection() }
        self.init(traitsFrom: traitCollections)
    }

    /**
     Check if the `UITraitCollection` contains an `AdaptiveAttribute`.

     - parameter attribute: The `AdaptiveAttribute` we want to find in the `UITraitCollection`
     - returns: Returns `true` if the `UITraitCollection` contains the `AdaptiveAttribute`, else, `false`
     */
    func contains(_ attribute: AdaptiveAttribute) -> Bool {
        return containsTraits(in: attribute.generateTraitCollection())
    }

    /**
     Array of `AdaptiveAttribute`s that describe the `self`
     */
    var adaptiveAttributes: [AdaptiveAttribute] {
        var attributes: [AdaptiveAttribute] = []

        switch userInterfaceIdiom {
        case .pad: attributes.append(Idiom.pad)
        case .phone: attributes.append(Idiom.phone)
        case .tv: attributes.append(Idiom.tv)
        case .carPlay: attributes.append(Idiom.carPlay)
        case .unspecified: break
        }

        switch displayScale {
        case 1.0: attributes.append(Scale.oneX)
        case 2.0: attributes.append(Scale.twoX)
        case 3.0: attributes.append(Scale.threeX)
        case 4.0: attributes.append(Scale.fourX)
        default: break
        }

        switch horizontalSizeClass {
        case .compact: attributes.append(SizeClass.horizontalCompact)
        case .regular: attributes.append(SizeClass.horizontalRegular)
        case .unspecified: break
        }

        switch verticalSizeClass {
        case .compact: attributes.append(SizeClass.verticalCompact)
        case .regular: attributes.append(SizeClass.verticalRegular)
        case .unspecified: break
        }

        switch forceTouchCapability {
        case .available: attributes.append(ForceTouch.available)
        case .unavailable: attributes.append(ForceTouch.unavailable)
        case .unknown: break
        }

        if #available(iOS 10.0, *) {
            switch layoutDirection {
            case .leftToRight: attributes.append(LayoutDirection.leftToRight)
            case .rightToLeft: attributes.append(LayoutDirection.rightToLeft)
            case .unspecified: break
            }
        }

        if #available(iOS 10.0, *) {
            switch preferredContentSizeCategory {
            case .extraSmall: attributes.append(SizeCategory.extraSmall)
            case .small: attributes.append(SizeCategory.small)
            case .medium: attributes.append(SizeCategory.medium)
            case .large: attributes.append(SizeCategory.large)
            case .extraLarge: attributes.append(SizeCategory.extraLarge)
            case .extraExtraLarge: attributes.append(SizeCategory.extraExtraLarge)
            case .extraExtraExtraLarge: attributes.append(SizeCategory.extraExtraExtraLarge)
            case .accessibilityMedium: attributes.append(SizeCategory.accessibilityMedium)
            case .accessibilityLarge: attributes.append(SizeCategory.accessibilityLarge)
            case .accessibilityExtraLarge: attributes.append(SizeCategory.accessibilityExtraLarge)
            case .accessibilityExtraExtraLarge: attributes.append(SizeCategory.accessibilityExtraExtraLarge)
            case .accessibilityExtraExtraExtraLarge: attributes.append(SizeCategory.accessibilityExtraExtraExtraLarge)
            default: break
            }
        }

        if #available(iOS 10.0, *) {
            switch displayGamut {
            case .SRGB: attributes.append(DisplayGamut.SRGB)
            case .P3: attributes.append(DisplayGamut.P3)
            case .unspecified: break
            }
        }

        return attributes
    }
}
