//
//  PennerEasing.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations that declares Robert Penner`s easing.
 <h4>Available easting types</h4>
 `linear`, `easeInCirc`, `easeOutCirc`, `easeInOutCirc`, `easeInCubic`, `easeOutCubic`, `easeInOutCubic`, `easeInExpo`, `easeOutExpo`, `easeInOutExpo`, `easeInQuad`, `easeOutQuad`, `easeInOutQuad`, `easeInQuart`, `easeOutQuart`, `easeInOutQuart`, `easeInQuint`, `easeOutQuint`, `easeInOutQuint`, `easeInSine`, `easeOutSine`, `easeInOutSine`, `easeInBack`, `easeOutBack`, `easeInOutBack`, `easeInBackAdvanced(CGFloat)`, `easeOutBackAdvanced(CGFloat)`, `easeInOutBackAdvanced(CGFloat)`, `easeInBounce`, `easeOutBounce`, `easeInOutBounce`, `easeInElastic`, `easeOutElastic`, `easeInOutElastic`, `easeInElasticAdvanced(CGFloat, CGFloat)`, `easeOutElasticAdvanced(CGFloat, CGFloat)`, `easeInOutElasticAdvanced(CGFloat, CGFloat)`
 */
public enum PennerEasing {
    case linear
    case easeInCirc, easeOutCirc, easeInOutCirc
    case easeInCubic, easeOutCubic, easeInOutCubic
    case easeInExpo, easeOutExpo, easeInOutExpo
    case easeInQuad, easeOutQuad, easeInOutQuad
    case easeInQuart, easeOutQuart, easeInOutQuart
    case easeInQuint, easeOutQuint, easeInOutQuint
    case easeInSine, easeOutSine, easeInOutSine
    case easeInBack, easeOutBack, easeInOutBack
    case easeInBackAdvanced(CGFloat), easeOutBackAdvanced(CGFloat), easeInOutBackAdvanced(CGFloat)
    case easeInBounce, easeOutBounce, easeInOutBounce
    case easeInElastic, easeOutElastic, easeInOutElastic
    case easeInElasticAdvanced(CGFloat, CGFloat), easeOutElasticAdvanced(CGFloat, CGFloat), easeInOutElasticAdvanced(CGFloat, CGFloat)
}

public extension PennerEasing {
    /**
     The function that calculates eased value.

     - parameter time: The current time value, measured in seconds.
     - parameter duration: The total duration value, measured in seconds.
     - parameter begin: The beginning value.
     - parameter end: The ending value.
     - return: The eased value.
     */
    func calculate(_ time: CGFloat, _ duration: CGFloat, begin: CGFloat, end: CGFloat) -> CGFloat {
        return self.calculate(time, duration, begin: begin, change: end - begin)
    }

    /**
     The function that calculates eased value.

     - parameter time: The current time value, measured in seconds.
     - parameter duration: The total duration value, measured in seconds.
     - parameter begin: The beginning value.
     - parameter change: The value changed from the beginning.
     - return: The eased value.
     */
    func calculate(_ time: CGFloat, _ duration: CGFloat, begin: CGFloat, change: CGFloat) -> CGFloat {
        switch self {
        case .linear:           return PennerEasingFunction.linear(time, begin, change, duration)
        case .easeInCirc:       return PennerEasingFunction.easeInCirc(time, begin, change, duration)
        case .easeOutCirc:      return PennerEasingFunction.easeOutCirc(time, begin, change, duration)
        case .easeInOutCirc:    return PennerEasingFunction.easeInOutCirc(time, begin, change, duration)
        case .easeInCubic:      return PennerEasingFunction.easeInCubic(time, begin, change, duration)
        case .easeOutCubic:     return PennerEasingFunction.easeOutCubic(time, begin, change, duration)
        case .easeInOutCubic:   return PennerEasingFunction.easeInOutCubic(time, begin, change, duration)
        case .easeInExpo:       return PennerEasingFunction.easeInExpo(time, begin, change, duration)
        case .easeOutExpo:      return PennerEasingFunction.easeOutExpo(time, begin, change, duration)
        case .easeInOutExpo:    return PennerEasingFunction.easeInOutExpo(time, begin, change, duration)
        case .easeInQuad:       return PennerEasingFunction.easeInQuad(time, begin, change, duration)
        case .easeOutQuad:      return PennerEasingFunction.easeOutQuad(time, begin, change, duration)
        case .easeInOutQuad:    return PennerEasingFunction.easeInOutQuad(time, begin, change, duration)
        case .easeInQuart:      return PennerEasingFunction.easeInQuart(time, begin, change, duration)
        case .easeOutQuart:     return PennerEasingFunction.easeOutQuart(time, begin, change, duration)
        case .easeInOutQuart:   return PennerEasingFunction.easeInOutQuart(time, begin, change, duration)
        case .easeInQuint:      return PennerEasingFunction.easeInQuint(time, begin, change, duration)
        case .easeOutQuint:     return PennerEasingFunction.easeOutQuint(time, begin, change, duration)
        case .easeInOutQuint:   return PennerEasingFunction.easeInOutQuint(time, begin, change, duration)
        case .easeInSine:       return PennerEasingFunction.easeInSine(time, begin, change, duration)
        case .easeOutSine:      return PennerEasingFunction.easeOutSine(time, begin, change, duration)
        case .easeInOutSine:    return PennerEasingFunction.easeInOutSine(time, begin, change, duration)
        case .easeInBack:       return PennerEasingFunction.easeInBack(time, begin, change, duration)
        case .easeInBackAdvanced(let s):    return PennerEasingFunction.easeInBackAdvanced(time, begin, change, duration, s)
        case .easeOutBackAdvanced(let s):   return PennerEasingFunction.easeOutBackAdvanced(time, begin, change, duration, s)
        case .easeInOutBackAdvanced(let s): return PennerEasingFunction.easeInOutBackAdvanced(time, begin, change, duration, s)
        case .easeOutBack:      return PennerEasingFunction.easeOutBack(time, begin, change, duration)
        case .easeInOutBack:    return PennerEasingFunction.easeInOutBack(time, begin, change, duration)
        case .easeInBounce:     return PennerEasingFunction.easeInBounce(time, begin, change, duration)
        case .easeOutBounce:    return PennerEasingFunction.easeOutBounce(time, begin, change, duration)
        case .easeInOutBounce:  return PennerEasingFunction.easeInOutBounce(time, begin, change, duration)
        case .easeInElastic:    return PennerEasingFunction.easeInElastic(time, begin, change, duration)
        case .easeOutElastic:   return PennerEasingFunction.easeOutElastic(time, begin, change, duration)
        case .easeInOutElastic: return PennerEasingFunction.easeInOutElastic(time, begin, change, duration)
        case .easeInElasticAdvanced(let a, let p):    return PennerEasingFunction.easeInElasticAdvanced(time, begin, change, duration, a, p)
        case .easeOutElasticAdvanced(let a, let p):   return PennerEasingFunction.easeOutElasticAdvanced(time, begin, change, duration, a, p)
        case .easeInOutElasticAdvanced(let a, let p): return PennerEasingFunction.easeInOutElasticAdvanced(time, begin, change, duration, a, p)
        }
    }
}

