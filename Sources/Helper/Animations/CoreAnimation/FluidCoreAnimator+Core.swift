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
 Modifying Animations
 */
extension FluidCoreAnimator {
    /**
     The function that adds `CABasicAnimation` or `CASpringAnimation` to the animation group.

     - parameter key: The `AnimatorKey` value.
     - parameter from: The start value for the animation.
     - parameter to: The end value for the animation.
     - parameter duration: The total duration of the animations, measured in seconds.
     - parameter beginTime: The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
     - parameter timeOffset: Additional offset in active local time.
     - parameter easing: The easing equation that returns a timing function defining the pacing of the animation.
     - parameter isRemovedOnCompletion: When true, the animation is removed from the render tree once its active duration has passed.
     - parameter fillMode: Defines how the timed object behaves outside its active duration. Local time may be clamped to either end of the active duration, or the element may be removed from the presentation. The legal values are `backwards', `forwards', `both' and `removed'.
     - parameter repeatCount: The repeat count of the object. May be fractional.
     - parameter repeatDuration: The repeat duration of the object.
     - parameter autoreverses: When true, the object plays backwards after playing forwards.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func add<T: FluidCoreAnimatorKeyCompatible>(key: FluidCoreAnimatorPath<T>,
                                                       from: T? = nil, to: T?,
                                                       duration: CFTimeInterval? = nil, beginTime: CFTimeInterval? = nil, timeOffset: CFTimeInterval? = nil,
                                                       easing: FluidAnimatorEasing? = nil,
                                                       isRemovedOnCompletion: Bool? = nil, fillMode: CAMediaTimingFillMode? = nil,
                                                       repeatCount: Float? = nil, repeatDuration: CFTimeInterval? = nil, autoreverses: Bool? = nil) -> Self {
        guard !isCompleted else { return self }
        guard let animation: CAAnimation = self.createAnimation(layer: self.layer, keyPath: key,
                                                                from: from, to: to,
                                                                duration: duration, beginTime: beginTime, timeOffset: timeOffset,
                                                                easing: easing,
                                                                isRemovedOnCompletion: isRemovedOnCompletion, fillMode: fillMode,
                                                                repeatCount: repeatCount, repeatDuration: repeatDuration, autoreverses: autoreverses) else { return self }
        self.animations.append(animation)
        return self
    }

    /**
     The function that adds `CATransition` to the animation group.

     - parameter startProgress: The amount of progress through to the transition at which to begin and end execution. Legal values are numbers in the range [0,1].
     - parameter endProgress: Must be greater than or equal to `startProgress'.
     - parameter type: The name of the transition. Current legal transition types include `fade', `moveIn', `push' and `reveal'. Defaults to `fade'.
     - parameter subtype: An optional subtype for the transition.
     - parameter duration: The total duration of the animations, measured in seconds.
     - parameter beginTime: The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
     - parameter timeOffset: Additional offset in active local time.
     - parameter easing: The easing equation that returns a timing function defining the pacing of the animation.
     - parameter isRemovedOnCompletion: When true, the animation is removed from the render tree once its active duration has passed.
     - parameter fillMode: Defines how the timed object behaves outside its active duration. Local time may be clamped to either end of the active duration, or the element may be removed from the presentation. The legal values are `backwards', `forwards', `both' and `removed'.
     - parameter repeatCount: The repeat count of the object. May be fractional.
     - parameter repeatDuration: The repeat duration of the object.
     - parameter autoreverses: When true, the object plays backwards after playing forwards.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func add(startProgress: Float, endProgress: Float, type: FluidCoreAnimatorTransitionType, subtype: FluidCoreAnimatorTransitionSubtype?,
                    duration: CFTimeInterval? = nil, beginTime: CFTimeInterval? = nil, timeOffset: CFTimeInterval? = nil,
                    easing: FluidAnimatorEasing? = nil,
                    isRemovedOnCompletion: Bool? = nil, fillMode: CAMediaTimingFillMode? = nil,
                    repeatCount: Float? = nil, repeatDuration: CFTimeInterval? = nil, autoreverses: Bool? = nil) -> Self {
        guard !isCompleted else { return self }
        /* NOTE: Add to animation group */
        let animation: CATransition = self.createTransition(startProgress: startProgress, endProgress: endProgress, type: type, subtype: subtype,
                                                            duration: duration, beginTime: beginTime, timeOffset: timeOffset,
                                                            easing: easing,
                                                            isRemovedOnCompletion: isRemovedOnCompletion, fillMode: fillMode,
                                                            repeatCount: repeatCount, repeatDuration: repeatDuration, autoreverses: autoreverses)
        self.animations.append(animation)
        return self
    }
}

