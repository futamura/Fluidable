//
//  FluidTransitionDelegate+Implementation.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/28.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The `FluidTransitionConfigurationDelegate` for the source view controller and the transition animation.
 */
public protocol FluidTransitionSourceConfigurationDelegate: FluidTransitionConfigurationDelegate {
    /**
     The function that determines whether an interactive present transition can begin.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func transitionAllowsInteractivePresent(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> Bool

    /**
     The function that determines `FluidPresentationStyle`.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidPresentationStyle` object.
     */
    func transitionPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidTransitionStyle

    /**
     The function that determines `FluidBackgroundStyle`.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidBackgroundStyle` object.
     */
    func transitionBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle

    /**
     The function that determines `FluidAnimatorEasing` for presentation transition.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidAnimatorEasing` object.
     */
    func transitionPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing?

    /**
     The function that determines `FluidAnimatorEasing` for dismissal transition.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidAnimatorEasing` object.
     */
    func transitionDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing?

    /**
     The function that determines an animation duration for presentation transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `TimeInterval` value.
     */
    func transitionPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval?

    /**
     The function that determines an animation duration for dismissal transition.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `TimeInterval` value.
     */
    func transitionDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval?

    /**
     The function that determines a frame dimension at the beginning of transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameDimension` value.
     */
    func transitionInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension?

    /**
     The function that determines a frame dimension at the end of transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameDimension` object.
     */
    func transitionFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameDimension?

    /**
     The function that determines frame style at the beginning of transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameStyle` value.
     */
    func transitionInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameStyle?

    /**
     The function that determines frame style at the end of transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameStyle` object.
     */
    func transitionFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameStyle?
}

public extension FluidTransitionSourceConfigurationDelegate {
    func transitionAllowsInteractivePresent(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> Bool { return true }

    func transitionPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidTransitionStyle { return .slide(direction: .fromRight) }
    func transitionBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle { return .none }

    func transitionPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }
    func transitionDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }

    func transitionPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }
    func transitionDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }

    func transitionInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension? { return nil }
    func transitionFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameDimension? { return nil }

    func transitionInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameStyle? { return nil }
    func transitionFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameStyle? { return nil }

//    func transitionShouldNotifyUpdateState() -> Bool { return true }
    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
}

/**
 The `FluidTransitionConfigurationDelegate` for the destination view controller and the transition animation.
 */
public protocol FluidTransitionDestinationConfigurationDelegate: FluidTransitionConfigurationDelegate {
    /**
     The function that determines whether an interactive dismissal transition can begin.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool

    /**
     The function that determines whether only a root view controller can begin a dismissal transition.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool

    /**
     The function that determines whether the view should dismiss when a user taps the background.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool

    /**
     The function that determines whether the view should dismiss when a user taps the background.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: An `Array` value that contains `UIScrollView` objects.
     */
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]?
}

public extension FluidTransitionDestinationConfigurationDelegate {
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
//    func transitionShouldNotifyUpdateState() -> Bool { return true }
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]? { return nil }
    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
}

/**
 The methods in this protocol let you control views while performing the `FluidViewControllerTransitioningDelegate` transition.
 */
public protocol FluidTransitionSourceActionDelegate: FluidTransitionActionDelegate {
}

public extension FluidTransitionSourceActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}

/**
 The methods in this protocol let you control views while performing the `FluidViewControllerTransitioningDelegate` transition.
 */
public protocol FluidTransitionDestinationActionDelegate: FluidTransitionActionDelegate {
}

public extension FluidTransitionDestinationActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}
