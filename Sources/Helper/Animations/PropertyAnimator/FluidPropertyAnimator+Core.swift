//
//  FluidPropertyAnimator+Core.swift
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
public extension FluidPropertyAnimator {
    /**
     The chainable function that adds the animation block.

     - parameter animation: The animation block.
     - parameter lazy: If set this value to true, animation blocks will be added to the animation queue just before the animation starts.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func add(_ animation: @escaping AnimationBlock, lazy: Bool = false) -> FluidPropertyAnimator {
        if lazy {
            switch self.stateEx {
            case .active, .stopped: super.addAnimations(animation)
            case .inactive, .none:  self.animations?.append(AnimationData(animation))
            }
        } else {
            super.addAnimations(animation)
        }
        return self
    }

    /**
     The chainable function that adds the animation block with the delay factor.

     - parameter animation: The animation block.
     - parameter delayFactor: The factor to use for delaying the start of the animations. Please read (the official documentation)[https://developer.apple.com/documentation/uikit/uiviewpropertyanimator/1648370-addanimations] for more information.
     - parameter lazy: If set this value to true, animation blocks will be added to the animation queue just before the animation starts.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func add(_ animation: @escaping AnimationBlock, delayFactor: CGFloat, lazy: Bool = false) -> FluidPropertyAnimator {
        if lazy {
            switch self.stateEx {
            case .active, .stopped: super.addAnimations(animation, delayFactor: delayFactor)
            case .inactive, .none:  self.animations?.append(AnimationData(animation, delayFactor: delayFactor))
            }
        } else {
            super.addAnimations(animation, delayFactor: delayFactor)
        }
        return self
    }
}

/**
 Callback blocks
 */
public extension FluidPropertyAnimator {
    /**
     The chainable function that adds a callback block invoked when the animation progress changes.

     - parameter progression: The progression block.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func on(_ block: ProgressBlock?) -> FluidPropertyAnimator {
        self.progressBlock = block
        return self
    }

    /**
     The chainable function that adds a callback block invoked when the animation state changes.

     - parameter completion: The completion block.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func on(_ block: StateBlock?) -> FluidPropertyAnimator {
        self.stateBlock = block
        return self
    }
}

/**
 Starting and Stopping the Animations
 */
public extension FluidPropertyAnimator {
    /**
     The function that runs the animation.

     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func run() -> Self {
        guard self.animatorState == .ready else { return self }
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "duration:".lpad() + String(describing: self.duration),
        ])
        self.animations?.forEach {
            if let delayFactor: CGFloat = $0.delayFactor {
                super.addAnimations($0.animationBlock, delayFactor: delayFactor)
            } else {
                super.addAnimations($0.animationBlock)
            }
        }
        self.startTimer()
        super.startAnimation()
        self._animatorState = .running
        return self
    }

    /**
     The function that runs the animation.

     - parameter delay: The animation delay in seconds.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func run(_ delay: TimeInterval) -> Self {
        guard self.animatorState == .ready else { return self }
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "duration:".lpad() + String(describing: self.duration),
            "delay:".lpad() + String(describing: self.delay),
        ])
        self.animations?.forEach {
            if let delayFactor: CGFloat = $0.delayFactor {
                super.addAnimations($0.animationBlock, delayFactor: delayFactor)
            } else {
                super.addAnimations($0.animationBlock)
            }
        }
        self.startTimer()
        super.startAnimation(afterDelay: delay)
        self._animatorState = .running
        return self
    }

    /**
     The function that pauses the animation.

     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func pause() -> Self {
        guard self.animatorState == .running else { return self }
        self.stopTimer()
        super.pauseAnimation()
        self._animatorState = .paused
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete.decimal()),
        ])
        return self
    }

    /**
     The function that update the animation.

     - parameter fractionComplete: The `fractionComplete` value to be changed to.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func update(fractionComplete: CGFloat) -> Self {
        guard self.animatorState == .paused else { return self }
        self.fractionComplete = fractionComplete
//        Logger()?.log("🐅⏩", [
//            "identifier:".lpad() + String(describing: self.identifier),
//            "fractionComplete:".lpad() + String(debug: self.fractionComplete.decimal()),
//        ])
        return self
    }

    /**
     The function that continues and adjusts the timing and duration of a paused animation.

     - parameter easing: The new easing to apply to the animation.
     - parameter durationFactor: A multiplying factor to apply to the animation’s original duration.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func resume(easing: FluidAnimatorEasing? = nil, durationFactor: CGFloat? = nil) -> Self {
        return self.resume(timingParameters: easing?.timingParameters, durationFactor: durationFactor)
    }

    /**
     The function that continues and adjusts the timing and duration of a paused animation.

     - parameter timingParameters: The new timing information to apply to the animation.
     - parameter durationFactor: A multiplying factor to apply to the animation’s original duration.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func resume(timingParameters: UITimingCurveProvider? = nil, durationFactor: CGFloat? = nil) -> Self {
        guard self.animatorState == .paused else { return self }
        self.startTimer()
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "durationFactor:".lpad() + String(debug: durationFactor?.decimal()),
        ])
        super.continueAnimation(withTimingParameters: timingParameters, durationFactor: durationFactor ?? self.fractionComplete)
        self._animatorState = .running
        return self
    }

    /**
     The function that continues and adjusts the timing and duration of a paused animation.

     - parameter timingParameters: The new timing information to apply to the animation.
     - parameter durationFactor: A multiplying factor to apply to the animation’s original duration.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func stop(_ withoutFinishing: Bool) -> Self {
        guard self.animatorState == .ready || self.animatorState == .running || self.animatorState == .paused else { return self }
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
//            "isRunning:".lpad() + String(describing: self.isRunning),
//            "stateEx:".lpad() + String(describing: self.stateEx),
//            "animatorState:".lpad() + String(describing: self.animatorState),
        ])
        self.stopTimer()
        super.stopAnimation(withoutFinishing)
        self._animatorState = .cancelled
        return self
    }

    /**
     The function that finishes the animations and returns the animator to the inactive state.

     - parameter finalPosition: The final position for any view properties. Specify `UIViewAnimatingPosition.current` to leave the view properties unchanged from their current values.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func finish(at finalPosition: UIViewAnimatingPosition) -> Self {
        defer { self.stopTimer() }
        guard self.state == .active else { return self }
        /* NOTE: Stop the animation before finishing */
        self.stop(false)
        /* NOTE: Finish the animation */
        Logger()?.log("🐅⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
//            "isRunning:".lpad() + String(describing: self.isRunning),
//            "stateEx:".lpad() + String(describing: self.stateEx),
//            "animatorState:".lpad() + String(describing: self.animatorState),
        ])
        super.finishAnimation(at: finalPosition)
        self._animatorState = .finished
        return self
    }

