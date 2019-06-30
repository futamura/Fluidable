//
//  FluidViewAnimatorCompatible+Core.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/* FIXME: The animation framerate is low on some old devices. Optimize animations. */

/**
 Control animation
 */
extension FluidViewAnimatorCompatible {
    /**
     The function that starts animations.

     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    internal func run() -> Self {
        guard self.state == .ready else { return self }
        Logger()?.log("🕊⏩", ["state:".lpad() + String(debug: self.state)])
        self.framePropertyAnimators?.forEach { $0.run() }
        self.frameCoreAnimators?.forEach { $0.run() }
        self.extraPropertyAnimators?.forEach { $0.run() }
        self.extraCoreAnimators?.forEach { $0.run() }
        self.backgroundAnimator?.run()
        self.progressAnimator?.run()
        return self
    }

    /**
     The function that invalidates animations.

     - parameter willRemoveContainer: The `Bool` value that indicates whether the animation should proceeds reversed direction.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    internal func invalidate(willRemoveContainer: Bool) -> Self {
        guard self.parameters != nil else { return self }
        /* NOTE: Propagate delegate */
        self.animationWillInvalidate(willRemoveContainer: willRemoveContainer)
        Logger()?.log("🕊🗑🗑🗑", ["willRemoveContainer:".lpad() + String(describing: willRemoveContainer)])
        /* NOTE: Animation */
        self.shadowView?.layer.removeAllAnimations()
        (self.backgroundView as? UIView)?.layer.removeAllAnimations()
        /* NOTE: View */
        self.interruptibleView?.removeFromSuperview()
        self.progressView?.removeFromSuperview()
        if willRemoveContainer {
            (self.backgroundView as? UIView)?.removeFromSuperview()
            self.shadowView?.removeFromSuperview()
        }
        /* NOTE: Parameters */
        self.pausedGestureInfo = nil
        self.currentGestureInfo = nil
        self.storedFromFrame = nil
        self.storedToFrame = nil
        self.storedFromStyle = nil
        self.storedToStyle = nil
        self.parameters?.invalidateAllAnimations()
        self.parameters = nil
        /* NOTE: Obj-C Associated Object */
        if willRemoveContainer {
            AssociatedObject.remove(self)
        }
        return self
    }
}

/**
 Handle animation
 */
extension FluidViewAnimatorCompatible {
    /**
     The function that pauses animations.

     - returns: The `FluidViewAnimatorCompatible` object.
     */
    internal func pauseAnimation(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🕊⏩", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "state:".lpad() + String(describing: self.state),
//            "progress:".lpad() + String(describing: progress.decimal()),
//            "position:".lpad() + String(describing: position.decimal()),
//        ])
        /* NOTE: Pause interactive transition */
        guard self.state == .running else { return }
        self.pausedAnimationProgress = progress
        self.framePropertyAnimators?.forEach { $0.pause() } /* NOTE: Pause property animation */
        self.frameCoreAnimators?.forEach { $0.pause() }     /* NOTE: Pause core animation */
        self.extraPropertyAnimators?.forEach { $0.pause() } /* NOTE: Pause property animation */
        self.extraCoreAnimators?.forEach { $0.pause() }     /* NOTE: Pause core animation */
        self.backgroundAnimator?.pause()                    /* NOTE: Pause background animation */
        self.progressAnimator?.pause()                      /* NOTE: Pause progress animation */
        self.interactionDidStart(progress: progress, position: position, info: info)      /* NOTE: Propagate delegate */
    }

