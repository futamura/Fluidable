//
//  FluidPresentDriverCompatible+Interactive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Presentation - `FluidPresentTransitionDelegate`
 */
extension FluidPresentDriverCompatible {
    /**
     Interactive dismiss transition using `UIPercentDrivenInteractiveTransition`
     */
    func beginInteractiveTransition(progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐷🎬", [
            "progress:".lpad() + String(describing: progress.decimal()),
        ])
        /* NOTE: Pause animation */
        self.pauseInteraction()
        self.viewAnimator.pauseAnimation(progress: progress, position: 0, info: info)
        self.viewAnimator.beginInteraction(progress: progress, position: 0, info: info)
        /* NOTE: Propagate delegate */
        self.propagateInteractionActionDelegate(state: .begin, progress: progress, info: info)
    }

    func updateInteractiveTransition(progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐷🎬", [
            "progress:".lpad() + String(describing: progress.decimal()),
        ])
        self.updateInteraction(progress)
        /* NOTE: Synchronize the percentage of interaction with `UIViewPropertyAnimator.fractionComplete` and `CALayer.timeOffset`.  */
        self.viewAnimator.updateAnimation(progress: progress, position: 0, info: info)
        self.viewAnimator.updateInteraction(progress: progress, position: 0, info: info)
        /* NOTE: Propagate delegate */
//        self.propagateInteractionActionDelegate(state: .update, progress: progress, info: info)
        if self.currentInteractionProgress != self.previousInteractionProgress {
            self.propagateInteractionActionDelegate(state: .update, progress: progress, info: info)
        }
    }

    func finishInteractiveTransition(isCancelled: Bool, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐷🎬", [
            "isCancelled:".lpad() + String(describing: isCancelled),
            "progress:".lpad() + String(describing: progress),
        ])
        switch isCancelled {
        case true:
            /* NOTE: Change animation speed */
//            self.completionSpeed = 1.0 - progress
            self.cancelInteraction()
            /* NOTE: Resume animation */
            self.viewAnimator.finishAnimation(isReversed: true, progress: progress, position: 0, info: info)
            self.viewAnimator.finishInteraction(isReversed: true, progress: progress, position: 0, info: info)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Propagate delegate */
            self.propagateInteractionActionDelegate(state: .cancel, progress: progress, info: info)
        case false:
            /* NOTE: Change animation speed */
//            self.completionSpeed = progress
            self.finishInteraction()
            /* NOTE: Resume animation */
            self.viewAnimator.finishAnimation(isReversed: false, progress: progress, position: 0, info: info)
            self.viewAnimator.finishInteraction(isReversed: false, progress: progress, position: 0, info: info)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Propagate delegate */
            self.propagateInteractionActionDelegate(state: .end, progress: progress, info: info)
        }
    }
}

/**
 * Presentation - Gestures
 */
extension FluidPresentDriverCompatible {
    func tapGestureDidUpdate(gesture: UITapGestureRecognizer) {
        Logger()?.log("🐷👆", [
        ])
        /* NOTE: Pause */
        self.isInteracting = true
        self.abortScrolls()
        self.disableScrollsInteraction()
        self.pausedInterruptibleFractionComplete = self.currentInterruptibleFractionComplete
        self.observingGesture?.snapshotBaseParameters()
        self.currentInteractionProgress = self.currentInterruptibleFractionComplete
        /* NOTE: Begin */
        self.beginInteractiveTransition(progress: self.clampedInteractionProgress,
                                        info: self.observingGesture?.currentGestureInfo() ?? .init())
        /* NOTE: Update */
        self.updateInteractiveTransition(progress: self.clampedInteractionProgress,
                                         info: self.observingGesture?.currentGestureInfo() ?? .init())
        /* NOTE: Cancel */
        self.isInteracting = false
        self.enableScrollsInteraction()
        self.isInteractionCancelled = true
        self.finishInteractiveTransition(isCancelled: true,
                                         progress: self.clampedInteractionProgress,
                                         info: self.observingGesture?.currentGestureInfo() ?? .init())
        /* NOTE: Set previous value */
        self.previousInteractionProgress = self.currentInteractionProgress
        self.previousResizePosition = 0
    }

