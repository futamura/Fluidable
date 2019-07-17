//
//  FluidDismissDriverCompatible+Delegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidDismissDriverCompatible where Self: FluidNavigationDismissDriver {
    func propagateAnimationActionDelegate(state: FluidProgressState, progress: CGFloat) {
        guard !self.isInteracting else { return }
//        Logger()?.log("🐽🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let navigationStyle: FluidNavigationStyle = self.presentationStyle.toNavigationStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.navigationDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.navigationDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidNavigationDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.navigationDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           navigationStyle: navigationStyle,
                                                           duration: self.dismissDuration, easing: self.dismissEasing,
                                                           state: state, progress: progress)
        }
    }

    func propagateInteractionActionDelegate(state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🐽🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let navigationStyle: FluidNavigationStyle = self.presentationStyle.toNavigationStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.navigationDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidNavigationSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.navigationDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidNavigationDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.navigationDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             navigationStyle: navigationStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
    }

    func propagateResizeActionDelegate(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
    }
}

extension FluidDismissDriverCompatible where Self: FluidTransitionDismissDriver {
    func propagateAnimationActionDelegate(state: FluidProgressState, progress: CGFloat) {
        guard !self.isInteracting else { return }
//        Logger()?.log("🐽🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let transitionStyle: FluidTransitionStyle = self.presentationStyle.toTransitionStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.transitionDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.transitionDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidTransitionDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.transitionDismissAnimationDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                           with: self.rootNavigationController, on: self.transitionContainerView,
                                                           transitionStyle: transitionStyle,
                                                           duration: self.presentDuration, easing: self.presentEasing,
                                                           state: state, progress: progress)
        }
    }

    func propagateInteractionActionDelegate(state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
//        Logger()?.log("🐽🔥🔥🔥", ["sourceViewController:".lpad() + String(describing: self.sourceViewController),
//                                   "rootNavigationController:".lpad() + String(describing: self.rootNavigationController),
//                                   "destinationViewController:".lpad() + String(describing: self.destinationViewController),
//                                   "state:".lpad() + String(describing: state),
//                                   "progress:".lpad() + String(describing: progress)])
        let transitionStyle: FluidTransitionStyle = self.presentationStyle.toTransitionStyle()
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionRootNavigationControllerDelegate = self.rootNavigationControllerDelegate {
            delegate.transitionDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.sourceShouldNotifyUpdateState,
        if let delegate: FluidTransitionSourceViewControllerDelegate = self.sourceViewControllerDelegate {
            delegate.transitionDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
//        if state != .update || state == .update && self.destinationShouldNotifyUpdateState,
        if let delegate: FluidTransitionDestinationViewControllerDelegate = self.destinationViewControllerDelegate {
            delegate.transitionDismissInteractionDidProgress(from: self.destinationViewController, to: self.sourceViewController,
                                                             with: self.rootNavigationController, on: self.transitionContainerView,
                                                             transitionStyle: transitionStyle,
                                                             duration: self.presentDuration, easing: self.presentEasing,
                                                             state: state, progress: progress, info: info)
        }
    }

    func propagateResizeActionDelegate(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
        self.destinationResizableDelegate?.transitionInteractiveResizeDidProgress(state: state, position: position.clamped(0, 1), info: info)
    }
}
