//
//  FluidDismissDriverCompatible+Interactive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Dismissal - Normal interaction
 */
extension FluidDismissDriverCompatible {
    func beginInteractiveTransition(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐽👆", [
            "progress:".lpad(32) + String(describing: self.currentInteractionProgress!.decimal()),
            "position:".lpad(32) + String(describing: self.currentResizePosition.decimal()),
        ])
        /* NOTE: Pause animation */
        self.viewAnimator.beginInteraction(progress: progress, position: position, info: info)
        /* NOTE: Propagate delegate */
        self.propagateInteractionActionDelegate(state: .begin, progress: progress, info: info)
        if self.presentationStyle.isDrawer && self.currentResizePosition != self.previousResizePosition && position >= 0 {
            self.propagateResizeActionDelegate(state: .begin, position: position, info: info)
        }
    }

    func updateInteractiveTransition(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐽👆", [
            "progress:".lpad(32) + String(describing: self.currentInteractionProgress!.decimal()),
            "position:".lpad(32) + String(describing: self.currentResizePosition.decimal()),
        ])
        /* NOTE: Update animation */
        self.viewAnimator.updateInteraction(progress: progress, position: position, info: info)
        /* NOTE: Propagate delegate */
        if self.currentInteractionProgress != self.previousInteractionProgress {
            self.propagateInteractionActionDelegate(state: .update, progress: progress, info: info)
        }
        if self.presentationStyle.isDrawer && self.currentResizePosition != self.previousResizePosition && position >= 0 {
            self.propagateResizeActionDelegate(state: .update, position: position, info: info)
        }
    }

    func finishInteractiveTransition(isCancelled: Bool, progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🐽👆", [
            "isCancelled:".lpad(16) + String(describing: isCancelled),
            "progress:".lpad(32) + String(describing: self.currentInteractionProgress!.decimal()),
            "position:".lpad(32) + String(describing: self.currentResizePosition.decimal()),
        ])
        /* NOTE: Resume animation */
        self.viewAnimator.finishInteraction(isReversed: isCancelled, progress: progress, position: position, info: info)
        /* NOTE: Propagate delegate */
        self.propagateInteractionActionDelegate(state: isCancelled ? .cancel : .end, progress: progress, info: info)
        if self.presentationStyle.isDrawer && self.currentResizePosition != self.previousResizePosition && position >= 0 {
            self.propagateResizeActionDelegate(state: isCancelled ? .cancel : .end, position: position, info: info)
        }
        if !isCancelled {
            /* NOTE: Start dismiss transition if interaction is not cancelled */
            self.dismissViewController()
        } else {
            /* NOTE: Start reversed dismiss transition if interaction is cancelled */
            self.configureAndRunReverseTransitionAnimation()
        }
    }
}

/**
 * Dismissal - Gestures
 */
extension FluidDismissDriverCompatible {
    func tapGestureDidUpdate(gesture: UITapGestureRecognizer) {
        self.dismissViewController()
    }

