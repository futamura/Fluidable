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

/**
 The `FluidResizableDelegate` protocol. The delegates will be invoked if you only specify the presentation style to .drawer(position: top) or  .drawer(position: bottom)
 */
public protocol FluidResizableTransitionDelegate: NSObjectProtocol {
    /**
     The function that determines whether the view should perform resize interaction.

     - returns: The `Bool` value.
     */
    func transitionShouldPerformResizing() -> Bool

    /**
     The function that determines minimum vertical margin for resizing.

     - returns: The `Bool` value.
     */
    func transitionMinimumMarginForResizing() -> CGFloat

    /**
     The function that determines the positions that the panning view should be snapped to after interaction end.

     - returns: The `Array` object containing `CGFloat` values. The range of values should be 1.0 to 0.0. If it contains out-of-range or duplicate values, those values are ignored.
     */
    func transitionSnapPositionsForResizing() -> [CGFloat]?

    /**
     The function that is invoked when an interactive resize transition updates.

     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the resizing interaction.
     - parameter position: The `CGFloat` value indicating the percentage of the current position. The range of values is 1.0 to 0.0.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo)
}

extension FluidResizableTransitionDelegate {
    func transitionShouldPerformResizing() -> Bool { return true }
    func transitionMinimumMarginForResizing() -> CGFloat { return 64 }
    func transitionSnapPositionsForResizing() -> [CGFloat]? { return nil }
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {}
}
