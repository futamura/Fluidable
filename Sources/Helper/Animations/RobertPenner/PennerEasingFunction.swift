//
//  PennerEasingFunction.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
   The attributes of an Element.

   Attributes are treated as a map: there can be only one value associated with an attribute key/name.
   Attribute name and value comparisons are  <b>case sensitive</b>. By default for HTML, attribute names are
   normalized to lower-case on parsing. That means you should use lower-case strings when referring to attributes by
   name.

   [Robert Penner's Easing Functions](http://robertpenner.com/easing/)
   [easings.net](https://easings.net)
 */

/**
 Normal easing function
 - parameter t: The time (either frames or in seconds)
 - parameter b: The beginning value
 - parameter c: The value changed
 - parameter d: The duration time (in seconds)
 - parameter s: The default overshoot is 10% (1.70158)
 - returns: The eased value
*/
internal typealias NormalEasing = (_ t: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat) -> CGFloat

/**
 Advanced back easing function
 - parameter t: The time (either frames or in seconds)
 - parameter b: The beginning value
 - parameter c: The value changed
 - parameter d: The duration time (in seconds)
 - parameter s: The default overshoot is 10% (1.70158)
 - returns: The eased value
 */
internal typealias AdvancedBackEasing = (_ t: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat, _ s: CGFloat) -> CGFloat

/**
 Advanced elastic easing function
 - parameter t: The time (either frames or in seconds)
 - parameter b: The beginning value
 - parameter c: The value changed
 - parameter d: The duration time (in seconds)
 - parameter s: The default overshoot is 10% (1.70158)
 - returns: The eased value
 */
internal typealias AdvancedElasticEasing = (_ t: CGFloat, _ b: CGFloat, _ c: CGFloat, _ d: CGFloat, _ a: CGFloat, _ p: CGFloat) -> CGFloat

/**
 Easing equation
 */
internal struct PennerEasingFunction {
}

extension PennerEasingFunction {
    static var easeInBack: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let s: CGFloat = 1.70158
        let t: CGFloat = t / d
        return c * t * t * ((s + 1) * t - s) + b
    }

    static var easeOutBack: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let s: CGFloat = 1.70158
        let t = t / d - 1
        return c * (t * t * ((s + 1) * t + s) + 1) + b
    }

    static var easeInOutBack: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var s: CGFloat = 1.70158
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            s *= (1.525)
            return c / 2 * (t * t * ((s + 1) * t - s)) + b
        }
        s *= 1.525
        t -= 2
        return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
    }

    static var easeInBackAdvanced: AdvancedBackEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, s: CGFloat) -> CGFloat in
        let t = t / d
        return c * t * t * ((s + 1) * t - s) + b
    }

    static var easeOutBackAdvanced: AdvancedBackEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, s: CGFloat) -> CGFloat in
        let t = t / d - 1
        return c * (t * t * ((s + 1) * t + s) + 1) + b
    }

    static var easeInOutBackAdvanced: AdvancedBackEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, s: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        var s: CGFloat = s
        if t < 1 {
            s *= 1.525
            return c / 2 * (t * t * ((s + 1) * t - s)) + b
        }
        s *= 1.525
        t -= 2
        return c / 2 * (t * t * ((s + 1) * t + s) + 2) + b
    }
}

extension PennerEasingFunction {
    static var easeInBounce: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return c - easeOutBounce(d - t, b, c, d) + b
    }

    static var easeOutBounce: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / d
        if t < (1 / 2.75) {
            return c * (7.5625 * t * t) + b
        } else if t < (2 / 2.75) {
            t -= 1.5 / 2.75
            return c * (7.5625 * t * t + 0.75) + b
        } else if t < (2.5 / 2.75) {
            t -= 2.25 / 2.75
            return c * (7.5625 * t * t + 0.9375) + b
        } else {
            t -= 2.625 / 2.75
            return c * (7.5625 * t * t + 0.984375) + b
        }
    }

    static var easeInOutBounce: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t
        if t < d / 2 {
            return easeInBounce(t * 2, 0, c, d) * 0.5 + b
        }
        return easeOutBounce(t * 2 - d, 0, c, d) * 0.5 + c * 0.5 + b
    }
}

extension PennerEasingFunction {
    static var easeInCirc: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return -c * (sqrt(1 - t * t) - 1) + b
    }

    static var easeOutCirc: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t = t / d - 1
        return c * sqrt(1 - t * t) + b
    }

    static var easeInOutCirc: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            return -c / 2 * (sqrt(1 - t * t) - 1) + b
        }
        t -= 2
        return c / 2 * (sqrt(1 - t * t) + 1) + b
    }
}

extension PennerEasingFunction {
    static var easeInCubic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return c * t * t * t + b
    }

    static var easeOutCubic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t = t / d - 1
        return c * (t * t * t + 1) + b
    }

    static var easeInOutCubic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t + b
        }
        t -= 2
        return c / 2 * (t * t * t + 2) + b
    }
}

extension PennerEasingFunction {
    static var easeInElastic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t