    func panGestureDidUpdate(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began where !self.isInteracting,
             .changed where !self.isInteracting:
            self.beginPanGesture(gesture: gesture, isEdgePan: false)
        case .changed where self.isInteracting:
            self.updatePanGesture(gesture: gesture, isEdgePan: false)
        case .began, .changed:
            break
        case .ended, .failed, .cancelled:
            self.finishPanGesture(gesture: gesture, isEdgePan: false)
        case .possible: break
        }
        /* NOTE: Set previous value */
        self.previousInteractionProgress = self.currentInteractionProgress
        self.previousResizePosition = self.currentResizePosition
    }

    func edgePanGestureDidUpdate(gesture: UIScreenEdgePanGestureRecognizer) {
        switch gesture.state {
        case .began where !self.isInteracting && self.isFullScreen,
             .changed where !self.isInteracting && self.isFullScreen:
            self.beginPanGesture(gesture: gesture, isEdgePan: true)
        case .changed where self.isInteracting:
            self.updatePanGesture(gesture: gesture, isEdgePan: true)
        case .began, .changed:
            break
        case .ended, .failed, .cancelled:
            self.finishPanGesture(gesture: gesture, isEdgePan: true)
        case .possible: break
        }
        /* NOTE: Set previous value */
        self.previousInteractionProgress = self.currentInteractionProgress
        self.previousResizePosition = self.currentResizePosition
    }

    func beginPanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        /* NOTE: Start interactive transition if possible */
        switch self.presentationStyle {
        case .fluid, .scale, .slide: guard self.canBeginDismissInteraction(isEdgePan: gesture.isEdgePan) else { return }
        case .drawer: guard self.canBeginDismissInteraction(isEdgePan: gesture.isEdgePan) || self.canBeginResizeInteraction() else { return }
        }
        self.isInteracting = true
        /* NOTE: Update gesture parameters */
        self.observingGesture?.snapshotBaseParameters()
        /* NOTE: Update progress */
        self.currentInteractionProgress = self.calculateTransitionProgress(isEdgePan: isEdgePan)
        self.currentResizePosition = self.calculateResizePosition()
        self.updateInteractionState()
        /* NOTE: Begin interaction */
        self.beginInteractiveTransition(progress: self.clampedInteractionProgress,
                                        position: self.clampedResizePosition,
                                        info: self.observingGesture?.currentGestureInfo() ?? .init())
    }

    func updatePanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        /* NOTE: Update interactive transition */
        guard self.isInteracting else { return }
        /* NOTE: Update progress */
        self.currentInteractionProgress = self.calculateTransitionProgress(isEdgePan: isEdgePan)
        self.currentResizePosition = self.calculateResizePosition()
        self.updateInteractionState()
        switch self.interactionType {
        case .normal:
            /* NOTE: Update scroll */
            self.updateScrolls(progress: self.clampedInteractionProgress,
                               position: self.clampedResizePosition,
                               state: self.interactionState)
            /* NOTE: Update interaction */
            self.updateInteractiveTransition(progress: self.clampedInteractionProgress,
                                             position: self.clampedResizePosition,
                                             info: self.observingGesture?.currentGestureInfo() ?? .init())
        case .fluid:
            /* NOTE: Update scroll */
            self.updateScrolls(progress: self.clampedInteractionProgress,
                               position: self.clampedResizePosition,
                               state: .dismissing)
            /* NOTE: Update interaction */
            self.updateInteractiveTransition(progress: self.clampedInteractionProgress,
                                             position: self.clampedResizePosition,
                                             info: self.observingGesture?.currentGestureInfo() ?? .init())
            /* NOTE: Finish fluid interaction if the progress value reaches to the max value */
            switch self.clampedInteractionProgress == 1 {
            case true:  /* NOTE: Reached to maximum interaction progress, cancel fluid interaction and start animated dismiss transition immediately */
                self.abortGesture() /* NOTE: Abort gestures forcibly and set gesture state to .finish */
            case false: /* NOTE: Not reaching to maximum interaction progress, continue fluid interaction */
                break
            }
        case .none:
            break
        }
    }

    func finishPanGesture(gesture: UIPanGestureRecognizer, isEdgePan: Bool) {
        guard self.isInteracting else { return }
        /* NOTE: Reset `interactionType` beforehand to finish interaction correctly. */
        self.isInteracting = false
        /* NOTE: Finish interactive transition */
        self.currentInteractionProgress = self.calculateTransitionProgress(isEdgePan: isEdgePan)
        self.currentResizePosition = self.calculateResizePosition()
        self.updateInteractionState()
        self.isInteractionCancelled = !self.canFinishDismissInteraction(progress: self.clampedInteractionProgress)
        /* NOTE: Update scroll */
        self.updateScrolls(progress: self.clampedInteractionProgress,
                           position: self.clampedResizePosition,
                           state: self.isInteractionCancelled ? .none : self.interactionState)
        /* NOTE: Finish interaction */
        self.finishInteractiveTransition(isCancelled: self.isInteractionCancelled,
                                         progress: self.clampedInteractionProgress,
                                         position: self.clampedResizePosition,
                                         info: self.observingGesture?.currentGestureInfo() ?? .init())
    }
}

/**
 Dismissal - Progress
 */