    func panGestureDidUpdate(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began where !self.isInteracting && self.currentInterruptibleFractionComplete > 0,
             .changed where !self.isInteracting && self.currentInterruptibleFractionComplete > 0:
            self.beginPanGesture(gesture: gesture, isEdgePan: false)
        case .changed where self.isInteracting:
            self.updatePanGesture(gesture: gesture, isEdgePan: false)
        case .began, .changed:
            break
        case .ended, .failed, .cancelled:
            self.finishPanGesture(gesture: gesture, isEdgePan: false)
        case .possible: break
        @unknown default: break
        }
        /* NOTE: Set previous value */
        self.previousInteractionProgress = self.currentInteractionProgress
        self.previousResizePosition = self.currentResizePosition
    }

    func beginPanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        guard self.canBeginPresentInteraction() else { return }
        self.isInteracting = true
        self.abortScrolls()
        self.disableScrollsInteraction()
        self.pausedInterruptibleFractionComplete = self.currentInterruptibleFractionComplete
        self.observingGesture?.snapshotBaseParameters()
        self.currentInteractionProgress = self.calculateInteractionProgress()
        Logger()?.log("🐷👆", [
            "interactionType:".lpad(48) + String(describing: interactionType),
            "transitionPercentComplete:".lpad(48) + String(describing: self.transitionPercentComplete.decimal()),
            "currentInterruptibleFractionComplete:".lpad(48) + String(describing: self.currentInterruptibleFractionComplete.decimal()),
            "pausedInterruptibleFractionComplete:".lpad(48) + String(describing: self.pausedInterruptibleFractionComplete.decimal()),
            "currentProgressAnimatorProgress:".lpad(48) + String(describing: self.currentProgressAnimatorProgress.decimal()),
            "currentInteractionProgress:".lpad(48) + String(describing: self.currentInteractionProgress!.decimal()),
        ])
        self.beginInteractiveTransition(progress: self.clampedInteractionProgress,
                                        info: self.observingGesture?.currentGestureInfo() ?? .init())
    }

    func updatePanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        guard self.isInteracting else { return }
        self.currentInteractionProgress = self.calculateInteractionProgress()
//        Logger()?.log("🐷👆", [
//            "interactionType:".lpad(48) + String(describing: interactionType),
//            "transitionPercentComplete:".lpad(48) + String(describing: self.transitionPercentComplete.decimal()),
//            "currentInterruptibleFractionComplete:".lpad(48) + String(describing: self.currentInterruptibleFractionComplete.decimal()),
//            "pausedInterruptibleFractionComplete:".lpad(48) + String(describing: self.pausedInterruptibleFractionComplete.decimal()),
//            "currentProgressAnimatorProgress:".lpad(48) + String(describing: self.currentProgressAnimatorProgress.decimal()),
//            "currentInteractionProgress:".lpad(48) + String(describing: self.currentInteractionProgress!.decimal()),
//        ])
        if self.currentInteractionProgress != self.previousInteractionProgress {
            self.updateInteractiveTransition(progress: self.clampedInteractionProgress,
                                             info: self.observingGesture?.currentGestureInfo() ?? .init())
        }
    }

    func finishPanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        guard self.isInteracting else { return }
        self.isInteracting = false
        Logger()?.log("🐷👆", [
            "interactionType:".lpad(48) + String(describing: interactionType),
            "transitionPercentComplete:".lpad(48) + String(describing: self.transitionPercentComplete.decimal()),
            "currentInterruptibleFractionComplete:".lpad(48) + String(describing: self.currentInterruptibleFractionComplete.decimal()),
            "pausedInterruptibleFractionComplete:".lpad(48) + String(describing: self.pausedInterruptibleFractionComplete.decimal()),
            "currentProgressAnimatorProgress:".lpad(48) + String(describing: self.currentProgressAnimatorProgress.decimal()),
            "currentInteractionProgress:".lpad(48) + String(describing: self.currentInteractionProgress!.decimal()),
        ])
        self.isInteractionCancelled = !self.canFinishPresentInteraction(progress: self.clampedInteractionProgress)
        if !self.isInteractionCancelled { self.enableScrollsInteraction() }
        /* NOTE: Finish interactive transition */
        self.finishInteractiveTransition(isCancelled: self.isInteractionCancelled,
                                         progress: self.clampedInteractionProgress,
                                         info: self.observingGesture?.currentGestureInfo() ?? .init())
    }
}

/**
 Presentation - Condition
 */