/**
 Callback blocks
 */
extension FluidCoreAnimator {
    /**
     The function that adds a callback function invoked when the progress value changes.

     - parameter progress: The `ProgressBlock` function.
     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func on(_ progress: ProgressBlock? = nil) -> Self {
        self.progressBlock = progress
        return self
    }

    /**
     The function that adds a callback function invoked when the state value changes.

     - parameter progress: The `StateBlock` function.
     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func on(_ state: StateBlock? = nil) -> Self {
        self.stateBlock = state
        return self
    }
}

/**
 Starting and Stopping the Animations
 */
extension FluidCoreAnimator {
    /**
     The function that starts the animation.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func run() -> Self {
        /* NOTE: Validate */
        guard self.isReady else { return self }
        guard let layer: CALayer = (((try? FluidCoreAnimatorValidator.validate(layer: self.layer, id: self.groupAnimationId)) as CALayer??)) ?? nil else {
            self._animatorState = .failed
            return self
        }
        /* NOTE: Setup group animation */
        self.group.animations = self.animations
        self.group.delegate = self
        /* NOTE: Run group animation */
        layer.add(self.group, forKey: self.groupAnimationId)
        /* NOTE: Setup progress animation */
        if self.progressBlock != nil {
        }
        let progressLayer: CAProgressLayer = CAProgressLayer(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        progressLayer.delegate = self
        self.layer?.addSublayer(progressLayer)
        self.progressAnimation = self.createProgressAnimation(duration: self.duration, easing: .linear,
                                                              isRemovedOnCompletion: self.isRemovedOnCompletion, fillMode: self.fillMode,
                                                              repeatCount: self.repeatCount, repeatDuration: self.repeatDuration, autoreverses: self.autoreverses)
        /* NOTE: Run progress animation */
        progressLayer.add(self.progressAnimation, forKey: self.progressAnimationId)
        self.progressLayer = progressLayer
        return self
    }

    /**
     The function that pauses the animation.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func pause() -> Self {
        /* NOTE: Validate */
        guard self.isRunning else { return self }
        guard let layer: CALayer = (((try? FluidCoreAnimatorValidator.validate(layer: layer, id: self.groupAnimationId)) as CALayer??)) ?? nil else {
            self._animatorState = .failed
            return self
        }
        /* NOTE: Pause */
        self.pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = self.pausedTime
        /* NOTE: Notify */
        self._animatorState = .paused
        return self
    }

    @discardableResult
    public func update(progress: CGFloat) -> Self {
        guard self.isPaused else { return self }
        self.layer?.timeOffset = self.startTime + self.duration * CFTimeInterval(progress)
        return self
    }