    /**
     The function that invalidates the animation.
     */
    @discardableResult
    func invalidate() -> Self {
        Logger()?.log("🐅🗑🗑🗑", [
            "identifier:".lpad() + String(describing: self.identifier),
//            "isRunning:".lpad() + String(describing: self.isRunning),
//            "stateEx:".lpad() + String(describing: self.stateEx),
//            "animatorState:".lpad() + String(describing: self.animatorState),
        ])
        self.finish(at: .current)
        self.animations?.removeAll()
        self.animations = nil
        return self
    }
}

/**
 Configuring the animation
 */
public extension FluidPropertyAnimator {
    /**
     The chainable function that set the `fractionComplete` value.

     - parameter value: The `fractionComplete` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func fractionComplete(_ value: CGFloat) -> FluidPropertyAnimator {
        self.fractionComplete = value
        return self
    }

    /**
     The chainable function that set the `isReversed` value.

     - parameter value: The `isReversed` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func isReversed(_ value: Bool) -> FluidPropertyAnimator {
        self.isReversed = value
        return self
    }

    /**
     The chainable function that set the `isInterruptible` value.

     - parameter value: The `isInterruptible` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func isInterruptible(_ value: Bool) -> FluidPropertyAnimator {
        self.isInterruptible = value
        return self
    }

    /**
     The chainable function that set the `isUserInteractionEnabled` value.

     - parameter value: The `isUserInteractionEnabled` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func isUserInteractionEnabled(_ value: Bool) -> FluidPropertyAnimator {
        self.isUserInteractionEnabled = value
        return self
    }

    /**
     The chainable function that set the `isManualHitTestingEnabled` value.

     - parameter value: The `isManualHitTestingEnabled` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func isManualHitTestingEnabled(_ value: Bool) -> FluidPropertyAnimator {
        self.isManualHitTestingEnabled = value
        return self
    }

    /**
     The chainable function that set the `scrubsLinearly` value.

     - parameter value: The `scrubsLinearly` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @available(iOS 11.0, *)
    @discardableResult
    func scrubsLinearly(_ value: Bool) -> FluidPropertyAnimator {
        self.scrubsLinearly = value
        return self
    }

    /**
     The chainable function that set the `pausesOnCompletion` value.

     - parameter value: The `pausesOnCompletion` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @available(iOS 11.0, *)
    @discardableResult
    func pausesOnCompletion(_ value: Bool) -> FluidPropertyAnimator {
        self.pausesOnCompletion = value
        return self
    }

    /**
     The chainable function that set the animation properties.

     - parameter isInterruptible: The `isInterruptible` value.
     - parameter isUserInteractionEnabled: The `isUserInteractionEnabled` value.
     - parameter isManualHitTestingEnabled: The `isManualHitTestingEnabled` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @discardableResult
    func configure(isInterruptible: Bool? = nil, isUserInteractionEnabled: Bool? = nil, isManualHitTestingEnabled: Bool? = nil) -> FluidPropertyAnimator {
        self.isInterruptible = isInterruptible ?? self.isInterruptible
        self.isUserInteractionEnabled = isUserInteractionEnabled ?? self.isUserInteractionEnabled
        self.isManualHitTestingEnabled = isManualHitTestingEnabled ?? self.isManualHitTestingEnabled
        return self
    }

    /**
     The chainable function that set the animation properties that is available on iOS 11 or later.

     - parameter scrubsLinearly: The `scrubsLinearly` value.
     - parameter pausesOnCompletion: The `pausesOnCompletion` value.
     - returns: The `FluidPropertyAnimator` object.
     */
    @available(iOS 11.0, *)
    @discardableResult
    func configure(scrubsLinearly: Bool? = nil, pausesOnCompletion: Bool? = nil) -> FluidPropertyAnimator {
        self.scrubsLinearly = scrubsLinearly ?? self.scrubsLinearly
        self.pausesOnCompletion = pausesOnCompletion ?? self.pausesOnCompletion
        return self
    }
}