extension FluidPresentDriverCompatible {
    /** A function that indicates whether transition should begin. */
    func canBeginPresentInteraction() -> Bool {
        Logger()?.log("🐷🚩", [
            "observingGesture?.currentGestureDirection:".lpad(48) + String(describing: self.observingGesture?.averageGestureDirection),
            "transitionStyle.presentAxis:".lpad(48) + String(describing: presentationStyle.presentAxis()),
            "allowInteractivePresent:".lpad(48) + String(describing: self.allowInteractivePresent),
//            "isPresentationLayerTouched:".lpad(48) + String(describing: self.isPresentationLayerTouched()),
            "isPresentGestureValidToBegin:".lpad(48) + String(describing: self.isPresentGestureValidToBegin()),
            "isPresentVelocityOverThresholdToBegin:".lpad(48) + String(describing: self.isPresentVelocityOverThresholdToBegin()),
        ])
        guard self.allowInteractivePresent else { return false }
//        guard self.isPresentationLayerTouched() else { return false }
        guard self.isPresentGestureValidToBegin() else { return false }
        guard self.isPresentVelocityOverThresholdToBegin() else { return false }
        return true
    }

    /** A function that indicates whether transition should finish. */
    func canFinishPresentInteraction(progress: CGFloat) -> Bool {
        Logger()?.log("🐷🚩", [
            "progress:".lpad(48) + String(describing: progress),
            "transitionStyle.presentAxis():".lpad(48) + String(describing: self.presentationStyle.presentAxis()),
            "averageGestureDirection:".lpad(48) + String(describing: self.observingGesture?.averageGestureDirection),
            "isPresentProgressOverThresholdToFinish:".lpad(48) + String(describing: self.isPresentProgressOverThresholdToFinish(progress: progress)),
            "isPresentGestureValidToFinish:".lpad(48) + String(describing: self.isPresentGestureValidToFinish()),
            "isPresentVelocityOverThresholdToFinish:".lpad(48) + String(describing: self.isPresentVelocityOverThresholdToFinish()),
        ])
        guard self.isPresentGestureValidToFinish() else { return false }
        if self.isPresentVelocityOverThresholdToFinish() { return true }
        guard self.isPresentProgressOverThresholdToFinish(progress: progress) else { return false }
        return true
    }
    /** A function that indicates whether a presentation layer is being touched. */
    func isPresentationLayerTouched() -> Bool {
        guard let currentLocation: CGPoint = self.observingGesture?.currentLocation,
              let gestureLayer: CALayer = self.observingGesture?.panGestureView?.layer,
              let topViewLayer: CALayer = self.layoutContainerView.layer.presentation() else { return false }
        let topViewLocation: CGPoint = topViewLayer.convert(currentLocation, from: gestureLayer)
        return topViewLayer.contains(topViewLocation)
    }
}

extension FluidPresentDriverCompatible {
    /** A function that indicates whether `percentComplete` is over threshold to finish transition. */
    func isPresentProgressOverThresholdToFinish(progress: CGFloat) -> Bool {
        return progress.clamped(0, 1) >= FluidConst.normalProgressFinishThreshold
    }

    /** A function that indicates whether velocity is over threshold to begin transition. */
    func isPresentVelocityOverThresholdToBegin() -> Bool {
        guard let velocity: CGVector = self.observingGesture?.currentVelocity else { return false }
        return velocity.length() >= FluidConst.dismissVelocityBeginThreshold
    }

    /** A function that indicates whether velocity is over threshold to finish transition. */
    func isPresentVelocityOverThresholdToFinish() -> Bool {
        guard let velocity: CGVector = self.observingGesture?.currentVelocity else { return false }
        return velocity.length() >= FluidConst.dismissVelocityFinishThreshold
    }

    /** A function that indicates whether the view is being dragged in the valid direction to begin transition. */
    func isPresentGestureValidToBegin() -> Bool {
        guard let direction: FluidGestureDirection = self.observingGesture?.averageGestureDirection else { return false }
        switch self.presentationStyle.presentAxis() {
        case .positiveX where direction.isApproxHorizontal,
             .negativeX where direction.isApproxHorizontal,
             .positiveY where direction.isApproxVertical,
             .negativeY where direction.isApproxVertical: return true
        default: return false
        }
    }

    /** A function that indicates whether the view is being dragged in the valid direction to finish transition. */
    func isPresentGestureValidToFinish() -> Bool {
        guard let direction: FluidGestureDirection = self.observingGesture?.averageGestureDirection else { return false }
        switch self.presentationStyle.presentAxis() {
        case .positiveX where !direction.isApproxLeft,
             .negativeX where !direction.isApproxRight,
             .positiveY where !direction.isApproxTop,
             .negativeY where !direction.isApproxBottom: return true
        default: return false
        }
    }
}
