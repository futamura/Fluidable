//
//  FluidError.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations of `FluidErrorLevel`.
 */
enum FluidErrorLevel: Int, CustomStringConvertible {
    /** The error level indicating the app should cancel transition. */
    case error
    /** The error level indicating the configuration is invalid but the app can continue a transition. */
    case warn
    /** The error level showing some information. */
    case info

    var description: String {
        switch self {
        case .error: return "error"
        case .warn:  return "warn"
        case .info:  return "info"
        }
    }
}

/**
 The enumerations of `FluidError`.
 */
public enum FluidError: Swift.Error {
    /** The error raised if view controllers are incorrectly configured. */
    case invalidReference

    /** The error raised if you are specifying an unsupported easing for the presentation transition. */
    case unsupportedPresentationEasing(easing: FluidAnimatorEasing)
    /** The error raised if you are specifying an unsupported easing for the dismissal transition. */
    case unsupportedDismissalEasing(easing: FluidAnimatorEasing)

    /** The error raised if you are specifying the duration and the `FluidAnimatorEasing.spring(mass:stiffness:damping:velocity:)` easing for the presentation transition. */
    case ignoredPresentationDuration(easing: FluidAnimatorEasing, defaultDuration: TimeInterval, userDefinedDuration: TimeInterval)
    /** The error raised if you are specifying the duration and the `FluidAnimatorEasing.spring(mass:stiffness:damping:velocity:)` easing for the dismissal transition. */
    case ignoredDismissalDuration(easing: FluidAnimatorEasing, defaultDuration: TimeInterval, userDefinedDuration: TimeInterval)

    case invalidInitialFrameDimension
    case invalidFinalFrameDimension

    case invalidResizeConfiguration

    /** The error level. */
    var level: FluidErrorLevel {
        switch self {
        case .invalidReference, .unsupportedPresentationEasing, .unsupportedDismissalEasing, .invalidResizeConfiguration:
            return .error
        case .ignoredPresentationDuration, .ignoredDismissalDuration, .invalidInitialFrameDimension, .invalidFinalFrameDimension:
            return .warn
        }
    }

    /** The description for debugging. */
    var description: String {
        switch self {
        case .invalidReference:
            return "The source controller or the destination controller is already disposed."
        case .unsupportedPresentationEasing(let easing):
            return "The easing `FluidAnimatorEasing.\(String(describing: easing))` is not available on iOS \(UIDevice.current.systemVersion)."
        case .unsupportedDismissalEasing(let easing):
            return "The easing `FluidAnimatorEasing.\(String(describing: easing))` is not available on iOS \(UIDevice.current.systemVersion)."
        case .ignoredPresentationDuration(let easing, let defaultDuration, let userDefinedDuration):
            return "You set the present duration (\(userDefinedDuration)) in the source view controller delegate but the easing type is `FluidAnimatorEasing.\(String(describing: easing))`. The default duration (\(defaultDuration)) will be used." /** swiftlint:disable:this line_length */
        case .ignoredDismissalDuration(let easing, let defaultDuration, let userDefinedDuration):
            return "You set the dismiss duration (\(userDefinedDuration)) in the source view controller delegate but the easing type is `FluidAnimatorEasing.\(String(describing: easing))`. The default duration (\(defaultDuration)) will be used." /** swiftlint:disable:this line_length */
        case .invalidInitialFrameDimension:
            return "The argument `layouts` of `FluidFrameDimension(origin:size:layouts:)` declared in the source view controller delegate will be ignored."
        case .invalidFinalFrameDimension:
            return "`FluidFrameDimension(origin:size:layouts:)` generated in the source view controller delegate needs to set all the values of `origin`, `size` and `layouts`."
        case .invalidResizeConfiguration:
            return "The resizing interaction is available for only the bottom drawer on the current version."
        }
    }

    /** The function that print the error message. */
    func printMessage() {
        switch self {
        case .invalidReference, .invalidResizeConfiguration:
            print("❌️ [Fluidable]", self.description, "The transition is cancelled.", "\n")
        case .unsupportedPresentationEasing, .unsupportedDismissalEasing:
            print("❌️ [Fluidable]", self.description, "The transition is cancelled.", "\n")
            print(FluidAnimatorEasing.easingDescription)
        case .ignoredPresentationDuration, .ignoredDismissalDuration, .invalidInitialFrameDimension, .invalidFinalFrameDimension:
            print("⚠️ [Fluidable]", self.description, "\n")
        }
    }
}
