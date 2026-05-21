//
//  FluidResizable.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/28.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** Obj-C association key */
private struct AssociationKey {
    static let fluidResizableDelegate: UnsafeMutablePointer<UInt> = UnsafeMutablePointer<UInt>.allocate(capacity: 1)
}

/**
 The `FluidResizable` protocol.
 */
public protocol FluidResizable: NSObjectProtocol {
    /** The `FluidResizableDelegate` object. */
    var fluidResizableDelegate: FluidResizableTransitionDelegate? { get set }
}

public extension FluidResizable where Self: UIViewController {
    weak var fluidResizableDelegate: FluidResizableTransitionDelegate? {
        get { return AssociatedObject.get(self, AssociationKey.fluidResizableDelegate) }
        set { AssociatedObject.set(self, AssociationKey.fluidResizableDelegate, newValue, .assign) }
    }
}
