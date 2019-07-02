//
//  EasingEnum.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/02.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class AnimatorSpec: QuickSpec {
    override func spec() {
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

//                    linear
//                    easeIn
//                    easeOut
//                    easeInOut
//                    easeInSine
//                    easeOutSine
//                    easeInOutSine
//                    easeInQuad
//                    easeOutQuad
//                    easeInOutQuad
//                    easeInCubic
//                    easeOutCubic
//                    easeInOutCubic
//                    easeInQuart
//                    easeOutQuart
//                    easeInOutQuart
//                    easeInQuint
//                    easeOutQuint
//                    easeInOutQuint
//                    easeInExpo
//                    easeOutExpo
//                    easeInOutExpo
//                    easeInCirc
//                    easeOutCirc
//                    easeInOutCirc
//                    easeInBack
//                    easeOutBack
//                    easeInOutBack
//                    cubicBezier
//                    spring
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
                let step: CGFloat = 0.01
                let duration: CGFloat = 1.0
                let begin: CGFloat = 0.0
                let end: CGFloat = 100.0
                it("Calculate") {
                    expect(round(calculate(easing: linear, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInCirc, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutCirc, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutCirc, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInCubic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutCubic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutCubic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInExpo, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutExpo, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutExpo, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInQuad, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutQuad, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutQuad, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInQuart, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutQuart, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutQuart, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInQuint, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutQuint, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutQuint, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInSine, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutSine, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutSine, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInBack, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutBack, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutBack, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInBackAdvanced, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutBackAdvanced, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutBackAdvanced, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInBounce, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutBounce, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutBounce, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInElastic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutElastic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutElastic, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInElasticAdvanced, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeOutElasticAdvanced, end: end))).to(equal(end))
                    expect(round(calculate(easing: easeInOutElasticAdvanced, end: end))).to(equal(end))
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
