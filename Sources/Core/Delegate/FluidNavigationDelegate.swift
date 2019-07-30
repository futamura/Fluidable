//
//  FluidNavigationDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The methods in this protocol let you configure the navigation.
 */
public protocol FluidNavigationConfigurationDelegate: FluidDelegate {
//    /**
//     The function that determines whether the delegate should invoke progress event. The default value is `false`. We strongly recommend to set value to `false` in order to maintain a high frame rate for the animation.
//
//     - returns: The `Bool` value.
//     */
//    func navigationShouldNotifyUpdateState() -> Bool

    /**
     The function that determines additional animations for the presentation navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter initialDimension: The `FluidInitialFrameDimension` value at the beginning of navigation.
     - parameter finalDimension: The `FluidFinalFrameDimension` value at the end of navigation.
     - parameter initialStyle: The `FluidInitialFrameStyle` value.
     - parameter finalStyle: The `FluidFinalFrameStyle` value.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.

     - returns: The `Array` value containing `FluidPropertyAnimator` objects and `FluidCoreAnimator` objects that conform to `FluidAnimatorCompatible` protocol.
     */
    func navigationAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]?

    /**
     The function that determines additional animations for the dismissal navigation.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter initialDimension: The `FluidInitialFrameDimension` value at the beginning of navigation.
     - parameter finalDimension: The `FluidFinalFrameDimension` value at the end of navigation.
     - parameter initialStyle: The `FluidInitialFrameStyle` value.
     - parameter finalStyle: The `FluidFinalFrameStyle` value.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.

     - returns: The `Array` value containing `FluidPropertyAnimator` objects and `FluidCoreAnimator` objects that conform to `FluidAnimatorCompatible` protocol.
     */
    func navigationAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]?
}

/**
 The methods in this protocol let you control views while running the navigation.
 */
public protocol FluidNavigationActionDelegate: FluidDelegate {
    /**
     The function that is invoked when an animated presentation navigation updates.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidAnimatedTransitionState` value indicating the current state of the navigation.
     - parameter progress: The `CGFloat` value indicating the current progress of the navigation.
     */
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat)

    /**
     The function that is invoked when an animated dismissal navigation updates.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidAnimatedTransitionState` value indicating the current state of the navigation.
     - parameter progress: The `CGFloat` value indicating the current progress of the navigation.
     */
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat)

    /**
     The function that is invoked when an interactive presentation navigation updates.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the navigation.
     - parameter progress: The `CGFloat` value indicating the current progress of the navigation.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo)

    /**
     The function that is invoked when an interactive dismissal navigation updates.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated navigation should take place.
     - parameter navigationStyle: The `FluidNavigationStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the navigation.
     - parameter progress: The `CGFloat` value indicating the current progress of the navigation.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo)
}
