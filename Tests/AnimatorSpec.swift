//
//  AnimatorEnum.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/02.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import Fluidable

final class AnimatorSpec: QuickSpec {
    override class func spec() {
        describe("Animator") {
            describe("FluidAnimatorEasing") {
                let linear: FluidAnimatorEasing = FluidAnimatorEasing.linear
                let easeIn: FluidAnimatorEasing = FluidAnimatorEasing.easeIn
                let easeOut: FluidAnimatorEasing = FluidAnimatorEasing.easeOut
                let easeInOut: FluidAnimatorEasing = FluidAnimatorEasing.easeInOut
                let easeInSine: FluidAnimatorEasing = FluidAnimatorEasing.easeInSine
                let easeOutSine: FluidAnimatorEasing = FluidAnimatorEasing.easeOutSine
                let easeInOutSine: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutSine
                let easeInQuad: FluidAnimatorEasing = FluidAnimatorEasing.easeInQuad
                let easeOutQuad: FluidAnimatorEasing = FluidAnimatorEasing.easeOutQuad
                let easeInOutQuad: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutQuad
                let easeInCubic: FluidAnimatorEasing = FluidAnimatorEasing.easeInCubic
                let easeOutCubic: FluidAnimatorEasing = FluidAnimatorEasing.easeOutCubic
                let easeInOutCubic: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutCubic
                let easeInQuart: FluidAnimatorEasing = FluidAnimatorEasing.easeInQuart
                let easeOutQuart: FluidAnimatorEasing = FluidAnimatorEasing.easeOutQuart
                let easeInOutQuart: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutQuart
                let easeInQuint: FluidAnimatorEasing = FluidAnimatorEasing.easeInQuint
                let easeOutQuint: FluidAnimatorEasing = FluidAnimatorEasing.easeOutQuint
                let easeInOutQuint: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutQuint
                let easeInExpo: FluidAnimatorEasing = FluidAnimatorEasing.easeInExpo
                let easeOutExpo: FluidAnimatorEasing = FluidAnimatorEasing.easeOutExpo
                let easeInOutExpo: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutExpo
                let easeInCirc: FluidAnimatorEasing = FluidAnimatorEasing.easeInCirc
                let easeOutCirc: FluidAnimatorEasing = FluidAnimatorEasing.easeOutCirc
                let easeInOutCirc: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutCirc
                let easeInBack: FluidAnimatorEasing = FluidAnimatorEasing.easeInBack
                let easeOutBack: FluidAnimatorEasing = FluidAnimatorEasing.easeOutBack
                let easeInOutBack: FluidAnimatorEasing = FluidAnimatorEasing.easeInOutBack
                let cubicBezier: FluidAnimatorEasing = FluidAnimatorEasing.cubicBezier(c1x: 0.47, c1y: 0, c2x: 0.745, c2y: 0.715)
                let spring: FluidAnimatorEasing = FluidAnimatorEasing.spring
                it("Conversion") {
                    expect(linear.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeIn.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOut.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOut.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInSine.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutSine.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutSine.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInQuad.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutQuad.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutQuad.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInCubic.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutCubic.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutCubic.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInQuart.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutQuart.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutQuart.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInQuint.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutQuint.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutQuint.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInExpo.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutExpo.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutExpo.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInCirc.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutCirc.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutCirc.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInBack.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeOutBack.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(easeInOutBack.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(cubicBezier.timingParameters).to(beAnInstanceOf(UICubicTimingParameters.self))
                    expect(spring.timingParameters).to(beAnInstanceOf(UISpringTimingParameters.self))
                    expect(linear.timingFunction).notTo(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeIn.timingFunction).notTo(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOut.timingFunction).notTo(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOut.timingFunction).notTo(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInSine.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutSine.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutSine.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInQuad.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutQuad.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutQuad.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInCubic.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutCubic.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutCubic.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInQuart.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutQuart.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutQuart.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInQuint.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutQuint.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutQuint.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInExpo.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutExpo.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutExpo.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInCirc.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutCirc.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutCirc.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInBack.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeOutBack.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(easeInOutBack.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(cubicBezier.timingFunction).to(beAnInstanceOf(CAMediaTimingFunction.self))
                    expect(spring.timingFunction).to(beNil())

                    let fromFrame: CGRect = CGRect(x: -768, y: 0, width: 768, height: 1024)
                    let toFrame: CGRect = CGRect(x: 0, y: 0, width: 768, height: 1024)
                    expect(linear.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeIn.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOut.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOut.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInSine.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutSine.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutSine.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInQuad.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutQuad.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutQuad.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInCubic.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutCubic.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutCubic.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInQuart.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutQuart.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutQuart.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInQuint.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutQuint.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutQuint.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInExpo.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutExpo.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutExpo.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInCirc.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutCirc.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutCirc.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInBack.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeOutBack.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(easeInOutBack.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(cubicBezier.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                    expect(spring.defaultDuration(fromFrame, toFrame, isPresenting: true)).to(beGreaterThan(0))
                }
                it("Condition") {
                    expect(linear.isSpring).to(beFalse())
                    expect(spring.isSpring).to(beTrue())
                    expect(linear.isAvailable).to(beTrue())
                    expect(easeIn.isAvailable).to(beTrue())
                    expect(easeOut.isAvailable).to(beTrue())
                    expect(easeInOut.isAvailable).to(beTrue())
                    expect(easeInSine.isAvailable).to(beTrue())
                    expect(easeOutSine.isAvailable).to(beTrue())
                    expect(easeInOutSine.isAvailable).to(beTrue())
                    expect(easeInQuad.isAvailable).to(beTrue())
                    expect(easeOutQuad.isAvailable).to(beTrue())
                    expect(easeInOutQuad.isAvailable).to(beTrue())
                    expect(easeInCubic.isAvailable).to(beTrue())
                    expect(easeOutCubic.isAvailable).to(beTrue())
                    expect(easeInOutCubic.isAvailable).to(beTrue())
                    expect(easeInQuart.isAvailable).to(beTrue())
                    expect(easeOutQuart.isAvailable).to(beTrue())
                    expect(easeInOutQuart.isAvailable).to(beTrue())
                    expect(easeInQuint.isAvailable).to(beTrue())
                    expect(easeOutQuint.isAvailable).to(beTrue())
                    expect(easeInOutQuint.isAvailable).to(beTrue())
                    expect(easeInExpo.isAvailable).to(beTrue())
                    expect(easeOutExpo.isAvailable).to(beTrue())
                    expect(easeInOutExpo.isAvailable).to(beTrue())
                    expect(easeInCirc.isAvailable).to(beTrue())
                    expect(easeOutCirc.isAvailable).to(beTrue())
                    expect(easeInOutCirc.isAvailable).to(beTrue())
                    if #available(iOS 11.0, *) {
                        expect(easeInBack.isAvailable).to(beTrue())
                        expect(easeOutBack.isAvailable).to(beTrue())
                        expect(easeInOutBack.isAvailable).to(beTrue())
                        expect(cubicBezier.isAvailable).to(beTrue())
                        expect(spring.isAvailable).to(beTrue())
                    } else {
                        expect(easeInBack.isAvailable).to(beFalse())
                        expect(easeOutBack.isAvailable).to(beFalse())
                        expect(easeInOutBack.isAvailable).to(beFalse())
                        expect(cubicBezier.isAvailable).to(beTrue())
                        expect(spring.isAvailable).to(beFalse())
                    }
                }
                it("Description") {
                    expect(String(describing: linear)).to(beginWith("linear"))
                    expect(String(describing: easeIn)).to(beginWith("easeIn"))
                    expect(String(describing: easeOut)).to(beginWith("easeOut"))
                    expect(String(describing: easeInOut)).to(beginWith("easeInOut"))
                    expect(String(describing: easeInSine)).to(beginWith("easeInSine"))
                    expect(String(describing: easeOutSine)).to(beginWith("easeOutSine"))
                    expect(String(describing: easeInOutSine)).to(beginWith("easeInOutSine"))
                    expect(String(describing: easeInQuad)).to(beginWith("easeInQuad"))
                    expect(String(describing: easeOutQuad)).to(beginWith("easeOutQuad"))
                    expect(String(describing: easeInOutQuad)).to(beginWith("easeInOutQuad"))
                    expect(String(describing: easeInCubic)).to(beginWith("easeInCubic"))
                    expect(String(describing: easeOutCubic)).to(beginWith("easeOutCubic"))
                    expect(String(describing: easeInOutCubic)).to(beginWith("easeInOutCubic"))
                    expect(String(describing: easeInQuart)).to(beginWith("easeInQuart"))
                    expect(String(describing: easeOutQuart)).to(beginWith("easeOutQuart"))
                    expect(String(describing: easeInOutQuart)).to(beginWith("easeInOutQuart"))
                    expect(String(describing: easeInQuint)).to(beginWith("easeInQuint"))
                    expect(String(describing: easeOutQuint)).to(beginWith("easeOutQuint"))
                    expect(String(describing: easeInOutQuint)).to(beginWith("easeInOutQuint"))
                    expect(String(describing: easeInExpo)).to(beginWith("easeInExpo"))
                    expect(String(describing: easeOutExpo)).to(beginWith("easeOutExpo"))
                    expect(String(describing: easeInOutExpo)).to(beginWith("easeInOutExpo"))
                    expect(String(describing: easeInCirc)).to(beginWith("easeInCirc"))
                    expect(String(describing: easeOutCirc)).to(beginWith("easeOutCirc"))
                    expect(String(describing: easeInOutCirc)).to(beginWith("easeInOutCirc"))
                    expect(String(describing: easeInBack)).to(beginWith("easeInBack"))
                    expect(String(describing: easeOutBack)).to(beginWith("easeOutBack"))
                    expect(String(describing: easeInOutBack)).to(beginWith("easeInOutBack"))
                    expect(String(describing: cubicBezier)).to(beginWith("custom"))
                    expect(String(describing: spring)).to(beginWith("spring"))
                    expect(String(describing: FluidAnimatorEasing.easingDescription)).notTo(beNil())
                }
            }
            describe("PennerEasing") {
                let linear: PennerEasing = .linear
                let easeInCirc: PennerEasing = .easeInCirc
                let easeOutCirc: PennerEasing = .easeOutCirc
                let easeInOutCirc: PennerEasing = .easeInOutCirc
                let easeInCubic: PennerEasing = .easeInCubic
                let easeOutCubic: PennerEasing = .easeOutCubic
                let easeInOutCubic: PennerEasing = .easeInOutCubic
                let easeInExpo: PennerEasing = .easeInExpo
                let easeOutExpo: PennerEasing = .easeOutExpo
                let easeInOutExpo: PennerEasing = .easeInOutExpo
                let easeInQuad: PennerEasing = .easeInQuad
                let easeOutQuad: PennerEasing = .easeOutQuad
                let easeInOutQuad: PennerEasing = .easeInOutQuad
                let easeInQuart: PennerEasing = .easeInQuart
                let easeOutQuart: PennerEasing = .easeOutQuart
                let easeInOutQuart: PennerEasing = .easeInOutQuart
                let easeInQuint: PennerEasing = .easeInQuint
                let easeOutQuint: PennerEasing = .easeOutQuint
                let easeInOutQuint: PennerEasing = .easeInOutQuint
                let easeInSine: PennerEasing = .easeInSine
                let easeOutSine: PennerEasing = .easeOutSine
                let easeInOutSine: PennerEasing = .easeInOutSine
                let easeInBack: PennerEasing = .easeInBack
                let easeOutBack: PennerEasing = .easeOutBack
                let easeInOutBack: PennerEasing = .easeInOutBack
                let easeInBackAdvanced: PennerEasing = .easeInBackAdvanced(0.1)
                let easeOutBackAdvanced: PennerEasing = .easeOutBackAdvanced(0.1)
                let easeInOutBackAdvanced: PennerEasing = .easeInOutBackAdvanced(0.1)
                let easeInBounce: PennerEasing = .easeInBounce
                let easeOutBounce: PennerEasing = .easeOutBounce
                let easeInOutBounce: PennerEasing = .easeInOutBounce
                let easeInElastic: PennerEasing = .easeInElastic
                let easeOutElastic: PennerEasing = .easeOutElastic
                let easeInOutElastic: PennerEasing = .easeInOutElastic
                let easeInElasticAdvanced: PennerEasing = .easeInElasticAdvanced(0.1, 0.1)
                let easeOutElasticAdvanced: PennerEasing = .easeOutElasticAdvanced(0.1, 0.1)
                let easeInOutElasticAdvanced: PennerEasing = .easeInOutElasticAdvanced(0.1, 0.1)
//                let step: CGFloat = 0.01
//                let duration: CGFloat = 1.0
//                let begin: CGFloat = 0.0
                let end: CGFloat = 100.0
                it("Calculate") {
                    expect(calculate(easing: linear, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInCirc, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutCirc, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutCirc, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInCubic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutCubic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutCubic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInExpo, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutExpo, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutExpo, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInQuad, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutQuad, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutQuad, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInQuart, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutQuart, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutQuart, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInQuint, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutQuint, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutQuint, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInSine, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutSine, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutSine, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInBack, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutBack, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutBack, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInBackAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutBackAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutBackAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInBounce, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutBounce, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutBounce, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInElastic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutElastic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutElastic, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInElasticAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeOutElasticAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                    expect(calculate(easing: easeInOutElasticAdvanced, end: end)).to(beCloseTo(end, within: 0.1))
                }
                it("Equation") {
                    expect(linear).to(equal(PennerEasing.linear))
                    expect(easeInCirc).to(equal(PennerEasing.easeInCirc))
                    expect(easeOutCirc).to(equal(PennerEasing.easeOutCirc))
                    expect(easeInOutCirc).to(equal(PennerEasing.easeInOutCirc))
                    expect(easeInCubic).to(equal(PennerEasing.easeInCubic))
                    expect(easeOutCubic).to(equal(PennerEasing.easeOutCubic))
                    expect(easeInOutCubic).to(equal(PennerEasing.easeInOutCubic))
                    expect(easeInExpo).to(equal(PennerEasing.easeInExpo))
                    expect(easeOutExpo).to(equal(PennerEasing.easeOutExpo))
                    expect(easeInOutExpo).to(equal(PennerEasing.easeInOutExpo))
                    expect(easeInQuad).to(equal(PennerEasing.easeInQuad))
                    expect(easeOutQuad).to(equal(PennerEasing.easeOutQuad))
                    expect(easeInOutQuad).to(equal(PennerEasing.easeInOutQuad))
                    expect(easeInQuart).to(equal(PennerEasing.easeInQuart))
                    expect(easeOutQuart).to(equal(PennerEasing.easeOutQuart))
                    expect(easeInOutQuart).to(equal(PennerEasing.easeInOutQuart))
                    expect(easeInQuint).to(equal(PennerEasing.easeInQuint))
                    expect(easeOutQuint).to(equal(PennerEasing.easeOutQuint))
                    expect(easeInOutQuint).to(equal(PennerEasing.easeInOutQuint))
                    expect(easeInSine).to(equal(PennerEasing.easeInSine))
                    expect(easeOutSine).to(equal(PennerEasing.easeOutSine))
                    expect(easeInOutSine).to(equal(PennerEasing.easeInOutSine))
                    expect(easeInBack).to(equal(PennerEasing.easeInBack))
                    expect(easeOutBack).to(equal(PennerEasing.easeOutBack))
                    expect(easeInOutBack).to(equal(PennerEasing.easeInOutBack))
                    expect(easeInBackAdvanced).to(equal(PennerEasing.easeInBackAdvanced(0.1)))
                    expect(easeOutBackAdvanced).to(equal(PennerEasing.easeOutBackAdvanced(0.1)))
                    expect(easeInOutBackAdvanced).to(equal(PennerEasing.easeInOutBackAdvanced(0.1)))
                    expect(easeInBounce).to(equal(PennerEasing.easeInBounce))
                    expect(easeOutBounce).to(equal(PennerEasing.easeOutBounce))
                    expect(easeInOutBounce).to(equal(PennerEasing.easeInOutBounce))
                    expect(easeInElastic).to(equal(PennerEasing.easeInElastic))
                    expect(easeOutElastic).to(equal(PennerEasing.easeOutElastic))
                    expect(easeInOutElastic).to(equal(PennerEasing.easeInOutElastic))
                    expect(easeInElasticAdvanced).to(equal(PennerEasing.easeInElasticAdvanced(0.1, 0.1)))
                    expect(easeOutElasticAdvanced).to(equal(PennerEasing.easeOutElasticAdvanced(0.1, 0.1)))
                    expect(easeInOutElasticAdvanced).to(equal(PennerEasing.easeInOutElasticAdvanced(0.1, 0.1)))
                }
                it("Description") {
                    expect(String(describing: linear)).to(beginWith("linear"))
                    expect(String(describing: easeInCirc)).to(beginWith("easeInCirc"))
                    expect(String(describing: easeOutCirc)).to(beginWith("easeOutCirc"))
                    expect(String(describing: easeInOutCirc)).to(beginWith("easeInOutCirc"))
                    expect(String(describing: easeInCubic)).to(beginWith("easeInCubic"))
                    expect(String(describing: easeOutCubic)).to(beginWith("easeOutCubic"))
                    expect(String(describing: easeInOutCubic)).to(beginWith("easeInOutCubic"))
                    expect(String(describing: easeInExpo)).to(beginWith("easeInExpo"))
                    expect(String(describing: easeOutExpo)).to(beginWith("easeOutExpo"))
                    expect(String(describing: easeInOutExpo)).to(beginWith("easeInOutExpo"))
                    expect(String(describing: easeInQuad)).to(beginWith("easeInQuad"))
                    expect(String(describing: easeOutQuad)).to(beginWith("easeOutQuad"))
                    expect(String(describing: easeInOutQuad)).to(beginWith("easeInOutQuad"))
                    expect(String(describing: easeInQuart)).to(beginWith("easeInQuart"))
                    expect(String(describing: easeOutQuart)).to(beginWith("easeOutQuart"))
                    expect(String(describing: easeInOutQuart)).to(beginWith("easeInOutQuart"))
                    expect(String(describing: easeInQuint)).to(beginWith("easeInQuint"))
                    expect(String(describing: easeOutQuint)).to(beginWith("easeOutQuint"))
                    expect(String(describing: easeInOutQuint)).to(beginWith("easeInOutQuint"))
                    expect(String(describing: easeInSine)).to(beginWith("easeInSine"))
                    expect(String(describing: easeOutSine)).to(beginWith("easeOutSine"))
                    expect(String(describing: easeInOutSine)).to(beginWith("easeInOutSine"))
                    expect(String(describing: easeInBack)).to(beginWith("easeInBack"))
                    expect(String(describing: easeOutBack)).to(beginWith("easeOutBack"))
                    expect(String(describing: easeInOutBack)).to(beginWith("easeInOutBack"))
                    expect(String(describing: easeInBackAdvanced)).to(beginWith("easeInBackAdvanced"))
                    expect(String(describing: easeOutBackAdvanced)).to(beginWith("easeOutBackAdvanced"))
                    expect(String(describing: easeInOutBackAdvanced)).to(beginWith("easeInOutBackAdvanced"))
                    expect(String(describing: easeInBounce)).to(beginWith("easeInBounce"))
                    expect(String(describing: easeOutBounce)).to(beginWith("easeOutBounce"))
                    expect(String(describing: easeInOutBounce)).to(beginWith("easeInOutBounce"))
                    expect(String(describing: easeInElastic)).to(beginWith("easeInElastic"))
                    expect(String(describing: easeOutElastic)).to(beginWith("easeOutElastic"))
                    expect(String(describing: easeInOutElastic)).to(beginWith("easeInOutElastic"))
                    expect(String(describing: easeInElasticAdvanced)).to(beginWith("easeInElasticAdvanced"))
                    expect(String(describing: easeOutElasticAdvanced)).to(beginWith("easeOutElasticAdvanced"))
                    expect(String(describing: easeInOutElasticAdvanced)).to(beginWith("easeInOutElasticAdvanced"))
                }
            }
            describe("FluidAnimatorState") {
                it("Description") {
                    expect(String(describing: FluidAnimatorState.ready)).to(beginWith("ready"))
                    expect(String(describing: FluidAnimatorState.running)).to(beginWith("running"))
                    expect(String(describing: FluidAnimatorState.paused)).to(beginWith("paused"))
                    expect(String(describing: FluidAnimatorState.cancelled)).to(beginWith("cancelled"))
                    expect(String(describing: FluidAnimatorState.failed)).to(beginWith("failed"))
                    expect(String(describing: FluidAnimatorState.finished)).to(beginWith("finished"))
                }
            }
            describe("FluidCoreAnimatorKey") {
                it("maps layer keys to Core Animation key paths") {
                    let keyPaths: [(actual: String, expected: String)] = [
                        (FluidCoreAnimatorKey.anchorPoint.rawValue, #keyPath(CALayer.anchorPoint)),
                        (FluidCoreAnimatorKey.backgroundColor.rawValue, #keyPath(CALayer.backgroundColor)),
                        (FluidCoreAnimatorKey.borderColor.rawValue, #keyPath(CALayer.borderColor)),
                        (FluidCoreAnimatorKey.borderWidth.rawValue, #keyPath(CALayer.borderWidth)),
                        (FluidCoreAnimatorKey.bounds.rawValue, #keyPath(CALayer.bounds)),
                        (FluidCoreAnimatorKey.contents.rawValue, #keyPath(CALayer.contents)),
                        (FluidCoreAnimatorKey.contentsRect.rawValue, #keyPath(CALayer.contentsRect)),
                        (FluidCoreAnimatorKey.cornerRadius.rawValue, #keyPath(CALayer.cornerRadius)),
                        (FluidCoreAnimatorKey.filters.rawValue, #keyPath(CALayer.filters)),
                        (FluidCoreAnimatorKey.frame.rawValue, #keyPath(CALayer.frame)),
                        (FluidCoreAnimatorKey.hidden.rawValue, #keyPath(CALayer.isHidden)),
                        (FluidCoreAnimatorKey.mask.rawValue, #keyPath(CALayer.mask)),
                        (FluidCoreAnimatorKey.masksToBounds.rawValue, #keyPath(CALayer.masksToBounds)),
                        (FluidCoreAnimatorKey.opacity.rawValue, #keyPath(CALayer.opacity)),
                        (FluidCoreAnimatorKey.path.rawValue, #keyPath(CAShapeLayer.path)),
                        (FluidCoreAnimatorKey.position.rawValue, #keyPath(CALayer.position)),
                        (FluidCoreAnimatorKey.shadowColor.rawValue, #keyPath(CALayer.shadowColor)),
                        (FluidCoreAnimatorKey.shadowOffset.rawValue, #keyPath(CALayer.shadowOffset)),
                        (FluidCoreAnimatorKey.shadowOpacity.rawValue, #keyPath(CALayer.shadowOpacity)),
                        (FluidCoreAnimatorKey.shadowPath.rawValue, #keyPath(CALayer.shadowPath)),
                        (FluidCoreAnimatorKey.shadowRadius.rawValue, #keyPath(CALayer.shadowRadius)),
                        (FluidCoreAnimatorKey.sublayers.rawValue, #keyPath(CALayer.sublayers)),
                        (FluidCoreAnimatorKey.sublayerTransform.rawValue, #keyPath(CALayer.sublayerTransform)),
                        (FluidCoreAnimatorKey.transform.rawValue, #keyPath(CALayer.transform)),
                        (FluidCoreAnimatorKey.zPosition.rawValue, #keyPath(CALayer.zPosition)),
                        (FluidCoreAnimatorKey.anchorPointX.rawValue, "\(#keyPath(CALayer.anchorPoint)).x"),
                        (FluidCoreAnimatorKey.anchorPointy.rawValue, "\(#keyPath(CALayer.anchorPoint)).y"),
                        (FluidCoreAnimatorKey.boundsOrigin.rawValue, "\(#keyPath(CALayer.bounds)).origin"),
                        (FluidCoreAnimatorKey.boundsOriginX.rawValue, "\(#keyPath(CALayer.bounds)).origin.x"),
                        (FluidCoreAnimatorKey.boundsOriginY.rawValue, "\(#keyPath(CALayer.bounds)).origin.y"),
                        (FluidCoreAnimatorKey.boundsSize.rawValue, "\(#keyPath(CALayer.bounds)).size"),
                        (FluidCoreAnimatorKey.boundsSizeWidth.rawValue, "\(#keyPath(CALayer.bounds)).size.width"),
                        (FluidCoreAnimatorKey.boundsSizeHeight.rawValue, "\(#keyPath(CALayer.bounds)).size.height"),
                        (FluidCoreAnimatorKey.contentsRectOrigin.rawValue, "\(#keyPath(CALayer.contentsRect)).origin"),
                        (FluidCoreAnimatorKey.contentsRectOriginX.rawValue, "\(#keyPath(CALayer.contentsRect)).origin.x"),
                        (FluidCoreAnimatorKey.contentsRectOriginY.rawValue, "\(#keyPath(CALayer.contentsRect)).origin.y"),
                        (FluidCoreAnimatorKey.contentsRectSize.rawValue, "\(#keyPath(CALayer.contentsRect)).size"),
                        (FluidCoreAnimatorKey.contentsRectSizeWidth.rawValue, "\(#keyPath(CALayer.contentsRect)).size.width"),
                        (FluidCoreAnimatorKey.contentsRectSizeHeight.rawValue, "\(#keyPath(CALayer.contentsRect)).size.height"),
                        (FluidCoreAnimatorKey.frameOrigin.rawValue, "\(#keyPath(CALayer.frame)).origin"),
                        (FluidCoreAnimatorKey.frameOriginX.rawValue, "\(#keyPath(CALayer.frame)).origin.x"),
                        (FluidCoreAnimatorKey.frameOriginY.rawValue, "\(#keyPath(CALayer.frame)).origin.y"),
                        (FluidCoreAnimatorKey.frameSize.rawValue, "\(#keyPath(CALayer.frame)).size"),
                        (FluidCoreAnimatorKey.frameSizeWidth.rawValue, "\(#keyPath(CALayer.frame)).size.width"),
                        (FluidCoreAnimatorKey.frameSizeHeight.rawValue, "\(#keyPath(CALayer.frame)).size.height"),
                        (FluidCoreAnimatorKey.positionX.rawValue, "\(#keyPath(CALayer.position)).x"),
                        (FluidCoreAnimatorKey.positionY.rawValue, "\(#keyPath(CALayer.position)).y"),
                        (FluidCoreAnimatorKey.shadowOffsetWidth.rawValue, "\(#keyPath(CALayer.shadowOffset)).width"),
                        (FluidCoreAnimatorKey.shadowOffsetHeight.rawValue, "\(#keyPath(CALayer.shadowOffset)).height"),
                        (FluidCoreAnimatorKey.sublayerTransformRotationX.rawValue, "\(#keyPath(CALayer.sublayerTransform)).rotation.x"),
                        (FluidCoreAnimatorKey.sublayerTransformRotationY.rawValue, "\(#keyPath(CALayer.sublayerTransform)).rotation.y"),
                        (FluidCoreAnimatorKey.sublayerTransformRotationZ.rawValue, "\(#keyPath(CALayer.sublayerTransform)).rotation.z"),
                        (FluidCoreAnimatorKey.sublayerTransformScaleX.rawValue, "\(#keyPath(CALayer.sublayerTransform)).scale.x"),
                        (FluidCoreAnimatorKey.sublayerTransformScaleY.rawValue, "\(#keyPath(CALayer.sublayerTransform)).scale.y"),
                        (FluidCoreAnimatorKey.sublayerTransformScaleZ.rawValue, "\(#keyPath(CALayer.sublayerTransform)).scale.z"),
                        (FluidCoreAnimatorKey.sublayerTransformTranslationX.rawValue, "\(#keyPath(CALayer.sublayerTransform)).translation.x"),
                        (FluidCoreAnimatorKey.sublayerTransformTranslationY.rawValue, "\(#keyPath(CALayer.sublayerTransform)).translation.y"),
                        (FluidCoreAnimatorKey.sublayerTransformTranslationZ.rawValue, "\(#keyPath(CALayer.sublayerTransform)).translation.z"),
                        (FluidCoreAnimatorKey.transformRotationX.rawValue, "\(#keyPath(CALayer.transform)).rotation.x"),
                        (FluidCoreAnimatorKey.transformRotationY.rawValue, "\(#keyPath(CALayer.transform)).rotation.y"),
                        (FluidCoreAnimatorKey.transformRotationZ.rawValue, "\(#keyPath(CALayer.transform)).rotation.z"),
                        (FluidCoreAnimatorKey.transformScaleX.rawValue, "\(#keyPath(CALayer.transform)).scale.x"),
                        (FluidCoreAnimatorKey.transformScaleY.rawValue, "\(#keyPath(CALayer.transform)).scale.y"),
                        (FluidCoreAnimatorKey.transformScaleZ.rawValue, "\(#keyPath(CALayer.transform)).scale.z"),
                        (FluidCoreAnimatorKey.transformTranslationX.rawValue, "\(#keyPath(CALayer.transform)).translation.x"),
                        (FluidCoreAnimatorKey.transformTranslationY.rawValue, "\(#keyPath(CALayer.transform)).translation.y"),
                        (FluidCoreAnimatorKey.transformTranslationZ.rawValue, "\(#keyPath(CALayer.transform)).translation.z"),
                    ]

                    keyPaths.forEach { keyPath in
                        expect(keyPath.actual).to(equal(keyPath.expected))
                    }
                }
            }
            describe("FluidCoreAnimatorValidator") {
                it("validates layers, animation counts, completion state, and typed animation values") {
                    FluidCoreAnimatorLogger.suppress = true
                    defer { FluidCoreAnimatorLogger.suppress = false }

                    let layer = CALayer()
                    layer.bounds = CGRect(x: 2, y: 4, width: 30, height: 40)
                    let targetBounds = CGRect(x: 10, y: 12, width: 50, height: 60)
                    var validatedLayer: CALayer?

                    expect {
                        validatedLayer = try FluidCoreAnimatorValidator.validate(layer: layer, id: "valid-layer")
                    }.notTo(throwError())
                    expect(validatedLayer === layer).to(beTrue())
                    expect(try? FluidCoreAnimatorValidator.validate(isCompleted: true,
                                                                    state: .finished,
                                                                    id: "complete")).to(beTrue())
                    expect(try? FluidCoreAnimatorValidator.validate(count: 1, id: "has-animation")).to(beTrue())

                    let validatedBounds = try? FluidCoreAnimatorValidator.validate(layer: layer,
                                                                                   keyPath: FluidCoreAnimatorKey.bounds,
                                                                                   from: nil,
                                                                                   to: targetBounds,
                                                                                   id: "bounds")
                    expect(validatedBounds?.from).to(equal(layer.bounds))
                    expect(validatedBounds?.to).to(equal(targetBounds))

                    expect {
                        try FluidCoreAnimatorValidator.validate(layer: nil, id: "nil-layer")
                    }.to(throwError { error in
                        guard case FluidCoreAnimatorError.layerIsNil(let id) = error else {
                            fail("Expected layerIsNil error")
                            return
                        }
                        expect(id).to(equal("nil-layer"))
                    })
                    expect {
                        try FluidCoreAnimatorValidator.validate(isCompleted: false,
                                                               state: .running,
                                                               id: "running")
                    }.to(throwError { error in
                        guard case FluidCoreAnimatorError.alreadyCompleted(let id, let state) = error else {
                            fail("Expected alreadyCompleted error")
                            return
                        }
                        expect(id).to(equal("running"))
                        expect(state).to(equal(.running))
                    })
                    expect {
                        try FluidCoreAnimatorValidator.validate(count: 0, id: "empty")
                    }.to(throwError { error in
                        guard case FluidCoreAnimatorError.animationsIsEmpty(let id) = error else {
                            fail("Expected animationsIsEmpty error")
                            return
                        }
                        expect(id).to(equal("empty"))
                    })
                    expect {
                        try FluidCoreAnimatorValidator.validate(layer: nil,
                                                               keyPath: FluidCoreAnimatorKey.bounds,
                                                               from: layer.bounds,
                                                               to: targetBounds,
                                                               id: "nil-generic-layer")
                    }.to(throwError { error in
                        guard case FluidCoreAnimatorError.layerIsNil(let id) = error else {
                            fail("Expected layerIsNil error")
                            return
                        }
                        expect(id).to(equal("nil-generic-layer"))
                    })
                    expect {
                        try FluidCoreAnimatorValidator.validate(layer: layer,
                                                               keyPath: FluidCoreAnimatorKey.bounds,
                                                               from: layer.bounds,
                                                               to: nil,
                                                               id: "invalid-bounds")
                    }.to(throwError { error in
                        guard case FluidCoreAnimatorError.invalidArgument(let id, let key, _, _) = error else {
                            fail("Expected invalidArgument error")
                            return
                        }
                        expect(id).to(equal("invalid-bounds"))
                        expect(key).to(equal(FluidCoreAnimatorKey.bounds.rawValue))
                    })
                }
            }
            describe("FluidPropertyAnimator") {
                it("runs, pauses, updates, resumes, stops, and invalidates queued animations") {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                    var progressValues: [CGFloat] = []
                    var stateValues: [FluidAnimatorState] = []
                    let animator = FluidPropertyAnimator(duration: 1, easing: .linear, id: "property-core")

                    animator
                        .add({ view.alpha = 0.5 }, lazy: true)
                        .add({ view.frame.origin.x = 12 }, delayFactor: 0.2, lazy: true)
                        .on { progress in
                            progressValues.append(progress)
                        }
                        .on { state, progress in
                            stateValues.append(state)
                            progressValues.append(progress)
                        }
                        .fractionComplete(0.25)
                        .isReversed(true)
                        .isInterruptible(false)
                        .isUserInteractionEnabled(false)
                        .isManualHitTestingEnabled(false)

                    if #available(iOS 11.0, *) {
                        animator.scrubsLinearly(true).pausesOnCompletion(true)
                        expect(animator.scrubsLinearly).to(beTrue())
                        expect(animator.pausesOnCompletion).to(beTrue())
                        animator.configure(scrubsLinearly: false, pausesOnCompletion: false)
                        expect(animator.scrubsLinearly).to(beFalse())
                        expect(animator.pausesOnCompletion).to(beFalse())
                    }

                    animator.configure(isInterruptible: true,
                                       isUserInteractionEnabled: true,
                                       isManualHitTestingEnabled: true)

                    expect(animator.identifier).to(equal("property-core"))
                    expect(animator.animations?.count).to(equal(2))
                    expect(animator.isInterruptible).to(beTrue())
                    expect(animator.isUserInteractionEnabled).to(beTrue())
                    expect(animator.isManualHitTestingEnabled).to(beTrue())
                    expect(progressValues).notTo(beEmpty())

                    animator.run()
                    animator.add({ view.alpha = 0.25 }, lazy: true)
                    expect(animator.animatorState).to(equal(.running))
                    expect(animator.displayLink).notTo(beNil())

                    animator.pause()
                    expect(animator.animatorState).to(equal(.paused))
                    expect(animator.displayLink).to(beNil())

                    animator.update(fractionComplete: 0.4)
                    expect(animator.fractionComplete).to(beCloseTo(0.4, within: 0.001))
                    expect(animator.animatorProgress).to(beCloseTo(0.4, within: 0.001))

                    animator.resume(easing: .easeOutQuad, durationFactor: 0.5)
                    expect(animator.animatorState).to(equal(.running))
                    expect(animator.displayLink).notTo(beNil())

                    animator.stop(true)
                    expect(animator.animatorState).to(equal(.cancelled))
                    expect(animator.displayLink).to(beNil())

                    animator.invalidate()
                    expect(animator.animations).to(beNil())
                    let stateDescriptions = stateValues.map { String(describing: $0) }
                    expect(stateDescriptions).to(contain("running"))
                    expect(stateDescriptions).to(contain("paused"))
                    expect(stateDescriptions).to(contain("cancelled"))
                }

                it("finishes active animations and clears timers") {
                    let animator = FluidPropertyAnimator(duration: 1, easing: .linear, id: "property-finish")

                    animator.add({}, lazy: true)
                    animator.run()

                    expect(animator.animatorState).to(equal(.running))
                    expect(animator.displayLink).notTo(beNil())

                    animator.finish(at: .current)

                    expect(animator.animatorState).to(equal(.finished))
                    expect(animator.displayLink).to(beNil())
                }

                it("initializes timing variants and queued animations") {
                    var invokedCount = 0
                    let curveAnimator = FluidPropertyAnimator(duration: 1, curve: .easeInOut, id: "property-curve") {
                        invokedCount += 1
                    }
                    let pointAnimator = FluidPropertyAnimator(duration: 1,
                                                             controlPoint1: CGPoint(x: 0.2, y: 0.1),
                                                             controlPoint2: CGPoint(x: 0.8, y: 0.9),
                                                             id: "property-point") {
                        invokedCount += 1
                    }
                    let scalarAnimator = FluidPropertyAnimator(duration: 1,
                                                              c1x: 0.1,
                                                              c1y: 0.2,
                                                              c2x: 0.8,
                                                              c2y: 0.9)
                    let dampingAnimator = FluidPropertyAnimator(duration: 1, dampingRatio: 0.6, id: "property-damping") {
                        invokedCount += 1
                    }

                    expect(curveAnimator.identifier).to(equal("property-curve"))
                    expect(pointAnimator.identifier).to(equal("property-point"))
                    expect(dampingAnimator.identifier).to(equal("property-damping"))
                    expect(scalarAnimator.duration).to(equal(1))
                    expect(curveAnimator.animations?.count).to(equal(1))
                    expect(pointAnimator.animations?.count).to(equal(1))
                    expect(dampingAnimator.animations?.count).to(equal(1))

                    [curveAnimator, pointAnimator, scalarAnimator, dampingAnimator].forEach {
                        $0.add({}, lazy: true)
                        $0.run()
                        $0.finish(at: .current)
                        expect($0.animatorState).to(equal(.finished))
                    }
                    expect(invokedCount).to(equal(3))
                }

                it("converts and merges queued property animations") {
                    let first = FluidPropertyAnimator(duration: 1, easing: .linear, id: "property-first")
                    let second = FluidPropertyAnimator(duration: 1, easing: .easeOut, id: "property-second")
                    let empty = FluidPropertyAnimator(duration: 1, easing: .easeIn, id: "property-empty")

                    first.add({}, lazy: true)
                    second.add({}, delayFactor: 0.2, lazy: true)

                    let converted = FluidPropertyAnimator.convert([first, second, empty],
                                                                 duration: 1,
                                                                 easing: .linear,
                                                                 id: "converted-property")
                    let emptyConverted = FluidPropertyAnimator.convert(nil,
                                                                      duration: 1,
                                                                      easing: .linear,
                                                                      id: "empty-converted-property")
                    let merged = FluidPropertyAnimator.merge([first, second, empty],
                                                            duration: 1,
                                                            easing: .linear)
                    let emptyMerged = FluidPropertyAnimator.merge(nil,
                                                                 duration: 1,
                                                                 easing: .linear)

                    expect(converted.identifier).to(equal("converted-property"))
                    expect(emptyConverted.identifier).to(equal("empty-converted-property"))
                    expect(merged.identifier).to(equal("interruptible"))
                    expect(emptyMerged.identifier).to(equal("interruptible"))
                    expect(merged.animations).notTo(beNil())
                    expect(emptyMerged.animations).notTo(beNil())
                }
            }
            describe("FluidInterruptibleAnimator") {
                it("controls animation state and clears completion callbacks") {
                    let view = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
                    let animator = FluidInterruptibleAnimator(duration: 1,
                                                             timingParameters: FluidAnimatorEasing.linear.timingParameters,
                                                             id: "interruptible-core")
                    var completionPositions: [UIViewAnimatingPosition] = []
                    var completionStates: [UIViewAnimatingStateEx] = []

                    animator.addAnimations { view.alpha = 0.2 }
                    animator.addCompletion { position, state in
                        completionPositions.append(position)
                        completionStates.append(state)
                    }

                    expect(animator.identifier).to(equal("interruptible-core"))
                    expect(animator.completionBlock).notTo(beNil())

                    animator.startAnimation()
                    animator.pauseAnimation()
                    animator.continueAnimation(withTimingParameters: FluidAnimatorEasing.easeOut.timingParameters,
                                               durationFactor: 0.5)
                    animator.stopAnimation(false)
                    animator.finishAnimation(at: .end)

                    expect(view.alpha).to(beCloseTo(0.2, within: 0.001))
                    expect(completionPositions).to(contain(.end))
                    expect(completionStates).notTo(beEmpty())

                    animator.positionDidChange(position: .current)
                    expect(completionPositions.last).to(equal(.current))

                    animator.invalidate()
                    expect(animator.completionBlock).to(beNil())
                }

                it("starts delayed animations") {
                    let animator = FluidInterruptibleAnimator(duration: 1,
                                                             timingParameters: FluidAnimatorEasing.linear.timingParameters,
                                                             id: "interruptible-delayed")

                    animator.addAnimations {}
                    animator.startAnimation(afterDelay: 0)
                    animator.stopAnimation(true)

                    expect(animator.identifier).to(equal("interruptible-delayed"))
                    animator.invalidate()
                }
            }
        }

        func calculate(easing: PennerEasing, step: CGFloat = 0.01, duration: CGFloat = 1.0, begin: CGFloat = 0.0, end: CGFloat = 100.0) -> CGFloat {
            var time: CGFloat = 0.0
            var current: CGFloat = begin
            let limit: CGFloat = duration - step
            while (true) {
                if time <= limit {
                    current = easing.calculate(time, duration, begin: begin, end: end)
                    time += step
                } else {
                    time = duration
                    current = easing.calculate(time, duration, begin: begin, end: end)
                    break
                }
            }
            return current
        }
    }
}