extension FluidDismissDriverCompatible {
    /** The function that calculates progress of dismiss transition. */
    func calculateTransitionProgress(isEdgePan: Bool) -> CGFloat {
        let progress: CGFloat = {
            guard let baseLocation: CGPoint = self.observingGesture?.initialLocation,
                  let currentLocation: CGPoint = self.observingGesture?.currentLocation else { return 0 }
            let frame: CGRect = self.finalDimension.frame()
            if isEdgePan {
                return abs(baseLocation.x - currentLocation.x) / frame.width
            } else {
                return {
                    switch presentationStyle.dismissAxis() {
                    case .positiveX: return (currentLocation.x - baseLocation.x) / frame.width
                    case .negativeX: return (baseLocation.x - currentLocation.x) / frame.width
                    case .positiveY: return (currentLocation.y - baseLocation.y) / frame.height
                    case .negativeY: return (baseLocation.y - currentLocation.y) / frame.height
                    default: return 0
                    }
                }()
            }
        }()
        switch self.interactionType {
        case .normal: return progress
        case .fluid:  return progress / FluidConst.fluidProgressFinishThreshold
        case .none:   return 0
        }
    }

    /** The function that calculates progress of resize interaction. */
    func calculateResizePosition() -> CGFloat {
        /* IMPORTANT: The resizing interaction is available for only the bottom drawer on the current version */
        guard let currentInteractionProgress: CGFloat = currentInteractionProgress,
              let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition, drawerPosition.isBottom,
              self.constantRangeForResizing > 0 else { return 0 }
        let dismissibleRange: CGFloat = {
            switch drawerPosition {
            case .top:    return self.finalDimension.frame().height
            case .bottom: return -self.finalDimension.frame().height
            case .left:   return self.finalDimension.frame().width
            case .right:  return -self.finalDimension.frame().width
            }
        }()
        return currentInteractionProgress * (dismissibleRange / self.constantRangeForResizing)
    }
}

/**
 Dismissal - Condition
 */
extension FluidDismissDriverCompatible {
    /** The function that indicates whether dismiss interaction should begin. */
    func canBeginDismissInteraction(isEdgePan: Bool) -> Bool {
        Logger()?.log("🐽🚩", [
            "initialGestureDirection:".lpad(48) + String(describing: self.observingGesture?.initialGestureDirection),
            "currentGestureDirection:".lpad(48) + String(describing: self.observingGesture?.currentGestureDirection),
            "averageGestureDirection:".lpad(48) + String(describing: self.observingGesture?.averageGestureDirection),
            "transitionStyle:".lpad(48) + String(describing: presentationStyle.dismissAxis()),
            "allowInteractiveDismiss:".lpad(48) + String(describing: self.allowInteractiveDismiss),
            "isDismissEdgePanValidDirectionToBegin:".lpad(48) + String(describing: self.isDismissEdgePanValidDirectionToBegin(isEdgePan: isEdgePan)),
            "isDismissPanGestureValidDirection:".lpad(48) + String(describing: self.isDismissPanGestureValidDirection()),
            "isDismissPanVelocityOverThresholdToBegin:".lpad(48) + String(describing: self.isDismissPanVelocityOverThresholdToBegin()),
            "isDismissAllowedByAllViews:".lpad(48) + String(describing: self.isDismissAllowedByAllViews()),
        ])
        guard self.allowInteractiveDismiss else { return false }
        if self.isDismissEdgePanValidDirectionToBegin(isEdgePan: isEdgePan) { return true }
        guard self.isDismissPanGestureValidDirection() else { return false }
        guard self.isDismissPanVelocityOverThresholdToBegin() else { return false }
        guard self.isDismissAllowedByAllViews() else { return false }
        /* NOTE: Whether the view controller is not a root view controller and child view controllers are allowed to begin fluidable transition */
//        let allowChildren: Bool = self.allowDismissForChild
//        guard destination.isRootViewController || (!destination.isRootViewController && allowChildren) else { return false }
        return true
    }

