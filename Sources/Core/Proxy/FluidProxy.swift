//
//  FluidProxy.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The extension proxy for `Fluidable`.
 */
public struct FluidProxy<Base> {
    /** The base object to extend. */
    public let base: Base

    /**
     The initializer that creates extensions with the base object.

     - parameter base: The base object.
     */
    public init(_ base: Base) {
        self.base = base
    }
}
