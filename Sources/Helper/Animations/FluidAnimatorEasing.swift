//
//  FluidAnimatorEasing.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations of easing that compatible to `FluidCoreAnimator` and `FluidPropertyAnimator`.
 <h4>Available Types for Animation</h4>
 `linear`, `easeIn`, `easeOut`, `easeInOut`, `easeInSine`, `easeOutSine`, `easeInOutSine`, `easeInQuad`, `easeOutQuad`, `easeInOutQuad`, `easeInCubic`, `easeOutCubic`, `easeInOutCubic`, `easeInQuart`, `easeOutQuart`, `easeInOutQuart`, `easeInQuint`, `easeOutQuint`, `easeInOutQuint`, `easeInExpo`, `easeOutExpo`, `easeInOutExpo`, `easeInCirc`, `easeOutCirc`, `easeInOutCirc`, `easeInBack`, `easeOutBack`, `easeInOutBack`, `cubicBezier(c1x:c1y:c2x:c2y:)`, `spring(dampingRatio:frequencyResponse:)`
 <p>⚠️ The following types are NOT available for the transition animation on iOS 10.</p>
 `easeInCubic`, `easeOutCubic`, `easeInOutCubic`, `easeInQuart`, `easeOutQuart`, `easeInOutQuart`, `easeInQuint`, `easeOutQuint`, `easeInOutQuint`, `easeInExpo`, `easeOutExpo`, `easeInOutExpo`, `easeInCirc`, `easeOutCirc`, `easeInOutCirc`, `easeInBack`, `easeOutBack`, `easeInOutBack`, `spring(dampingRatio:,frequencyResponse:)`.
 */
public enum FluidAnimatorEasing {
    case linear,
         easeIn, easeOut, easeInOut,
         easeInSine, easeOutSine, easeInOutSine,
         easeInQuad, easeOutQuad, easeInOutQuad,
         easeInCubic, easeOutCubic, easeInOutCubic,
         easeInQuart, easeOutQuart, easeInOutQuart,
         easeInQuint, easeOutQuint, easeInOutQuint,
         easeInExpo, easeOutExpo, easeInOutExpo,
         easeInCirc, easeOutCirc, easeInOutCirc,
         easeInBack, easeOutBack, easeInOutBack,
         cubicBezier(c1x: CGFloat, c1y: CGFloat, c2x: CGFloat, c2y: CGFloat)
    case spring(mass: CGFloat, stiffness: CGFloat, damping: CGFloat, velocity: CGVector)

    /**
     This spring easing allows you to creates a damped harmonic spring using the specified design-friendly parameters.<br/>
     Please read [the documentation](https://github.com/jenox/UIKit-Playground/tree/master/01-Demystifying-UIKit-Spring-Animations) to configure the spring animation.

     - parameter dampingRatio: The ratio of the actual damping coefficient to the critical damping coefficient.
     - parameter frequencyResponse: The duration of one period in the undamped system, measured in seconds.
     */
    public static func spring(dampingRatio: CGFloat, frequencyResponse: CGFloat) -> FluidAnimatorEasing {
        let params: UISpringTimingParameters.SpringParameters = UISpringTimingParameters.parameters(dampingRatio: dampingRatio,
                                                                                                    frequencyResponse: frequencyResponse)
        return FluidAnimatorEasing.spring(mass: params.mass, stiffness: params.stiffness, damping: params.damping, velocity: params.velocity)
    }
    /** The default spring easing. (dampingRatio: 0.7, frequencyResponse: 0.5) */
    public static var spring: FluidAnimatorEasing {
        return .spring(dampingRatio: FluidConst.springDampingRatio, frequencyResponse: FluidConst.springFrequencyResponse)
    }
}