        if t == 0 { return b }
        t /= d
        if t == 1 { return b + c }

        let p: CGFloat = d * 0.3
        let a: CGFloat = c
        let s: CGFloat = p / 4

        t -= 1
        return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p)) + b
    }

    static var easeOutElastic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t

        if t == 0 { return b }
        t /= d
        if t == 1 { return b + c }

        let p: CGFloat = d * 0.3
        let a: CGFloat = c
        let s: CGFloat = p / 4

        return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p) + c + b)
    }

    static var easeInOutElastic: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t
        if t == 0 { return b }

        t = t / (d / 2)
        if t == 2 { return b + c }

        let p = d * (0.3 * 1.5)
        let a: CGFloat = c
        let s = p / 4

        if t < 1 {
            t -= 1
            return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p)) + b
        }
        t -= 1
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p) * 0.5 + c + b
    }

    static var easeInElasticAdvanced: AdvancedElasticEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, a: CGFloat, p: CGFloat) -> CGFloat in
        var t: CGFloat = t
        var a: CGFloat = a
        var p: CGFloat = p
        var s: CGFloat = 0.0

        if t == 0 { return b }

        t /= d
        if t == 1 { return b + c }

        if a < abs(c) {
            a = c
            s = p / 4
        } else {
            s = p / (2 * CGFloat.pi) * asin(c / a)
        }

        t -= 1
        return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p)) + b
    }

    static var easeOutElasticAdvanced: AdvancedElasticEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, a: CGFloat, p: CGFloat) -> CGFloat in
        var s: CGFloat = 0.0
        var t: CGFloat = t
        var a: CGFloat = a
        var p: CGFloat = p

        if t == 0 { return b }

        t /= d
        if t == 1 { return b + c }

        if a < abs(c) {
            a = c
            s = p / 4
        } else {
            s = p / (2 * CGFloat.pi) * asin(c / a)
        }
        return (a * pow(2, -10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p) + c + b)
    }

    static var easeInOutElasticAdvanced: AdvancedElasticEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat, a: CGFloat, p: CGFloat) -> CGFloat in
        var s: CGFloat = 0.0
        var t: CGFloat = t
        var a: CGFloat = a
        var p: CGFloat = p

        if t == 0 { return b }

        t /= d / 2

        if t == 2 { return b + c }

        if a < abs(c) {
            a = c
            s = p / 4
        } else {
            s = p / (2 * CGFloat.pi) * asin(c / a)
        }

        if t < 1 {
            t -= 1
            return -0.5 * (a * pow(2, 10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p)) + b
        }
        t -= 1
        return a * pow(2, -10 * t) * sin((t * d - s) * (2 * CGFloat.pi) / p) * 0.5 + c + b
    }
}

extension PennerEasingFunction {
    static var easeInExpo: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b
    }

    static var easeOutExpo: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b
    }

    static var easeInOutExpo: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        if t == 0 { return b }
        if t == d { return b + c }

        var t: CGFloat = t / (d / 2)

        if t < 1 {
            return c / 2 * pow(2, 10 * (t - 1)) + b
        }
        let t1 = t - 1
        return c / 2 * (-pow(2, -10 * t1) + 2) + b
    }
}

extension PennerEasingFunction {
    static var linear: NormalEasing = { (t, b, c, d) -> CGFloat in
        return c * (t / d) + b
    }
}

extension PennerEasingFunction {
    static var easeInQuad: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return c * t * t + b
    }

    static var easeOutQuad: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return -c * t * (t - 2) + b
    }

    static var easeInOutQuad: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t + b
        }
        let t1 = t - 1
        let t2 = t1 - 2
        return -c / 2 * ((t1) * (t2) - 1) + b
    }
}

extension PennerEasingFunction {
    static var easeInQuart: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return c * t * t * t * t + b
    }

    static var easeOutQuart: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t = t / d - 1
        return -c * (t * t * t * t - 1) + b
    }

    static var easeInOutQuart: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t * t + b
        }
        t -= 2
        return -c / 2 * (t * t * t * t - 2) + b
    }
}

extension PennerEasingFunction {
    static var easeInQuint: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t: CGFloat = t / d
        return c * t * t * t * t * t + b
    }

    static var easeOutQuint: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        let t = t / d - 1
        return c * (t * t * t * t * t + 1) + b
    }

    static var easeInOutQuint: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        var t: CGFloat = t / (d / 2)
        if t < 1 {
            return c / 2 * t * t * t * t * t + b
        }
        t -= 2
        return c / 2 * (t * t * t * t * t + 2) + b
    }
}

extension PennerEasingFunction {
    static var easeInSine: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return -c * cos(t / d * (CGFloat.pi / 2)) + c + b
    }

    static var easeOutSine: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return c * sin(t / d * (CGFloat.pi / 2)) + b
    }

    static var easeInOutSine: NormalEasing = { (t: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CGFloat in
        return -c / 2 * (cos(CGFloat.pi * t / d) - 1) + b
    }
}
