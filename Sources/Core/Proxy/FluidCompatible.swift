//
//  FluidCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/25.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** The type that has `fluid` extensions. */
public protocol FluidCompatible {
    /** The extended type. */
    associatedtype CompatibleType

    /** The static property for `FluidProxy` extensions. */
    static var fluid: FluidProxy<CompatibleType>.Type { get set }

    /** The instance property for `FluidProxy` extensions. */
    var fluid: FluidProxy<CompatibleType> { get set }
}

extension FluidCompatible {
    /** The static property for `FluidProxy` extensions. */
    public static var fluid: FluidProxy<Self>.Type {
        get { return FluidProxy<Self>.self }
        set {
            _ = newValue
            /* this enables using `FluidProxy` to "mutate" base type */
        }
    }

    /** The instance property for `FluidProxy` extensions. */
    public var fluid: FluidProxy<Self> {
        get { return FluidProxy(self) }
        set {
            _ = newValue
            /* this enables using `FluidProxy` to "mutate" base object */
        }
    }
}

/* The UIViewController conforms to the `FluidCompatible` protocol. */
extension NSObject: FluidCompatible {
}