    /**
     The function that updates animations progress.

     - parameter progress: The progress value of the animation.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    internal func updateAnimation(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        /* NOTE: Update interactive transition */
        guard self.state == .paused else { return }
//        Logger()?.log("🕊⏩", [
//            "progress:".lpad() + String(describing: progress.decimal()),
//            "position:".lpad() + String(describing: position.decimal()),
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "state:".lpad() + String(describing: self.state),
//        ])
        /* NOTE: Update property animation */
        self.framePropertyAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.delay)
            $0.update(fractionComplete: convertedProgress)
        }
        /* NOTE: Update core animation */
        self.frameCoreAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.beginTime)
            $0.update(progress: convertedProgress) /* FIXME: Fix progress */
        }
        /* NOTE: Update property animation */
        self.extraPropertyAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.delay)
            $0.update(fractionComplete: convertedProgress)
        }
        /* NOTE: Update core animation */
        self.extraCoreAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.beginTime)
            $0.update(progress: convertedProgress) /* FIXME: Fix progress */
        }
        /* NOTE: Update background animation */
        if let animator: FluidPropertyAnimator = self.backgroundAnimator {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: animator.duration,
                                                                  animatorDelay: animator.delay)
            animator.update(fractionComplete: convertedProgress)
        }
        /* NOTE: Update progress animation */
        self.progressAnimator?.update(progress: progress)
        /* NOTE: Propagate delegate */
        self.interactionDidUpdate(progress: progress, position: position, info: info)
    }

    /**
     The function that resumes animations.

     - parameter isReversed: The `Bool` value that indicates whether the animation should proceeds reversed direction.
     - parameter progress: The progress value that the animation resumes at.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    internal func finishAnimation(isReversed: Bool, progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        /* NOTE: Resume interactive transition */
        guard self.state == .paused else { return }
        Logger()?.log("🕊⏩", [
            "isReversed:".lpad() + String(describing: isReversed),
            "progress:".lpad() + String(describing: progress.decimal()),
            "position:".lpad() + String(describing: position.decimal()),
            "animationType:".lpad() + String(describing: self.animationType),
            "interactionType:".lpad() + String(debug: interactionType),
            "state:".lpad() + String(describing: self.state),
        ])
        /* NOTE: Resume property animation */
        self.framePropertyAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.delay)
            $0.isReversed(isReversed).resume(easing: nil, durationFactor: convertedProgress)
        }
        /* NOTE: Resume core animation */
        self.frameCoreAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.timeOffset)
            $0.resume(reverse: isReversed, progress: convertedProgress)
        }
        /* NOTE: Resume property animation */
        self.extraPropertyAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.delay)
            $0.isReversed(isReversed).resume(easing: nil, durationFactor: convertedProgress)
        }
        /* NOTE: Resume core animation */
        self.extraCoreAnimators?.forEach {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: $0.duration,
                                                                  animatorDelay: $0.timeOffset)
            $0.resume(reverse: isReversed, progress: convertedProgress)
        }
        /* NOTE: Resume background animation */
        if let animator: FluidPropertyAnimator = self.backgroundAnimator {
            let convertedProgress: CGFloat = self.convertProgress(transitionProgress: progress,
                                                                  transitionDuration: self.activeDuration,
                                                                  animatorDuration: animator.duration,
                                                                  animatorDelay: animator.delay)
            animator.isReversed(isReversed).resume(easing: nil, durationFactor: convertedProgress)
        }
        /* NOTE: Resume progress animation */
        self.progressAnimator?.resume(reverse: isReversed, progress: progress)
        /* NOTE: Propagate delegate */
        self.interactionDidFinish(isReversed: isReversed, progress: progress, position: position, info: info)
    }
}

/**
 Handle interaction
 */
extension FluidViewAnimatorCompatible {
    /**
     The function that begins interactive transition.

     - parameter progress: The progress value of the interactive transition.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    internal func beginInteraction(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🕊💥", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "progress:".lpad() + String(debug: progress),
//            "position:".lpad() + String(debug: position),
//        ])
        /* NOTE: Update info */
        self.interactionProgress = progress
        self.pausedInteractionProgress = progress
        self.resizePosition = position
        self.pausedGestureInfo = info
        self.currentGestureInfo = info
        self.interactionDidStart(progress: progress, position: position, info: info)
    }

    /**
     The function that updates interactive transition.

     - parameter progress: The progress value of the interactive transition.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    internal func updateInteraction(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🕊💥", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "progress:".lpad() + String(debug: progress),
//            "position:".lpad() + String(debug: position),
//        ])
        /* NOTE: Update info */
        self.interactionProgress = progress
        self.currentGestureInfo = info
        self.resizePosition = position
        self.interactionDidUpdate(progress: progress, position: position, info: info)
    }

    /**
     The function that finishes interactive transition.

     - parameter isReversed: The `Bool` value that indicates whether the animation should proceeds reversed direction.
     - parameter progress: The progress value of the interactive transition.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    internal func finishInteraction(isReversed: Bool, progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🕊💥", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: self.interactionType),
//            "isReversed:".lpad() + String(debug: isReversed),
//            "progress:".lpad() + String(debug: progress),
//            "position:".lpad() + String(debug: position),
//        ])
        /* NOTE: Stop timer */
        self.animationTimer?.stop()
        self.animationTimer = nil
        /* NOTE: Update info */
        self.interactionProgress = progress
        self.currentGestureInfo = info
        switch self.animationType {
        case .present: self.resizePosition = position
        case .dismiss, .rotate: self.resizePosition = self.snapPositionsForResizing.nearest(to: position)?.element ?? 0
        }
        self.interactionDidFinish(isReversed: isReversed, progress: progress, position: position, info: info)
    }
}
