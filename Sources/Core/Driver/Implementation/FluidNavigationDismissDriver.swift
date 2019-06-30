//
//  FluidNavigationDismissDriver.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Dismissal
 */
internal class FluidNavigationDismissDriver: UIPercentDrivenInteractiveTransition,
                                             UIViewControllerAnimatedTransitioning,
                                             FluidDismissDriverCompatible {
    /* Type Aliases */
    typealias ViewAnimator = FluidNavigationViewAnimator
    typealias GestureObserver = FluidNavigationGestureObserver
    typealias ScrollObserver = FluidNavigationScrollObserver
    typealias Parameters = FluidNavigationParameters
    typealias ControllerDelegate = FluidNavigationControllerDelegate
    typealias RootNavigationControllerDelegate = FluidNavigationRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidNavigationSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidNavigationDestinationViewControllerDelegate

    /** The `FluidNavigationParameters` object */
    var parameters: Parameters!

    /* NOTE: Parameters for animated transition */

    /** Animators */
    weak var viewAnimator: ViewAnimator!
    var interruptibleAnimator: UIViewImplicitlyAnimating!

    /* NOTE: Parameters for interactive transition */

    /** Observings. */
    var observingGesture: GestureObserver!
    var observingScrolls: [ScrollObserver]!
    var mostTopObservingScroll: ScrollObserver?

    /** The `Bool` value that indicates whether performing interactive transition. */
    var isInteracting: Bool = false
    /** The `Bool` value that indicates whether the interaction was cancelled. */
    var isInteractionCancelled: Bool = false
    /** The `FluidTransitionInteractionState` value indicating interaction state */
    var interactionState: FluidDriverInteractionState = .none

    /** Transition and interaction progress. */
    var transitionPercentComplete: CGFloat { return self.percentComplete }
    var currentInterruptibleFractionComplete: CGFloat { return self.interruptibleAnimator.fractionComplete }
    var pausedInterruptibleFractionComplete: CGFloat = 0
    var currentProgressAnimatorProgress: CGFloat { return self.viewAnimator.animationProgress }
    var currentInteractionProgress: CGFloat?
    var previousInteractionProgress: CGFloat?
    var currentResizePosition: CGFloat = 0
    var previousResizePosition: CGFloat?

    /**
     The function that returns a `FluidDismissTransition` object to `FluidViewControllerTransitionDelegate.interactionControllerForDismissal(using:)` method.
     The interactive transition is enabled only if an user is dragging or panning a view.
     */
    func asOptional() -> FluidNavigationDismissDriver? { return self.isInteracting ? self : nil }

    /**
     The function that instantiates `FluidDismissTransition`.

     - parameter transitionAnimator: The animator object that conforms to the `FluidViewAnimatorCompatible` protocol.
     */
    init(_ viewAnimator: ViewAnimator) {
        super.init()
        self.viewAnimator = viewAnimator
        self.observingGesture = .init(delegate: self)
        self.observingScrolls = [ScrollObserver]()
    }

    deinit { Logger()?.log("🐽🧹🧹🧹", []) }
}

/**
 Dismissal - `UIViewControllerAnimatedTransitioning`
 */
extension FluidNavigationDismissDriver {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.hasValidReference() ? self.dismissDuration : FluidConst.defaultDismissDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        Logger()?.log("🐽🎬", [])
        self.interruptibleAnimator(using: transitionContext).startAnimation()
    }

    /* WARN: The `UIViewPropertyAnimator` does not support layer properties. So we use `FluidViewAnimatorCompatible` separately. */
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        Logger()?.log("🐽🎬", [])
        return self.configureInterruptibleAnimator(using: transitionContext)
    }

    public func animationEnded(_ transitionCompleted: Bool) {
        Logger()?.log("🐽🎬", [])
        self.animationDidEnd(transitionCompleted)
    }
}

/**
 Dismissal - `UIPercentDrivenInteractiveTransition`
 */
extension FluidNavigationDismissDriver {
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        Logger()?.log("🐽🎬", [])
        super.startInteractiveTransition(transitionContext)
    }

    func pauseInteraction() {
        super.pause()
    }

    func updateInteraction(_ percentComplete: CGFloat) {
        super.update(percentComplete)
    }

    func cancelInteraction() {
        super.cancel()
    }

    func finishInteraction() {
        super.finish()
    }

    func dismissViewController() {
        self.destinationViewController.navigationController?.popViewController(animated: true)
    }
}
