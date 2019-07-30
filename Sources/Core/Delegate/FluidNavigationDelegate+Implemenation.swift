//
//  FluidNavigationActionDelegate+Implemenation.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/28.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The `FluidNavigationConfigurationDelegate` for the source view controller and the navigation animation.
 */
public protocol FluidNavigationSourceConfigurationDelegate: FluidNavigationConfigurationDelegate {
    /**
     The function that determines whether an interactive present navigation can begin.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func navigationAllowsInteractivePresent(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> Bool

    /**
     The function that determines `FluidNavigationStyle`.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidNavigationStyle` object.
     */
    func navigationPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidNavigationStyle

    /**
     The function that determines `FluidBackgroundStyle`.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidBackgroundStyle` object.
     */
    func navigationBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle

    /**
     The function that determines `FluidAnimatorEasing` for presentation navigation.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidAnimatorEasing` object.
     */
    func navigationPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing?

    /**
     The function that determines `FluidAnimatorEasing` for dismissal navigation.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidAnimatorEasing` object.
     */
    func navigationDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing?

    /**
     The function that determines an animation duration for presentation navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `TimeInterval` value.
     */
    func navigationPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval?

    /**
     The function that determines an animation duration for dismissal navigation.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `TimeInterval` value.
     */
    func navigationDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval?

    /**
     The function that determines a frame dimension at the beginning of navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameDimension` value.
     */
    func navigationInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension?

    /**
     The function that determines a frame dimension at the end of navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameDimension` object.
     */
    func navigationFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameDimension?

    /**
     The function that determines frame style at the beginning of navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameStyle` value.
     */
    func navigationInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameStyle?

    /**
     The function that determines frame style at the end of navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `FluidFrameStyle` object.
     */
    func navigationFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameStyle?
}

public extension FluidNavigationSourceConfigurationDelegate {
    func navigationAllowsInteractivePresent(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> Bool { return true }

    func navigationPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidNavigationStyle { return .slide(direction: .fromRight) }
    func navigationBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle { return .none }

    func navigationPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }
    func navigationDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }

    func navigationPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }
    func navigationDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }

    func navigationInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension? { return nil }
    func navigationFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameDimension? { return nil }

    func navigationInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameStyle? { return nil }
    func navigationFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameStyle? { return nil }

//    func navigationShouldNotifyUpdateState() -> Bool { return true }
    func navigationAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
    func navigationAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
}

/**
 The `FluidNavigationConfigurationDelegate` for the destination view controller and the navigation animation.
 */
public protocol FluidNavigationDestinationConfigurationDelegate: FluidNavigationConfigurationDelegate {
    /**
     The function that determines whether an interactive dismissal navigation can begin.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.

     - returns: A `Boolean` value.
     */
    func navigationAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool
}

public extension FluidNavigationDestinationConfigurationDelegate {
    func navigationAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
//    func navigationShouldNotifyUpdateState() -> Bool { return true }
    func navigationAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
    func navigationAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
}

/**
 The methods in this protocol let you control views while performing the `FluidNavigationControllerDelegate` transition.
 */
public protocol FluidNavigationSourceActionDelegate: FluidNavigationActionDelegate {
}

public extension FluidNavigationSourceActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}

/**
 The methods in this protocol let you control views while performing the `FluidNavigationControllerDelegate` transition.
 */
public protocol FluidNavigationDestinationActionDelegate: FluidNavigationActionDelegate {
}

public extension FluidNavigationDestinationActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}
