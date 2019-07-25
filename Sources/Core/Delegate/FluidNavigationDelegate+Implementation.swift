//
//  FluidNavigationDelegate+Implementation.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/25.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

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

public protocol FluidNavigationSourceActionDelegate: FluidNavigationActionDelegate {
}

public extension FluidNavigationSourceActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}

public protocol FluidNavigationDestinationActionDelegate: FluidNavigationActionDelegate {
}

public extension FluidNavigationDestinationActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}
