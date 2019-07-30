//
//  FluidTransitionDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The methods in this protocol let you configure the transition.
 */
public protocol FluidTransitionConfigurationDelegate: FluidDelegate {
//    /**
//     The function that determines whether the delegate should invoke progress event. The default value is `false`. We strongly recommend to set value to `false` in order to maintain a high frame rate for the animation.
//
//     - returns: The `Bool` value.
//     */
//    func transitionShouldNotifyUpdateState() -> Bool

    /**
     The function that determines additional animations for the presentation transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter initialDimension: The `FluidInitialFrameDimension` value at the beginning of navigation.
     - parameter finalDimension: The `FluidFinalFrameDimension` value at the end of navigation.
     - parameter initialStyle: The `FluidInitialFrameStyle` value.
     - parameter finalStyle: The `FluidFinalFrameStyle` value.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.

     - returns: The `Array` value containing `FluidPropertyAnimator` objects and `FluidCoreAnimator` objects that conform to `FluidAnimatorCompatible` protocol.
     */
    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]?

    /**
     The function that determines additional animations for the dismissal transition.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter initialDimension: The `FluidInitialFrameDimension` value at the beginning of navigation.
     - parameter finalDimension: The `FluidFinalFrameDimension` value at the end of navigation.
     - parameter initialStyle: The `FluidInitialFrameStyle` value.
     - parameter finalStyle: The `FluidFinalFrameStyle` value.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.

     - returns: The `Array` value containing `FluidPropertyAnimator` objects and `FluidCoreAnimator` objects that conform to `FluidAnimatorCompatible` protocol.
     */
    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]?
}

/**
 The methods in this protocol let you control views while running the transition.
 */
public protocol FluidTransitionActionDelegate: FluidDelegate {
    /**
     The function that is invoked when an animated presentation transition updates.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidAnimatedTransitionState` value indicating the current state of the transition.
     - parameter progress: The `CGFloat` value indicating the current progress of the transition.
     */
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat)

    /**
     The function that is invoked when an interactive presentation transition updates.

     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the transition.
     - parameter progress: The `CGFloat` value indicating the current progress of the transition.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo)

    /**
     The function that is invoked when an animated dismissal transition updates.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidAnimatedTransitionState` value indicating the current state of the transition.
     - parameter progress: The `CGFloat` value indicating the current progress of the transition.
     */
    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat)

    /**
     The function that is invoked when an interactive dismissal transition updates.

     - parameter destination: The destination view controller that conforms to `FluidDestinationViewController`.
     - parameter source: The source view controller that conforms to `FluidSourceViewController`.
     - parameter navigation: The destination navigation view controller that conforms to `FluidDestinationNavigationController`.
     - parameter container: The `UIView` object in which the animated transition should take place.
     - parameter transitionStyle: The `FluidTransitionStyle` value.
     - parameter duration: The `TimeInterval` value.
     - parameter easing: The `FluidAnimatorEasing` value.
     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the transition.
     - parameter progress: The `CGFloat` value indicating the current progress of the transition.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo)
}