extension PennerEasing: Equatable {
    /** The function that conforms to `Equatable`. */
    public static func == (lhs: PennerEasing, rhs: PennerEasing) -> Bool {
        return lhs.description == rhs.description
    }
}

extension PennerEasing: CustomStringConvertible {
    /** The description. */
    public var description: String {
        switch self {
        case .linear:           return "linear"
        case .easeInCirc:       return "easeInCirc"
        case .easeOutCirc:      return "easeOutCirc"
        case .easeInOutCirc:    return "easeInOutCirc"
        case .easeInCubic:      return "easeInCubic"
        case .easeOutCubic:     return "easeOutCubic"
        case .easeInOutCubic:   return "easeInOutCubic"
        case .easeInExpo:       return "easeInExpo"
        case .easeOutExpo:      return "easeOutExpo"
        case .easeInOutExpo:    return "easeInOutExpo"
        case .easeInQuad:       return "easeInQuad"
        case .easeOutQuad:      return "easeOutQuad"
        case .easeInOutQuad:    return "easeInOutQuad"
        case .easeInQuart:      return "easeInQuart"
        case .easeOutQuart:     return "easeOutQuart"
        case .easeInOutQuart:   return "easeInOutQuart"
        case .easeInQuint:      return "easeInQuint"
        case .easeOutQuint:     return "easeOutQuint"
        case .easeInOutQuint:   return "easeInOutQuint"
        case .easeInSine:       return "easeInSine"
        case .easeOutSine:      return "easeOutSine"
        case .easeInOutSine:    return "easeInOutSine"
        case .easeInElastic:    return "easeInElastic"
        case .easeOutElastic:   return "easeOutElastic"
        case .easeInOutElastic: return "easeInOutElastic"
        case .easeInBack:       return "easeInBack"
        case .easeOutBack:      return "easeOutBack"
        case .easeInOutBack:    return "easeInOutBack"
        case .easeInBackAdvanced(let value):    return "easeInBackAdvanced(\(value))"
        case .easeOutBackAdvanced(let value):   return "easeOutBackAdvanced(\(value))"
        case .easeInOutBackAdvanced(let value): return "easeInOutBackAdvanced(\(value))"
        case .easeInBounce:     return "easeInBounce"
        case .easeOutBounce:    return "easeOutBounce"
        case .easeInOutBounce:  return "easeInOutBounce"
        case .easeInElasticAdvanced(let value1, let value2):    return "easeInElasticAdvanced(\(value1),\(value2))"
        case .easeOutElasticAdvanced(let value1, let value2):   return "easeOutElasticAdvanced(\(value1),\(value2))"
        case .easeInOutElasticAdvanced(let value1, let value2): return "easeInOutElasticAdvanced(\(value1),\(value2))"
        }
    }
}