    /** The function that indicates whether resize interaction should begin. */
    func canBeginResizeInteraction() -> Bool {
        Logger()?.log("🐽🚩", [
            "initialGestureDirection:".lpad(48) + String(describing: self.observingGesture?.initialGestureDirection),
            "currentGestureDirection:".lpad(48) + String(describing: self.observingGesture?.currentGestureDirection),
            "averageGestureDirection:".lpad(48) + String(describing: self.observingGesture?.averageGestureDirection),
            "transitionStyle:".lpad(48) + String(describing: self.presentationStyle.dismissAxis()),
            "shouldPerformResizing:".lpad(48) + String(describing: self.shouldPerformResizing),
//            "isResizeGestureDirectionValid:".lpad(48) + String(describing: isResizeGestureDirectionValid()),
            "isResizeVelocityOverThresholdToBegin:".lpad(48) + String(describing: isResizeVelocityOverThresholdToBegin()),
            "isResizeDirectionAndPositionValid:".lpad(48) + String(describing: isResizeDirectionAndPositionValid()),
            "isResizeAllowedByMostTopView:".lpad(48) + String(describing: isResizeAllowedByMostTopView()),
        ])
        guard self.shouldPerformResizing else { return false }
//        guard self.isResizeGestureDirectionValid() else { return false }
        guard self.isResizeVelocityOverThresholdToBegin() else { return false }
        guard self.isResizeDirectionAndPositionValid() else { return false }
        guard self.isResizeAllowedByMostTopView() else { return false }
        return true
    }

    /** The function that indicates whether normal interaction should finish. */
    func canFinishDismissInteraction(progress: CGFloat) -> Bool {
        guard self.isDismissPanGestureValidDirection() else { return false }
        if self.isDismissEdgePanOverThresholdToFinish(progress: progress) { return true }
        if self.isDismissVelocityOverThresholdToFinish() { return true }
        guard self.isDismissProgressOverThresholdToFinish(progress: progress) else { return false }
        return true
    }
}

/**
 Dismissal - Conditions for normal and fluid
 */
extension FluidDismissDriverCompatible {
    /** The function that indicates whether the view is dragged in the valid direction. */
    func isDismissPanGestureValidDirection() -> Bool {
        guard let direction: FluidGestureDirection = self.observingGesture?.averageGestureDirection else { return false }
        switch presentationStyle.dismissAxis() {
        case .positiveX where direction.isNarrowRight:  return true
        case .negativeX where direction.isNarrowLeft:   return true
        case .positiveY where direction.isApproxBottom: return true
        case .negativeY where direction.isApproxTop:    return true
        default: return false
        }
    }

    /** The function that indicates whether the gesture velocity is over threshold to begin dismissing. */
    func isDismissPanVelocityOverThresholdToBegin() -> Bool {
        guard let velocity: CGVector = self.observingGesture?.currentVelocity else { return false }
        return velocity.length() >= FluidConst.dismissVelocityBeginThreshold
    }

    /** The function that indicates whether the edge pan gesture allows dismissing. */
    func isDismissEdgePanValidDirectionToBegin(isEdgePan: Bool) -> Bool {
        return isEdgePan &&
               layout.isFullScreen &&
               self.interactionType.isEdgePanEnabled &&
               (self.observingGesture?.averageGestureDirection.isNarrowRight ?? false)
    }

    /** The function that indicates whether the gesture velocity is over threshold to finish dismissing. */
    func isDismissProgressOverThresholdToFinish(progress: CGFloat) -> Bool {
        switch presentationStyle {
        case .fluid: return progress.clamped(0, 1) >= FluidConst.fluidProgressReverseThreshold
        case .scale, .slide, .drawer: return progress.clamped(0, 1) >= FluidConst.normalProgressFinishThreshold
        }
    }

    /** The function that indicates whether the edge pan gesture is over threshold to dismiss. */
    func isDismissEdgePanOverThresholdToFinish(progress: CGFloat) -> Bool {
        return self.interactionType.isEdgePanEnabled &&
               self.isDismissProgressOverThresholdToFinish(progress: progress)
    }

    /** The function that indicates whether velocity is over threshold. */
    func isDismissVelocityOverThresholdToFinish() -> Bool {
        guard let velocity: CGVector = self.observingGesture?.currentVelocity else { return false }
        return velocity.length() >= FluidConst.dismissVelocityFinishThreshold
    }

    /** The function that indicates whether all scroll views allow to perform dismiss transition. */
    func isDismissAllowedByAllViews() -> Bool {
        guard let observings: [ScrollObserver] = self.observingScrolls else { return true }
        return !observings.contains { return !$0.isDismissAllowed() }
    }
}

/**
 Dismissal - Conditions for resizing
 */