extension FluidAnimatorEasing {
    /** The `UITimingCurveProvider` value for `UIViewPropertyAnimator`. */
    public var timingParameters: UITimingCurveProvider {
        switch self {
        case .linear:         return UICubicTimingParameters(animationCurve: .linear)
        case .easeIn:         return UICubicTimingParameters(animationCurve: .easeIn)
        case .easeOut:        return UICubicTimingParameters(animationCurve: .easeOut)
        case .easeInOut:      return UICubicTimingParameters(animationCurve: .easeInOut)
        case .easeInSine:     return UICubicTimingParameters(0.47, 0, 0.745, 0.715)
        case .easeOutSine:    return UICubicTimingParameters(0.39, 0.575, 0.565, 1)
        case .easeInOutSine:  return UICubicTimingParameters(0.455, 0.03, 0.515, 0.955)
        case .easeInQuad:     return UICubicTimingParameters(0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad:    return UICubicTimingParameters(0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad:  return UICubicTimingParameters(0.455, 0.03, 0.515, 0.955)
        case .easeInCubic:    return UICubicTimingParameters(0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic:   return UICubicTimingParameters(0.215, 0.61, 0.355, 1)
        case .easeInOutCubic: return UICubicTimingParameters(0.645, 0.045, 0.355, 1)
        case .easeInQuart:    return UICubicTimingParameters(0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart:   return UICubicTimingParameters(0.165, 0.84, 0.44, 1)
        case .easeInOutQuart: return UICubicTimingParameters(0.77, 0, 0.175, 1)
        case .easeInQuint:    return UICubicTimingParameters(0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint:   return UICubicTimingParameters(0.23, 1, 0.32, 1)
        case .easeInOutQuint: return UICubicTimingParameters(0.86, 0, 0.07, 1)
        case .easeInExpo:     return UICubicTimingParameters(0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo:    return UICubicTimingParameters(0.19, 1, 0.22, 1)
        case .easeInOutExpo:  return UICubicTimingParameters(1, 0, 0, 1)
        case .easeInCirc:     return UICubicTimingParameters(0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc:    return UICubicTimingParameters(0.075, 0.82, 0.165, 1)
        case .easeInOutCirc:  return UICubicTimingParameters(0.785, 0.135, 0.15, 0.86)
        case .easeInBack:     return UICubicTimingParameters(0.6, -0.28, 0.735, 0.045)
        case .easeOutBack:    return UICubicTimingParameters(0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack:  return UICubicTimingParameters(0.68, -0.55, 0.265, 1.55)
        case .cubicBezier(let c1x, let c1y, let c2x, let c2y):
            return UICubicTimingParameters(c1x, c1y, c2x, c2y)
        case .spring(let mass, let stiffness, let damping, let velocity):
            return UISpringTimingParameters(mass: mass, stiffness: stiffness, damping: damping, initialVelocity: velocity)
        }
    }

    /** The `CAMediaTimingFunction` value for `CAAnimation`. */
    public var timingFunction: CAMediaTimingFunction? {
        switch self {
        case .linear:         return CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        case .easeIn:         return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeIn)
        case .easeOut:        return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        case .easeInOut:      return CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        case .easeInSine:     return CAMediaTimingFunction(controlPoints: 0.47, 0, 0.745, 0.715)
        case .easeOutSine:    return CAMediaTimingFunction(controlPoints: 0.39, 0.575, 0.565, 1)
        case .easeInOutSine:  return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
        case .easeInQuad:     return CAMediaTimingFunction(controlPoints: 0.55, 0.085, 0.68, 0.53)
        case .easeOutQuad:    return CAMediaTimingFunction(controlPoints: 0.25, 0.46, 0.45, 0.94)
        case .easeInOutQuad:  return CAMediaTimingFunction(controlPoints: 0.455, 0.03, 0.515, 0.955)
        case .easeInCubic:    return CAMediaTimingFunction(controlPoints: 0.55, 0.055, 0.675, 0.19)
        case .easeOutCubic:   return CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
        case .easeInOutCubic: return CAMediaTimingFunction(controlPoints: 0.645, 0.045, 0.355, 1)
        case .easeInQuart:    return CAMediaTimingFunction(controlPoints: 0.895, 0.03, 0.685, 0.22)
        case .easeOutQuart:   return CAMediaTimingFunction(controlPoints: 0.165, 0.84, 0.44, 1)
        case .easeInOutQuart: return CAMediaTimingFunction(controlPoints: 0.77, 0, 0.175, 1)
        case .easeInQuint:    return CAMediaTimingFunction(controlPoints: 0.755, 0.05, 0.855, 0.06)
        case .easeOutQuint:   return CAMediaTimingFunction(controlPoints: 0.23, 1, 0.32, 1)
        case .easeInOutQuint: return CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)
        case .easeInExpo:     return CAMediaTimingFunction(controlPoints: 0.95, 0.05, 0.795, 0.035)
        case .easeOutExpo:    return CAMediaTimingFunction(controlPoints: 0.19, 1, 0.22, 1)
        case .easeInOutExpo:  return CAMediaTimingFunction(controlPoints: 1, 0, 0, 1)
        case .easeInCirc:     return CAMediaTimingFunction(controlPoints: 0.6, 0.04, 0.98, 0.335)
        case .easeOutCirc:    return CAMediaTimingFunction(controlPoints: 0.075, 0.82, 0.165, 1)
        case .easeInOutCirc:  return CAMediaTimingFunction(controlPoints: 0.785, 0.135, 0.15, 0.86)
        case .easeInBack:     return CAMediaTimingFunction(controlPoints: 0.6, -0.28, 0.735, 0.045)
        case .easeOutBack:    return CAMediaTimingFunction(controlPoints: 0.175, 0.885, 0.32, 1.275)
        case .easeInOutBack:  return CAMediaTimingFunction(controlPoints: 0.68, -0.55, 0.265, 1.55)
        case .cubicBezier(let c1x, let c1y, let c2x, let c2y):
            return CAMediaTimingFunction(controlPoints: Float(c1x), Float(c1y), Float(c2x), Float(c2y))
        case .spring: return nil
        }
    }
}

extension FluidAnimatorEasing {
    internal func defaultDuration(_ fromFrame: CGRect, _ toFrame: CGRect, isPresenting: Bool) -> TimeInterval {
        let distance: CGFloat = fromFrame.origin.distance(to: toFrame.origin)
        let length: CGFloat = UIScreen.main.bounds.size.isPortrait ? UIScreen.main.bounds.size.height : UIScreen.main.bounds.size.width
        let baseDuration: CGFloat = 0.34
        let distanceBasedDuration: TimeInterval = TimeInterval(max(baseDuration * distance / length, baseDuration))
        let factor: TimeInterval = isPresenting ? 1.0 : 0.8
        switch self {
        case .linear:         return distanceBasedDuration * factor
        case .easeIn:         return distanceBasedDuration * factor
        case .easeOut:        return distanceBasedDuration * factor
        case .easeInOut:      return distanceBasedDuration * factor
        case .easeInSine:     return distanceBasedDuration * factor
        case .easeOutSine:    return distanceBasedDuration * factor
        case .easeInOutSine:  return distanceBasedDuration * factor
        case .easeInQuad:     return distanceBasedDuration * factor
        case .easeOutQuad:    return distanceBasedDuration * factor
        case .easeInOutQuad:  return distanceBasedDuration * factor
        case .easeInCubic:    return distanceBasedDuration * factor
        case .easeOutCubic:   return distanceBasedDuration * factor
        case .easeInOutCubic: return distanceBasedDuration * factor
        case .easeInQuart:    return distanceBasedDuration * factor
        case .easeOutQuart:   return distanceBasedDuration * factor
        case .easeInOutQuart: return distanceBasedDuration * factor
        case .easeInQuint:    return distanceBasedDuration * factor
        case .easeOutQuint:   return distanceBasedDuration * factor
        case .easeInOutQuint: return distanceBasedDuration * factor
        case .easeInExpo:     return distanceBasedDuration * factor
        case .easeOutExpo:    return distanceBasedDuration * factor
        case .easeInOutExpo:  return distanceBasedDuration * factor
        case .easeInCirc:     return distanceBasedDuration * factor
        case .easeOutCirc:    return distanceBasedDuration * factor
        case .easeInOutCirc:  return distanceBasedDuration * factor
        case .easeInBack:     return distanceBasedDuration * factor
        case .easeOutBack:    return distanceBasedDuration * factor
        case .easeInOutBack:  return distanceBasedDuration * factor
        case .cubicBezier:   return distanceBasedDuration * factor
        case .spring(let mass, let stiffness, let damping, let velocity):
            return UISpringTimingParameters.duration(mass: mass, stiffness: stiffness, damping: damping, velocity: velocity)
        }
    }
}

internal extension FluidAnimatorEasing {
    var isAvailable: Bool {
        if FluidConst.isNewerSystemVersion {
            return true
        } else {
            switch self {
            case .easeInBack, .easeOutBack, .easeInOutBack, .spring: return false
            default: return true
            }
        }
    }
}

internal extension FluidAnimatorEasing {
    static var easingDescription: String {
        return """
               Available easing types for iOS 10.

                 .linear,
                 .easeIn, .easeOut, .easeInOut,
                 .easeInSine, .easeOutSine, .easeInOutSine,
                 .easeInQuad, .easeOutQuad, .easeInOutQuad,
                 .easeInCubic, .easeOutCubic, .easeInOutCubic,
                 .easeInQuart, .easeOutQuart, .easeInOutQuart,
                 .easeInQuint, .easeOutQuint, .easeInOutQuint,
                 .easeInExpo, .easeOutExpo, .easeInOutExpo,
                 .easeInCirc, .easeOutCirc, .easeInOutCirc,
                 .cubicBezier(c1x: CGFloat, c1y: CGFloat, c2x: CGFloat, c2y: CGFloat)

               Available easing types for iOS 11 or later.

                 .linear,
                 .easeIn, .easeOut, .easeInOut,
                 .easeInSine, .easeOutSine, .easeInOutSine,
                 .easeInQuad, .easeOutQuad, .easeInOutQuad,
                 .easeInCubic, .easeOutCubic, .easeInOutCubic,
                 .easeInQuart, .easeOutQuart, .easeInOutQuart,
                 .easeInQuint, .easeOutQuint, .easeInOutQuint,
                 .easeInExpo, .easeOutExpo, .easeInOutExpo,
                 .easeInCirc, .easeOutCirc, .easeInOutCirc,
                 .easeInBack, .easeOutBack, .easeInOutBack,
                 .cubicBezier(c1x: CGFloat, c1y: CGFloat, c2x: CGFloat, c2y: CGFloat),
                 .spring(mass: CGFloat, stiffness: CGFloat, damping: CGFloat, velocity: CGVector)

               """
    }
}

extension FluidAnimatorEasing: Equatable {
    /** The function that conforms to `Equatable`. */
    public static func == (lhs: FluidAnimatorEasing, rhs: FluidAnimatorEasing) -> Bool {
        return lhs.description == rhs.description
    }

    public var isSpring: Bool {
        switch self {
        case .spring: return true
        default:      return false
        }
    }
}

extension FluidAnimatorEasing: CustomStringConvertible {
    /** The description. */
    public var description: String {
        switch self {
        case .linear:         return "linear"
        case .easeIn:         return "easeIn"
        case .easeOut:        return "easeOut"
        case .easeInOut:      return "easeInOut"
        case .easeInSine:     return "easeInSine"
        case .easeOutSine:    return "easeOutSine"
        case .easeInOutSine:  return "easeInOutSine"
        case .easeInQuad:     return "easeInQuad"
        case .easeOutQuad:    return "easeOutQuad"
        case .easeInOutQuad:  return "easeInOutQuad"
        case .easeInCubic:    return "easeInCubic"
        case .easeOutCubic:   return "easeOutCubic"
        case .easeInOutCubic: return "easeInOutCubic"
        case .easeInQuart:    return "easeInQuart"
        case .easeOutQuart:   return "easeOutQuart"
        case .easeInOutQuart: return "easeInOutQuart"
        case .easeInQuint:    return "easeInQuint"
        case .easeOutQuint:   return "easeOutQuint"
        case .easeInOutQuint: return "easeInOutQuint"
        case .easeInExpo:     return "easeInExpo"
        case .easeOutExpo:    return "easeOutExpo"
        case .easeInOutExpo:  return "easeInOutExpo"
        case .easeInCirc:     return "easeInCirc"
        case .easeOutCirc:    return "easeOutCirc"
        case .easeInOutCirc:  return "easeInOutCirc"
        case .easeInBack:     return "easeInBack"
        case .easeOutBack:    return "easeOutBack"
        case .easeInOutBack:  return "easeInOutBack"
        case .cubicBezier(let c1x, let c1y, let c2x, let c2y):
            return "custom(c1x:\(c1x), c1y:\(c1y), c2x:\(c2x), c2y:\(c2y))"
        case .spring(let mass, let stiffness, let damping, let velocity):
            return "spring(\(mass), \(stiffness), \(damping), \(velocity))"
        }
    }
}
