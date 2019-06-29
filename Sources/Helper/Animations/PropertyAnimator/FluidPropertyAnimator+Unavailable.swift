//
//  FluidPropertyAnimator+Unavailable.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Initializing a Property Animator
 */
public extension FluidPropertyAnimator {
    @available(*, unavailable)
    override class func runningPropertyAnimator(withDuration duration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping () -> Void, completion: ((UIViewAnimatingPosition) -> Void)? = nil) -> Self {
        fatalError("`UIViewPropertyAnimator.runningPropertyAnimator(duration:delay:options:animations:completion:)` is unavailable.")
    }
}

/**
 Modifying Animations
 */
public extension FluidPropertyAnimator {
    /** WARN: `UIViewPropertyAnimator.addAnimations(animation:)` is unavailable. Use `FluidPropertyAnimator.add(animation:)` instead. */
    @available(*, unavailable)
    override func addAnimations(_ animation: @escaping () -> Void) {
        self.add(animation)
    }

    /** WARN: `UIViewPropertyAnimator.addAnimations(animation:delayFactor:)` is unavailable. Use `FluidPropertyAnimator.add(animation:delayFactor:)` instead. */
    @available(*, unavailable)
    override func addAnimations(_ animation: @escaping () -> Void, delayFactor: CGFloat) {
        self.add(animation, delayFactor: delayFactor)
    }

    /** WARN: `UIViewPropertyAnimator.addCompletion(completion:)` is unavailable. Use `FluidPropertyAnimator.on(block:)` instead. */
    @available(*, unavailable)
    override func addCompletion(_ completion: @escaping (UIViewAnimatingPosition) -> Void) {
//        super.addCompletion(completion)
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in self?.positionDidChange(position: position) })
    }

    /** WARN: `UIViewPropertyAnimator.continueAnimation(withTimingParameters:durationFactor:)` is unavailable. Use `FluidPropertyAnimator.resume(withTimingParameters:durationFactor:)` instead. */
    @available(*, unavailable)
    override func continueAnimation(withTimingParameters: UITimingCurveProvider?, durationFactor: CGFloat) {
        self.resume(timingParameters: withTimingParameters, durationFactor: durationFactor)
    }
}

/**
 Starting and Stopping the Animations
 */
public extension FluidPropertyAnimator {
    /** WARN: `UIViewPropertyAnimator.startAnimation()` is unavailable. Use `FluidPropertyAnimator.run()` instead. */
    @available(*, unavailable)
    override func startAnimation() {
        self.run()
    }

    /** WARN: `UIViewPropertyAnimator.startAnimation(delay:)` is unavailable. Use `FluidPropertyAnimator.run(delay:)` instead. */
    @available(*, unavailable)
    override func startAnimation(afterDelay delay: TimeInterval) {
        self.run(delay)
    }

    /** WARN: `UIViewPropertyAnimator.pauseAnimation()` is unavailable. Use `FluidPropertyAnimator.pause()` instead. */
    @available(*, unavailable)
    override func pauseAnimation() {
        self.pause()
    }

    /** WARN: `UIViewPropertyAnimator.stopAnimation(withoutFinishing:)` is unavailable. Use `FluidPropertyAnimator.stop(withoutFinishing:)` instead. */
    @available(*, unavailable)
    override func stopAnimation(_ withoutFinishing: Bool) {
        self.stop(withoutFinishing)
    }

    /** WARN: `UIViewPropertyAnimator.finishAnimation(finalPosition:)` is unavailable. Use `FluidPropertyAnimator.finish(finalPosition:)` instead. */
    @available(*, unavailable)
    override func finishAnimation(at finalPosition: UIViewAnimatingPosition) {
        self.finish(at: finalPosition)
    }
}
