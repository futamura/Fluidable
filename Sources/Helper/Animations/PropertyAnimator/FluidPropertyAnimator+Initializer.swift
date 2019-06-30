//
//  FluidPropertyAnimator+Initializer.swift
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
    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter easing: The `FluidPropertyAnimatorEasing` value that indicates timing curve.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, easing: FluidAnimatorEasing, id: String? = nil) {
        self.init(duration: duration, timingParameters: easing.timingParameters, id: id)
    }

    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter timingParameters: The object providing the timing information. This object must adopt the (`UITimingCurveProvider`)[https://developer.apple.com/documentation/uikit/uitimingcurveprovider] protocol.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, timingParameters: UITimingCurveProvider, id: String? = nil) {
        self.init(duration: duration, timingParameters: timingParameters)
        self.setIdentifier(id)
        if #available(iOS 11.0, *) { self.scrubsLinearly(false) }
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in self?.positionDidChange(position: position) })
    }

    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter curve: The UIKit timing curve to apply to the animation.
     - parameter animations: The block containing the animations.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, curve: UIView.AnimationCurve, id: String? = nil, animations: AnimationBlock? = nil) {
        self.init(duration: duration, curve: curve)
        self.setIdentifier(id)
        if #available(iOS 11.0, *) { self.scrubsLinearly(false) }
        if let animations: AnimationBlock = animations { self.animations?.append(AnimationData(animations)) }
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in self?.positionDidChange(position: position) })
    }

    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter point1: The first control point for the cubic bezier timing curve.
     - parameter point2: The second control point for the cubic bezier timing curve.
     - parameter animations: The block containing the animations.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, controlPoint1: CGPoint, controlPoint2: CGPoint, id: String? = nil, animations: AnimationBlock? = nil) {
        self.init(duration: duration, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
        self.setIdentifier(id)
        if #available(iOS 11.0, *) { self.scrubsLinearly(false) }
        if let animations: AnimationBlock = animations { self.animations?.append(AnimationData(animations)) }
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in self?.positionDidChange(position: position) })
    }

    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter c1x: The x value of first control point for the cubic bezier timing curve.
     - parameter c1y: The y value of first control point for the cubic bezier timing curve.
     - parameter c2x: The x value of second control point for the cubic bezier timing curve.
     - parameter c2y: The y value of second control point for the cubic bezier timing curve.
     - parameter animations: The block containing the animations.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, c1x: CGFloat, c1y: CGFloat, c2x: CGFloat, c2y: CGFloat, id: String? = nil, animations: AnimationBlock? = nil) {
        self.init(duration: duration, controlPoint1: CGPoint(x: c1y, y: c1y), controlPoint2: CGPoint(x: c2x, y: c2y))
    }

    /**
     The function that instantiates a `FluidPropertyAnimator` object.

     - parameter duration: The `TimeInterval` value for the animation.
     - parameter dampingRatio: The damping ratio to apply to the initial acceleration and oscillation.
     - parameter animations: The block containing the animations.
     - parameter id: The identifier.
     */
    convenience init(duration: TimeInterval, dampingRatio: CGFloat, id: String? = nil, animations: AnimationBlock? = nil) {
        self.init(duration: duration, dampingRatio: dampingRatio)
        self.setIdentifier(id)
        if #available(iOS 11.0, *) { self.scrubsLinearly(false) }
        if let animations: AnimationBlock = animations { self.animations?.append(AnimationData(animations)) }
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in self?.positionDidChange(position: position) })
    }
}

extension FluidPropertyAnimator {
    internal class func convert(_ animators: [FluidPropertyAnimator]?, duration: TimeInterval, easing: FluidAnimatorEasing, id: String) -> FluidInterruptibleAnimator {
        let animator: FluidInterruptibleAnimator = FluidInterruptibleAnimator(duration: duration, timingParameters: easing.timingParameters, id: id)
        guard let animators: [FluidPropertyAnimator] = animators else { return animator }
        let dataSet: [AnimationData]? = animators.filter { $0.animations != nil && $0.animations!.count > 0 }
                                                 .map { $0.animations! }.reduce([], +)
        dataSet?.forEach {
            if let delayFactor: CGFloat = $0.delayFactor {
                animator.addAnimations($0.animationBlock, delayFactor: delayFactor)
            } else {
                animator.addAnimations($0.animationBlock)
            }
        }
        return animator
    }

    internal class func merge(_ animators: [FluidPropertyAnimator]?, duration: TimeInterval, easing: FluidAnimatorEasing) -> FluidPropertyAnimator {
        let animator: FluidPropertyAnimator = FluidPropertyAnimator(duration: duration, timingParameters: easing.timingParameters, id: "interruptible")
        guard let animators: [FluidPropertyAnimator] = animators else { return animator }
        let dataSet: [AnimationData]? = animators.filter { $0.animations != nil && $0.animations!.count > 0 }
                                                 .map { $0.animations! }.reduce([], +)
        dataSet?.forEach {
            if let delayFactor: CGFloat = $0.delayFactor {
                animator.add($0.animationBlock, delayFactor: delayFactor, lazy: false)
            } else {
                animator.add($0.animationBlock, lazy: false)
            }
        }
        return animator
    }
}

extension FluidPropertyAnimator {
    private func setIdentifier(_ id: String?) {
        self.identifier = id ?? "\(Const.animationIdKey).\(UUID().uuidString)"
    }
}
