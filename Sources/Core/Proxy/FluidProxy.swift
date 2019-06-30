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
        set { /* this enables using `FluidProxy` to "mutate" base type */ }
    }

    /** The instance property for `FluidProxy` extensions. */
    public var fluid: FluidProxy<Self> {
        get { return FluidProxy(self) }
        set { /* this enables using `FluidProxy` to "mutate" base object */ }
    }
}

/* The UIViewController conforms to the `FluidCompatible` protocol. */
extension NSObject: FluidCompatible {
}
