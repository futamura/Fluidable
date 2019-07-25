//
//  FluidViewControllerTransitionDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
  A class that conforms to `UIViewControllerTransitioningDelegate` protocol.
 */
public class FluidViewControllerTransitioningDelegate: NSObject, FluidControllerDelegateCompatible {
    internal typealias ViewAnimator = FluidTransitionViewAnimator
    internal typealias PresentDriver = FluidTransitionPresentDriver
    internal typealias DismissDriver = FluidTransitionDismissDriver

    internal var viewAnimator: ViewAnimator
    internal var presentDriver: PresentDriver
    internal var dismissDriver: DismissDriver

    public override init() {
        Logger()?.log("🌙🛠", [])
        self.viewAnimator = FluidTransitionViewAnimator()
        self.presentDriver = .init(self.viewAnimator)
        self.dismissDriver = .init(self.viewAnimator)
        super.init()
    }

//    public init<T: FluidViewAnimatorCompatible>(viewAnimator: T?) {
//        Logger()?.log("🌙🛠", [])
//        self.viewAnimator = viewAnimator ?? DefaultFluidTransitionViewAnimator()
//        self.presentDriver = .init(self.presenter)
//        self.dismissDriver = .init(self.presenter)
//        super.init()
//    }

    deinit { Logger()?.log("🌙🧹🧹🧹", []) }
}

extension FluidViewControllerTransitioningDelegate: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Logger()?.log("🌙🎬", ["presented:".lpad(16) + String(describing: presented),
                               "presenting:".lpad(16) + String(describing: presenting),
                               "source:".lpad(16) + String(describing: source)])
        guard source.fluid.isFluidTransitionSourceViewController && (presented.fluid.isFluidTransitionDestinationNavigationController || presented.fluid.isFluidTransitionDestinationViewController) else { return nil }
        return self.presentDriver
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Logger()?.log("🌙🎬", ["dismissed:".lpad() + (String(describing: dismissed))])
        return self.dismissDriver
    }

    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        Logger()?.log("🌙🎬", ["animator:".lpad() + String(describing: animator)])
        return self.presentDriver
    }

    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        Logger()?.log("🌙🎬", ["animator:".lpad() + String(describing: animator)])
        return self.dismissDriver.asOptional()
    }
}

public extension FluidViewControllerTransitioningDelegate {
    /** A function that disposes all objects belonging to transitions. */
    internal func dispose() {
        Logger()?.log("🌙🗑🗑🗑", [])
        self.presentDriver.stopObservingGestures()
        self.presentDriver.dispose()
        self.dismissDriver.stopObservingGestures()
        self.dismissDriver.dispose()
        self.viewAnimator.invalidate(willRemoveContainer: true)
    }
}
