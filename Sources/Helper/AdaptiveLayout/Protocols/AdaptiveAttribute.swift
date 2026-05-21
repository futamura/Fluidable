//
//  AdaptiveAttribute.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 An `AdaptiveAttribute` represents a trait in a `UITraitCollection`.
 */
public protocol AdaptiveAttribute {

    /**
     Creates a `UITraitCollection` corresponding to the trait `self` represents
     */
    func generateTraitCollection() -> UITraitCollection
}