extension FluidDismissDriverCompatible {
    /** The function that indicates whether gesture velocity is over threshold to begin resizing interaction. */
    func isResizeVelocityOverThresholdToBegin() -> Bool {
        guard let velocity: CGVector = self.observingGesture?.currentVelocity else { return false }
        return velocity.length() >= FluidConst.resizeVelocityBeginThreshold
    }

    /** The function that indicates whether the view is dragged in the valid direction. */
    func isResizeGestureDirectionValid() -> Bool {
        guard let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition,
              let observingGesture: GestureObserver = self.observingGesture else { return false }
        let initialGestureDirection: FluidGestureDirection = observingGesture.initialGestureDirection
        let currentGestureDirection: FluidGestureDirection = observingGesture.currentGestureDirection
        let averageGestureDirection: FluidGestureDirection = observingGesture.averageGestureDirection
        switch drawerPosition {
        case .top    where currentGestureDirection.isApproxVertical:   return true
        case .bottom where currentGestureDirection.isApproxVertical:   return true
        case .left   where initialGestureDirection.isNarrowHorizontal: return true
        case .left   where currentGestureDirection.isNarrowHorizontal &&
                           averageGestureDirection.isNarrowHorizontal: return true
        case .right  where initialGestureDirection.isNarrowHorizontal: return true
        case .right  where currentGestureDirection.isNarrowHorizontal &&
                           averageGestureDirection.isNarrowHorizontal: return true
        default: return false
        }
    }

    /** The function that indicates whether all scroll views allow to perform resize interaction. */
    func isResizeDirectionAndPositionValid() -> Bool {
        guard let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition,
              let observingGesture: GestureObserver = self.observingGesture else { return false }
        let currentGestureDirection: FluidGestureDirection = observingGesture.currentGestureDirection
        let averageGestureDirection: FluidGestureDirection = observingGesture.averageGestureDirection
        guard !currentGestureDirection.isNone else { return false }
        let isValidDirectionAndPosition: Bool = {
            switch drawerPosition {
            case .top:
                let constant: CGFloat = self.layout.bottom.constant
                let isLessThanExpandedConstant: Bool = (currentGestureDirection.isApproxBottom || averageGestureDirection.isApproxBottom) && constant < self.expandedConstantForResizing
                let isGreaterThanBaseConstant: Bool = (currentGestureDirection.isApproxTop || averageGestureDirection.isApproxTop) && constant >= self.baseConstantForResizing
                return isLessThanExpandedConstant || isGreaterThanBaseConstant
            case .bottom:
                let constant: CGFloat = self.layout.top.constant
                let isGreaterThanExpandedConstant: Bool = (currentGestureDirection.isApproxTop || averageGestureDirection.isApproxTop) && constant > self.expandedConstantForResizing
                let isLessThanBaseConstant: Bool = (currentGestureDirection.isApproxBottom || averageGestureDirection.isApproxBottom) && constant <= self.baseConstantForResizing
                return isGreaterThanExpandedConstant || isLessThanBaseConstant
            case .left:
                let constant: CGFloat = self.layout.right.constant
                let isLessThanExpandedConstant: Bool = (currentGestureDirection.isApproxRight || averageGestureDirection.isApproxRight) && constant < self.expandedConstantForResizing
                let isGreaterThanBaseConstant: Bool = (currentGestureDirection.isApproxLeft || averageGestureDirection.isApproxLeft) && constant >= self.baseConstantForResizing
                return isLessThanExpandedConstant || isGreaterThanBaseConstant
            case .right:
                let constant: CGFloat = self.layout.left.constant
                let isGreaterThanExpandedConstant: Bool = (currentGestureDirection.isApproxLeft || averageGestureDirection.isApproxLeft) && constant > self.expandedConstantForResizing
                let isLessThanBaseConstant: Bool = (currentGestureDirection.isApproxRight || averageGestureDirection.isApproxRight) && constant <= self.baseConstantForResizing
                return isGreaterThanExpandedConstant || isLessThanBaseConstant
            }
        }()
        return isValidDirectionAndPosition
    }

    /** The function that indicates whether all scroll views allow to perform resize interaction. */
    func isResizeAllowedByMostTopView() -> Bool {
        return self.mostTopObservingScroll?.isResizeAllowed() ?? true
    }
}
