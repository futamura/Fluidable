//
//  FluidPresentDriverCompatible+Animated.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidPresentDriverCompatible {
    func configureInterruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        Logger()?.log("🐷🎬", ["transitionContext:".lpad() + String(describing: transitionContext)])
        if self.interruptibleAnimator != nil { return self.interruptibleAnimator }
        /* NOTE: Configure animation */
        self.configureForwardTransitionAnimation(using: transitionContext,
                                                 driverType: .present, animationType: .present,
                                                 source: transitionContext.viewController(forKey: .from), destination: transitionContext.viewController(forKey: .to),
                                                 duration: nil, easing: nil, fromValue: 0,
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

extension FluidPresentDriverCompatible where Self: FluidNavigationPresentDriver {
    func animationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐷🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
            "controllerDelegate:".lpad() + String(describing: controllerDelegate),
            "controllerDelegate?.presentDriver:".lpad() + String(describing: controllerDelegate?.presentDriver),
            "containerView:".lpad() + String(debug: self.parameters?.containerView),
            "sourceViewController:".lpad() + String(debug: self.parameters?.sourceViewController),
            "destinationViewController:".lpad() + String(debug: self.parameters?.destinationViewController),
            "sourceView:".lpad() + String(debug: sourceView),
            "animationView:".lpad() + String(debug: animationView),
        ])
        switch transitionCompleted {
        case true:  /* NOTE: Transition is completed */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .end, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            self.viewAnimator.invalidate(willRemoveContainer: false)
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Remove view */
            self.parameters?.sourceViewController?.view.removeFromSuperview()
            /* NOTE: Update dismiss transition */
            try? self.controllerDelegate?.dismissDriver.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                                                            context: self.parameters.context,
                                                                            container: self.parameters.containerView,
                                                                            source: self.parameters.sourceViewController,
                                                                            destination: self.parameters.destinationViewController,
                                                                            initialContainerSize: self.parameters.finalContainerSize,
                                                                            finalContainerSize: self.parameters.finalContainerSize,
                                                                            shouldInsertSubview: false)
            /* NOTE: Start observing gestures and scroll views */
            self.controllerDelegate?.dismissDriver.stopObservingGestures()
            self.controllerDelegate?.dismissDriver.startObservingGestures()
            /* NOTE: Remove view */
            self.parameters?.sourceViewController.view.removeFromSuperview()
        case false: /* NOTE: Transition is cancelled */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .cancel, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            self.viewAnimator.invalidate(willRemoveContainer: true)
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Remove view */
            self.parameters?.layout.deactivate(type: .navigation)
            self.parameters?.destinationViewController?.view.removeFromSuperview()
        }
        /* NOTE: Notify `FluidViewControllerTransitioningDelegate` that the view controller has been changed */
        if let transitionDelegate: FluidViewControllerTransitioningDelegate = self.rootNavigationController?.transitioningDelegate as? FluidViewControllerTransitioningDelegate {
            transitionDelegate.presentDriver.navigationAnimationDidEnd(transitionCompleted)
            transitionDelegate.dismissDriver.navigationAnimationDidEnd(transitionCompleted)
        }
    }
}

extension FluidPresentDriverCompatible where Self: FluidTransitionPresentDriver {
    func animationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐷🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
            "controllerDelegate:".lpad() + String(describing: controllerDelegate),
            "controllerDelegate?.presentDriver:".lpad() + String(describing: controllerDelegate?.presentDriver),
            "containerView:".lpad() + String(debug: self.parameters?.containerView),
            "sourceViewController:".lpad() + String(debug: self.parameters?.sourceViewController),
            "destinationViewController:".lpad() + String(debug: self.parameters?.destinationViewController),
            "sourceView:".lpad() + String(debug: sourceView),
            "animationView:".lpad() + String(debug: animationView),
        ])
        switch transitionCompleted {
        case true:  /* NOTE: Transition is completed */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .end, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            self.viewAnimator.invalidate(willRemoveContainer: false)
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Update dismiss transition */
            try? self.controllerDelegate?.dismissDriver.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                                                            context: self.parameters.context,
                                                                            container: self.parameters.containerView,
                                                                            source: self.parameters.sourceViewController,
                                                                            destination: self.parameters.rootNavigationController ?? self.parameters.destinationViewController,
                                                                            initialContainerSize: self.parameters.finalContainerSize,
                                                                            finalContainerSize: self.parameters.finalContainerSize,
                                                                            shouldInsertSubview: false)
            /* NOTE: Start observing gestures and scroll views */
            self.controllerDelegate?.dismissDriver.stopObservingGestures()
            self.controllerDelegate?.dismissDriver.startObservingGestures()
        case false: /* NOTE: Transition is cancelled */
            /* NOTE: Propagate delegate */
            self.propagateAnimationActionDelegate(state: .cancel, progress: self.viewAnimator.animationProgress)
            /* NOTE: Stop observing gestures and scroll views */
            self.stopObservingGestures()
            /* NOTE: Invalidate animators */
            self.interruptibleAnimator?.invalidate()
            self.interruptibleAnimator = nil
            self.viewAnimator.invalidate(willRemoveContainer: true)
            /* NOTE: Reset interactor */
            self.resetInteractionState()
            /* NOTE: Remove container */
            self.parameters?.layout.deactivate(type: .transition)
            self.parameters?.destinationViewController?.view.removeFromSuperview()
            self.parameters?.containerView?.subviews.forEach { $0.removeFromSuperview() }
            self.parameters?.containerView?.removeFromSuperview()
            /* NOTE: Invalidate transition delegate */
            self.controllerDelegate?.dispose()
        }
    }

    func navigationAnimationDidEnd(_ transitionCompleted: Bool) {
        Logger()?.log("🐷🎬", [
            "transitionCompleted:".lpad() + String(describing: transitionCompleted),
        ])
    }
}
