//
//  FluidTransitionCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

internal protocol FluidDriverCompatible: FluidParametersAccessible, FluidGestureDelegate {
    associatedtype ViewAnimator: FluidViewAnimatorCompatible
    associatedtype GestureObserver: FluidGestureObservable
    associatedtype ScrollObserver: FluidScrollObservable

    /** The `FluidTransitionParameters` object. */
    var parameters: Parameters! { set get }

    /** The `FluidTransitionAnimator` object */
    var viewAnimator: ViewAnimator! { set get }
    /** The interruptible animator that conforms to `UIViewImplicitlyAnimating`. */
    var interruptibleAnimator: UIViewImplicitlyAnimating! { set get }

    /** The gesture being observed. */
    var observingGesture: GestureObserver! { set get }
    /** The scroll views being observed. */
    var observingScrolls: [ScrollObserver]! { set get }
    /** The most top scroll view being observed. */
    var mostTopObservingScroll: ScrollObserver? { set get }

    /** The `Bool` value indicating whether the transition is interactive */
    var isInteracting: Bool { set get }
    /** The `Bool` value that indicates whether the interaction was cancelled. */
    var isInteractionCancelled: Bool { set get }
    /** The `FluidTransitionInteractionType` value indicating interaction type */
    var interactionType: FluidDriverInteractionType { get }
    /** The `FluidTransitionInteractionState` value indicating interaction state */
    var interactionState: FluidDriverInteractionState { set get }

    /* The transition progress */
    var transitionPercentComplete: CGFloat { get }

    /** The interruptible animator progress. */
    var currentInterruptibleFractionComplete: CGFloat { get }
    /** The interruptible animator when the animated transition pauses. */
    var pausedInterruptibleFractionComplete: CGFloat { set get }
    /** The progress animator progress. */
    var currentProgressAnimatorProgress: CGFloat { get }

    /** The interaction progress clamped in the range of 1 to 0. */
    var clampedInteractionProgress: CGFloat { get }
    /** The current interaction progress value. */
    var currentInteractionProgress: CGFloat? { set get }
    /** The previous interaction progress value. */
    var previousInteractionProgress: CGFloat? { set get }

    /** The current resizing position clamped in the range of 0 to CGFloat.infinity. */
    var clampedResizePosition: CGFloat { get }
    /** The current resizing position. */
    var currentResizePosition: CGFloat { set get }
    /** The previous resizing position. */
    var previousResizePosition: CGFloat? { set get }

    /** The functions that configures parameters. */
    func configureParameters(driverType: FluidDriverType,
                             animationType: FluidAnimationType,
                             context: UIViewControllerContextTransitioning?,
                             container: UIView, source: UIViewController?, destination: UIViewController?,
                             initialContainerSize: CGSize?, finalContainerSize: CGSize?,
                             duration: TimeInterval?, easing: FluidAnimatorEasing?,
                             shouldInsertSubview: Bool) throws

    /** The functions that invalidates parameters. */
    func dispose()

    /** Functions that start and stop observing pan gestures and scroll views. */
    func startObservingGestures()
    /** The function that stop observing pan gestures and scroll views. */
    func stopObservingGestures()

    /** The function that abort gesture. */
    func abortGesture()
    /** The function that update scrolling. */
    func updateScrolls(progress: CGFloat, position: CGFloat, state: FluidDriverInteractionState)

    /** The function that updates interaction state. */
    func updateInteractionState()
    /** The function that resets interaction parameters. */
    func resetInteractionState()
    /** The function that calculates interaction progress. */
    func calculateInteractionProgress() -> CGFloat

    /* NOTE: Interactive transition */
    func pauseInteraction()
    func updateInteraction(_ percentComplete: CGFloat)
    func cancelInteraction()
    func finishInteraction()

    /* NOTE: Animation */
    func configureInterruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating
    func configureForwardTransitionAnimation(using transitionContext: UIViewControllerContextTransitioning,
                                             driverType: FluidDriverType, animationType: FluidAnimationType,
                                             source: UIViewController?, destination: UIViewController?,
                                             duration: TimeInterval?, easing: FluidAnimatorEasing?, fromValue: CGFloat,
                                             completion: @escaping FluidInterruptibleAnimator.CompletionBlock)
    func viewAnimatorDidFinish(using transitionContext: UIViewControllerContextTransitioning)
    func animationDidEnd(_ transitionCompleted: Bool)

    /* NOTE: Delegates */
    /** The functions that propagates animation event action through `FluidableDelegate` observers. */
    func propagateAnimationActionDelegate(state: FluidProgressState, progress: CGFloat)
    /** The functions that propagates interactive transition event through `FluidableDelegate` observers. */
    func propagateInteractionActionDelegate(state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo)
    /** The functions that propagates resize event through `FluidableDelegate` observers. */
    func propagateResizeActionDelegate(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo)
}
