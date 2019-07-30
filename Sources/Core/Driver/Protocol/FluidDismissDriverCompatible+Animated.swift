//
//  FluidDismissDriverCompatible+Animated.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidDismissDriverCompatible {
    func configureInterruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        Logger()?.log("🐽🎬", ["transitionContext:".lpad() + String(describing: transitionContext)])
        if self.interruptibleAnimator != nil { return self.interruptibleAnimator }
        /* NOTE: Configure animation */
        let duration: TimeInterval = {
            if self.presentationStyle.isFluid {
                return self.dismissDuration
            } else {
                return self.dismissDuration * TimeInterval(1 - self.clampedInteractionProgress)
            }
        }()
        let easing: FluidAnimatorEasing = {
            if self.presentationStyle.isFluid {
                return self.isInteractionCancelled ? .linear : self.dismissEasing
            } else {
                return self.clampedInteractionProgress > 0 ? .linear : self.dismissEasing
            }
        }()
        self.configureForwardTransitionAnimation(using: transitionContext,
                                                 driverType: .dismiss, animationType: .dismiss,
                                                 source: transitionContext.viewController(forKey: .to), destination: transitionContext.viewController(forKey: .from),
                                                 duration: duration, easing: easing, fromValue: self.clampedInteractionProgress,
                                                 completion: { [weak self] (position: UIViewAnimatingPosition, state: UIViewAnimatingStateEx) in
                                                     self?.viewAnimatorDidFinish(using: transitionContext)
                                                 })
        /* NOTE: Run extra animations */
        defer { self.viewAnimator.run() }
        /* NOTE: Create interruptible animator */
        self.interruptibleAnimator = self.viewAnimator.interruptibleAnimator!
        return self.interruptibleAnimator
    }
}

extension FluidDismissDriverCompatible where Self: FluidNavigationDismissDriver {
    func animationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐽🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
            "controllerDelegate:".lpad() + String(describing: controllerDelegate),
            "controllerDelegate?.dismissDriver:".lpad() + String(describing: controllerDelegate?.dismissDriver),
        ])
        switch transitionCompleted {
        case true:  /* NOTE: Transition is completed */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .end, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.viewAnimator.invalidate(willRemoveContainer: true)
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Remove view */
            self.parameters?.layout.deactivate(type: .navigation)
            self.parameters?.destinationViewController?.view.removeFromSuperview()
        case false: /* NOTE: Transition is cancelled */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .cancel, progress: self.viewAnimator.animationProgress)
            /* NOTE: Invalidate animators */
            self.viewAnimator.invalidate(willRemoveContainer: false)
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Configure parameters */
            try? self.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                          context: self.parameters.context,
                                          container: self.parameters.transitionContainerView,
                                          source: self.parameters.sourceViewController,
                                          destination: self.parameters.destinationViewController,
                                          initialContainerSize: self.parameters.finalContainerSize,
                                          finalContainerSize: self.parameters.finalContainerSize,
                                          shouldInsertSubview: false)
        }
        /* NOTE: Notify `FluidViewControllerTransitioningDelegate` that the view controller has been changed */
        if let transitionDelegate: FluidViewControllerTransitioningDelegate = self.rootNavigationController?.transitioningDelegate as? FluidViewControllerTransitioningDelegate {
            transitionDelegate.presentDriver.navigationAnimationDidEnd(transitionCompleted)
            transitionDelegate.dismissDriver.navigationAnimationDidEnd(transitionCompleted)
        }
    }
}

extension FluidDismissDriverCompatible where Self: FluidTransitionDismissDriver {
    func animationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐽🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
            "controllerDelegate:".lpad() + String(describing: controllerDelegate),
            "controllerDelegate?.dismissDriver:".lpad() + String(describing: controllerDelegate?.dismissDriver),
            "transitionContainerView:".lpad() + String(debug: self.parameters?.transitionContainerView),
            "layoutContainerView:".lpad() + String(debug: layoutContainerView),
            "sourceViewController:".lpad() + String(debug: self.parameters?.sourceViewController),
            "destinationViewController:".lpad() + String(debug: self.parameters?.destinationViewController),
            "sourceView:".lpad() + String(debug: sourceView),
        ])
        switch transitionCompleted {
        case true:  /* NOTE: Transition is completed */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .end, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.viewAnimator.invalidate(willRemoveContainer: true)
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Remove view */
            self.parameters?.layout.deactivate(type: .transition)
            self.parameters?.destinationViewController?.view.removeFromSuperview()
            self.parameters?.transitionContainerView?.subviews.forEach { $0.removeFromSuperview() }
            self.parameters?.transitionContainerView?.removeFromSuperview()
            /* NOTE: Invalidate transition delegate */
            self.controllerDelegate?.dispose()
        case false: /* NOTE: Transition is cancelled */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .cancel, progress: self.viewAnimator.animationProgress)
            /* NOTE: Invalidate animators */
            self.viewAnimator.invalidate(willRemoveContainer: false)
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Configure parameters */
            try? self.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                          context: self.parameters.context,
                                          container: self.parameters.transitionContainerView,
                                          source: self.parameters.sourceViewController,
                                          destination: self.parameters.rootNavigationController ?? self.parameters.destinationViewController,
                                          initialContainerSize: self.parameters.finalContainerSize,
                                          finalContainerSize: self.parameters.finalContainerSize,
                                          shouldInsertSubview: false)
        }
    }

    func navigationAnimationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐽🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
        ])
        /* NOTE: Stop observing gestures and scroll views */
        self.stopObservingGestures()
        /* NOTE: Invalidate animators */
        self.viewAnimator.invalidate(willRemoveContainer: false)
        self.interruptibleAnimator?.invalidate()
        self.interruptibleAnimator = nil
        /* NOTE: Reset interactor */
        self.resetInteractionState()
        /* NOTE: Configure parameters */
        try? self.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                      context: self.parameters.context,
                                      container: self.parameters.transitionContainerView,
                                      source: self.parameters.sourceViewController,
                                      destination: self.parameters.rootNavigationController ?? self.parameters.destinationViewController,
                                      initialContainerSize: self.parameters.finalContainerSize,
                                      finalContainerSize: self.parameters.finalContainerSize,
                                      shouldInsertSubview: false)
        /* NOTE: Start observing gestures and scroll views */
        self.startObservingGestures()
    }
}
