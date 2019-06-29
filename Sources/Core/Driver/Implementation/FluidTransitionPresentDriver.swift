//
//  FluidTransitionPresentDriver.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Presentation
 */
internal class FluidTransitionPresentDriver: UIPercentDrivenInteractiveTransition,
                                             UIViewControllerAnimatedTransitioning,
                                             FluidPresentDriverCompatible {
    /* Type Aliases */
    typealias ViewAnimator = FluidTransitionViewAnimator
    typealias GestureObserver = FluidTransitionGestureObserver
    typealias ScrollObserver = FluidTransitionScrollObserver
    typealias Parameters = FluidTransitionParameters
    typealias ControllerDelegate = FluidViewControllerTransitioningDelegate
    typealias RootNavigationControllerDelegate = FluidTransitionRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidTransitionSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidTransitionDestinationViewControllerDelegate

    /** The `FluidTransitionParameters` object */
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
    var currentProgressAnimatorProgress: CGFloat { return self.viewAnimator.progressAnimator?.animatorProgress ?? 0 }
    var pausedInterruptibleFractionComplete: CGFloat = 0
    var currentInterruptibleFractionComplete: CGFloat { return self.interruptibleAnimator.fractionComplete }
    var currentInteractionProgress: CGFloat?
    var previousInteractionProgress: CGFloat?
    var currentResizePosition: CGFloat = 0
    var previousResizePosition: CGFloat?

    /**
     The function that instantiates `FluidDismissTransition`.

     - parameter transitionAnimator: The animator object that conforms to the `FluidViewAnimatorCompatible` protocol.
     */
    init(_ viewAnimator: ViewAnimator) {
        super.init()
        self.wantsInteractiveStart = false
        self.viewAnimator = viewAnimator
        self.observingGesture = .init(delegate: self)
        self.observingScrolls = [ScrollObserver]()
    }

    deinit { Logger()?.log("🐷🧹🧹🧹", []) }
}

/**
 Presentation - `UIViewControllerAnimatedTransitioning`
 */
extension FluidTransitionPresentDriver {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        Logger()?.log("🐷🎬", [])
        return self.hasValidReference() ? self.presentDuration : FluidConst.defaultPresentDuration
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        Logger()?.log("🐷🎬", [])
        self.interruptibleAnimator(using: transitionContext).startAnimation()
    }

    /* WARN: The `UIViewPropertyAnimator` does not support layer properties. So we use `FluidViewAnimatorCompatible` separately. */
    public func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        Logger()?.log("🐷🎬", [])
        return self.configureInterruptibleAnimator(using: transitionContext)
    }

    public func animationEnded(_ transitionCompleted: Bool) {
        Logger()?.log("🐷🎬", [])
        self.animationDidEnd(transitionCompleted)
    }
}

/**
 Presentation - `UIPercentDrivenInteractiveTransition`
 */
extension FluidTransitionPresentDriver {
    override func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        Logger()?.log("🐷🎬", [])
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
}
