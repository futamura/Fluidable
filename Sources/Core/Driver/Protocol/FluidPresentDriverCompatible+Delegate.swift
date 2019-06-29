//
//  FluidPresentDriverCompatible+Delegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidPresentDriverCompatible where Self: FluidNavigationPresentDriver {
    func propagateAnimationActionDelegate(state: FluidProgressState, progress: CGFloat) {
//        Logger()?.log("🐷🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let navigationStyle: FluidNavigationStyle = self.presentationStyle.toNavigationStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.navigationPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.navigationPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidNavigationDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.navigationPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
    }

    func propagateInteractionActionDelegate(state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
//        guard self.isInteracting else { return }
//        Logger()?.log("🐷🔥🔥🔥", ["info:" + String(describing: info)])
        let navigationStyle: FluidNavigationStyle = self.presentationStyle.toNavigationStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.navigationPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.navigationPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidNavigationDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.navigationPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
    }

    func propagateResizeActionDelegate(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {}
}

extension FluidPresentDriverCompatible where Self: FluidTransitionPresentDriver {
    func propagateAnimationActionDelegate(state: FluidProgressState, progress: CGFloat) {
//        Logger()?.log("🐷🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let transitionStyle: FluidTransitionStyle = self.presentationStyle.toTransitionStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.transitionPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.transitionPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidTransitionDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.transitionPresentAnimationDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                           with: self.rootNavigationController, on: self.containerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
    }

    func propagateInteractionActionDelegate(state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
//        guard self.isInteracting else { return }
//        Logger()?.log("🐷🔥🔥🔥", ["info:" + String(describing: info)])
        let transitionStyle: FluidTransitionStyle = self.presentationStyle.toTransitionStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.transitionPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.transitionPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidTransitionDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.transitionPresentInteractionDidProgress(from: self.sourceViewController, to: self.destinationViewController,
                                                             with: self.rootNavigationController, on: self.containerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
    }

    func propagateResizeActionDelegate(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {}
}