    /**
     The function that resume the animation.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func resume(reverse: Bool, progress: CGFloat?, resetSpeedAfterFinish: Bool = false) -> Self {
        /* NOTE: Validate */
        guard self.isPaused else { return self }
        guard let layer: CALayer = (((try? FluidCoreAnimatorValidator.validate(layer: layer, id: self.groupAnimationId)) as CALayer??)) ?? nil else {
            self._animatorState = .failed
            return self
        }
        if reverse {
            layer.speed = -1.0
            layer.beginTime = CACurrentMediaTime()
            /* FIXME: Animation finishes before progress reaches to zero */
            if resetSpeedAfterFinish {
                let progress: CFTimeInterval = CFTimeInterval(progress ?? self.animatorProgress)
                let delay: TimeInterval = (1.0 - progress) * self.duration + 0.05
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    layer.speed = 1.0
                })
            }
        } else {
            let pausedTime: CFTimeInterval = layer.timeOffset
            layer.speed = 1.0
            layer.timeOffset = 0.0
            layer.beginTime = 0.0
            let timeSincePause: CFTimeInterval = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
            layer.beginTime = timeSincePause
        }
        /* NOTE: Notify */
        self._animatorState = .running
        return self
    }

    /**
     The function that cancels the animation.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func cancel() -> Self {
        /* NOTE: Validate */
        guard !self.isCompleted else { return self }
        guard let layer: CALayer = (((try? FluidCoreAnimatorValidator.validate(layer: layer, id: self.groupAnimationId)) as CALayer??)) ?? nil else {
            self._animatorState = .failed
            return self
        }
        /* NOTE: Cancel animations */
        layer.removeAnimation(forKey: self.groupAnimationId)
        self.progressLayer?.removeAnimation(forKey: self.progressAnimationId)
        /* NOTE: Notify */
        self._animatorState = .cancelled
        return self
    }

    /**
     The function that invalidates the animation.

     - returns: The `FluidCoreAnimator` object.
     */
    @discardableResult
    public func invalidate() -> Self {
//        Logger()?.log("🐆🗑🗑🗑", ["identifier:".lpad() + String(describing: self.identifier)])
        /* NOTE: Blocks */
        self.stateBlock = nil
        self.progressBlock = nil
        /* NOTE: Group */
        self.layer?.removeAnimation(forKey: self.groupAnimationId)
        self.layer = nil
        self.group?.delegate = nil
        self.group?.animations?.removeAll()
        self.group = nil
        self.animations?.removeAll()
        self.animations = nil
        /* NOTE: Progress*/
        self.progressLayer?.removeAnimation(forKey: self.progressAnimationId)
        self.progressLayer?.removeFromSuperlayer()
        self.progressLayer?.delegate = nil
        self.progressLayer = nil
        self.progressAnimation = nil
        return self
    }
}

/**
 CAAnimationDelegate
 */
extension FluidCoreAnimator: CAAnimationDelegate {
    public func animationDidStart(_ anim: CAAnimation) {
        guard anim !== self.progressAnimation else { return }
        if self._animatorState == .ready, let layer: CALayer = self.layer {
            self.startTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        }
        self._animatorState = .running
//        Logger()?.log("🐆💥", [
//            "groupAnimationId:".lpad() + String(describing: self.groupAnimationId),
//            "animatorState:".lpad() + String(describing: self.animatorState),
//            "animatorProgress:".lpad() + String(describing: CGFloat(animatorProgress).decimal()),
//        ])
    }

    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        guard anim !== self.progressAnimation else { return }
        if 0 < self._animatorProgress && self._animatorProgress < 0.02 {
            self._animatorProgress = 0
        } else if 0.98 < self._animatorProgress && self._animatorProgress < 1 {
            self._animatorProgress = 1
        }
//        Logger()?.log("🐆💥", [
//            "groupAnimationId:".lpad() + String(describing: self.groupAnimationId),
//            "animatorState:".lpad() + String(describing: self.animatorState),
//            "animatorProgress:".lpad() + String(describing: CGFloat(animatorProgress).decimal()),
//        ])
        self._animatorState = .finished
    }
}

/**
 CAProgressLayerDelegate
 */
extension FluidCoreAnimator: CAProgressLayerDelegate {
    func progressDidChange(to progress: CGFloat) {
        self._animatorProgress = progress
//        Logger()?.log("🐆💥", [
//            "groupAnimationId:".lpad() + String(describing: self.groupAnimationId),
//            "animatorState:".lpad() + String(describing: self.animatorState),
//            "animatorProgress:".lpad() + String(describing: CGFloat(animatorProgress).decimal()),
//        ])
    }
}
