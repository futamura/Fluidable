//
//  Fluidable.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** Obj-C association key */
private struct AssociationKey {
    static let fluidDelegate: UnsafeMutablePointer<UInt> = UnsafeMutablePointer<UInt>.allocate(capacity: 1)
}

/**
 The `Fluidable` protocol.
 */
public protocol Fluidable: NSObjectProtocol {
    /** The `FluidDelegate` object. */
    var fluidDelegate: FluidDelegate? { get set }
}

public extension Fluidable where Self: UIViewController {
    weak var fluidDelegate: FluidDelegate? {
        get { return AssociatedObject.get(self, AssociationKey.fluidDelegate) }
        set { AssociatedObject.set(self, AssociationKey.fluidDelegate, newValue, .assign) }
    }
}
