//
//  FluidAnimatorCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The protocol that compatible to `FluidCoreAnimator` and `FluidPropertyAnimator`.
 */
public protocol FluidAnimatorCompatible: NSObjectProtocol {
    /** The typealias of a progression block. */
    typealias ProgressBlock = ((CGFloat) -> Void)

    /** The typealias of a state block. */
    typealias StateBlock = ((FluidAnimatorState, CGFloat) -> Void)

    /** The unique identifier. */
    var identifier: String { get }

    /** The `CGFloat` value that indicates the animation progress. */
    var animatorProgress: CGFloat { get }

    /** The `FluidAnimatorState` value that indicates the animation state. */
    var animatorState: FluidAnimatorState { get }

    /** The function that runs the animation. */
    @discardableResult
    func run() -> Self

    /** The function that invalidate the animation. */
    @discardableResult
    func invalidate() -> Self
}

extension FluidAnimatorCompatible where Self: FluidCoreAnimator {
}

extension FluidAnimatorCompatible where Self: FluidPropertyAnimator {
}
