//
//  FluidPropertyAnimator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The custom animator that inherits `UIViewPropertyAnimator` and conforms to `FluidAnimatorCompatible` adding useful chainable functions.
 Please read (the official documentation)[https://developer.apple.com/documentation/uikit/animation_and_haptics/property-based_animations] about Property-Based Animations.
 */
public class FluidPropertyAnimator: UIViewPropertyAnimator, FluidAnimatorCompatible {
    /** The constant parameters. */
    internal struct Const {
        static let animationIdKey: String = "com.gumob.Fluidable.FluidPropertyAnimator.id"
    }

    /** The identifier for animation. */
    public internal(set) var identifier: String = ""

    /** The typealias for an animation block. */
    public typealias AnimationBlock = () -> Void

    /** The struct that stores animation data. */
    public struct AnimationData {
        let animationBlock: FluidPropertyAnimator.AnimationBlock
        let delayFactor: CGFloat?
        init(_ animations: @escaping FluidPropertyAnimator.AnimationBlock, delayFactor: CGFloat? = nil) {
            self.animationBlock = animations
            self.delayFactor = delayFactor
        }
    }

    /** The `Array` value that stores `Animation`. */
    internal var animations: [AnimationData]? = [AnimationData]()

    /** The completion percentage of the animation. */
    public override var fractionComplete: CGFloat {
        get { return super.fractionComplete }
        set {
            super.fractionComplete = newValue
            self.progressDidUpdate()
        }
    }
    internal var _currentFractionComplete: CGFloat = 0 {
        willSet {
            if 0 < newValue && newValue < 0.05 {
                self._currentFractionComplete = 0.0
            } else if 0.95 < newValue && newValue < 1.0 {
                self._currentFractionComplete = 1.0
            }
        }
        didSet {
            if self._previousFractionComplete != self._currentFractionComplete {
                self.progressBlock?(self.animatorProgress)
            }
            self._previousFractionComplete = self._currentFractionComplete
        }
    }
    internal var _previousFractionComplete: CGFloat = -1

    /** The `CGFloat` value that indicates the current animation progress. */
    public var animatorProgress: CGFloat {
        return self.isReversed ? 1 - self._currentFractionComplete : self._currentFractionComplete
    }

    /** The `FluidAnimatorState` value that indicates the current animation state. */
    public var animatorState: FluidAnimatorState { return self._animatorState }
    internal var _animatorState: FluidAnimatorState = .ready {
        didSet {
            guard self._animatorState != oldValue else { return }
            if self.animatorState == .finished {
                self.stopTimer()
            }
            self.stateBlock?(self.animatorState, self.animatorProgress)
        }
    }

    /** The `CADisplayLink` value to invoke a callback function. */
    internal var displayLink: CADisplayLink?

    /** The callback function that called  when the animation progress is changed. */
    internal var progressBlock: ProgressBlock?
    /** The callback function that called  when the animation state is changed. */
    internal var stateBlock: StateBlock?

    deinit { Logger()?.log("🐅🧹🧹🧹", ["id: " + String(describing: self.identifier)]) }
}

extension FluidPropertyAnimator {
    override public var description: String {
        return "FluidPropertyAnimator(id: \(self.identifier), state: \(self.animatorState), stateEx: \(self.stateEx), isInterruptible: \(self.isInterruptible))"
    }
}