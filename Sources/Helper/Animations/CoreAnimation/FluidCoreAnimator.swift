//
//  FluidCoreAnimator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The chainable animator for Core Animation
 */
public class FluidCoreAnimator: NSObject, FluidAnimatorCompatible {
    /** The constant parameters. */
    internal struct Const {
        static let animationIdKey: String = "com.gumob.Fluidable.FluidCoreAnimator"
    }

    /** The unique identifier provided for each an animation group. */
    public var identifier: String { return self.groupAnimationId }
    public internal(set) var groupAnimationId: String = ""
    public internal(set) var progressAnimationId: String = ""

    /** The `Boolean` value whether to suppress log message. */
    public var suppressLogger: Bool = false {
        didSet { FluidCoreAnimatorLogger.suppress = self.suppressLogger }
    }

    /** The `CGFloat` value that indicates the current animation progress. */
    public var animatorProgress: CGFloat { return self._animatorProgress }
    internal var _animatorProgress: CGFloat = 0 {
        didSet {
            guard self._animatorProgress != oldValue else { return }
            guard self._animatorState != .ready else { return }
            self.progressBlock?(self._animatorProgress)
        }
    }
    /** The state of the current animation. */
    public var animatorState: FluidAnimatorState { return self._animatorState }
    internal var _animatorState: FluidAnimatorState = .ready {
        didSet {
            guard self._animatorState != oldValue else { return }
            self.stateBlock?(self._animatorState, self._animatorProgress)
        }
    }
    /** The `Boolean` value that indicates the current animation is ready. */
    public var isReady: Bool { return self._animatorState == .ready }
    /** The `Boolean` value that indicates the current animation is running. */
    public var isRunning: Bool { return self._animatorState == .running }
    /** The `Boolean` value that indicates the current animation is paused. */
    public var isPaused: Bool { return self._animatorState == .paused }
    /** The `Boolean` value that indicates the current animation is cancelled. */
    public var isCancelled: Bool { return self._animatorState == .cancelled }
    /** The `Boolean` value that indicates the current animation is failed. */
    public var isFailed: Bool { return self._animatorState == .failed }
    /** The `Boolean` value that indicates the current animation is finished. */
    public var isFinished: Bool { return self._animatorState == .finished }
    /** The `Boolean` value that indicates the current animation is completed. */
    public var isCompleted: Bool { return self.isCancelled || self.isFailed || self.isFinished }

    /** The `CAAnimationGroup` object. */
    public internal(set) var group: CAAnimationGroup! = CAAnimationGroup()
    /** The animation group. */
    public internal(set) var animations: [CAAnimation]! = [CAAnimation]()
    /** The animation count stored in the queue. */
    public var animationCount: Int { return self.animations.count }

    /** The reference to `CALayer` to be animated. */
    public internal(set) weak var layer: CALayer?
    /** The reference to `CAProgressLayer` to observe the animation progress. */
    internal weak var progressLayer: CAProgressLayer?
    /** The reference to `CAProgressLayer` to observe the animation progress. */
    internal var progressAnimation: CAAnimation!

    /** The total duration of the animations, measured in seconds. */
    public var duration: CFTimeInterval {
        set { self.group.duration = newValue }
        get { return self.group.duration }
    }
    /** The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately. */
    public var beginTime: CFTimeInterval {
        set { self.group.beginTime = newValue }
        get { return self.group.beginTime }
    }
    /** Additional offset in active local time. */
    public var timeOffset: CFTimeInterval {
        set { self.group.timeOffset = newValue }
        get { return self.group.timeOffset }
    }
    /** The easing equation that returns a timing function defining the pacing of the animation. */
    public var easing: FluidAnimatorEasing? {
        didSet {
            guard let easing: FluidAnimatorEasing = self.easing else { return }
            self.group.timingFunction = easing.timingFunction
        }
    }
    /** Defines how the timed object behaves outside its active duration. Local time may be clamped to either end of the active duration, or the element may be removed from the presentation. The legal values are `backwards', `forwards', `both' and `removed'. */
    public var fillMode: CAMediaTimingFillMode {
        set { self.group.fillMode = newValue }
        get { return self.group.fillMode }
    }
    /** The repeat count of the object. May be fractional. */
    public var repeatCount: Float {
        set { self.group.repeatCount = newValue }
        get { return self.group.repeatCount }
    }
    /** The repeat duration of the object. */
    public var repeatDuration: CFTimeInterval {
        set { self.group.repeatDuration = newValue }
        get { return self.group.repeatDuration }
    }
    /** When true, the object plays backwards after playing forwards. */
    public var autoreverses: Bool {
        set { self.group.autoreverses = newValue }
        get { return self.group.autoreverses }
    }
    /** When true, the animation is removed from the render tree once its active duration has passed. */
    public var isRemovedOnCompletion: Bool {
        set { self.group.isRemovedOnCompletion = newValue }
        get { return self.group.isRemovedOnCompletion }
    }

    internal var startTime: CFTimeInterval = 0
    internal var pausedTime: CFTimeInterval = 0

    /** A block object to be executed when the animation progress is changed. */
    public var progressBlock: ProgressBlock?
    /** A block object to be executed when the animation state is changed. */
    public var stateBlock: StateBlock?

    override init() { super.init() }
    deinit { Logger()?.log("🐆🧹🧹🧹", ["id: \(self.groupAnimationId)"]) }
}

extension FluidCoreAnimator {
    override public var description: String {
        return "FluidCoreAnimator(id: \(self.identifier), state: \(self.animatorState))"
    }
}
