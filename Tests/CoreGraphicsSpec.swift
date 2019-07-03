//
//  CoreGraphicsSpec.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class CoreGraphicsSpec: QuickSpec {
    override func spec() {
        describe("Foundation") {
            describe("Number") {
                it("Comparable") {
                    do {
                        let positiveValue: CGFloat = 10.0
                        let negativeValue: CGFloat = -10.0
                        expect(positiveValue.clamped(to: ClosedRange(uncheckedBounds: (0.0, 1.0)))).to(beCloseTo(1.0))
                        expect(negativeValue.clamped(to: ClosedRange(uncheckedBounds: (0.0, 1.0)))).to(beCloseTo(0.0))
                    }
                    do {
                        let positiveValue: CGFloat = 10.0
                        let negativeValue: CGFloat = -10.0
                        expect(positiveValue.clamped(0, 1.0)).to(beCloseTo(1.0))
                        expect(negativeValue.clamped(0, 1.0)).to(beCloseTo(0.0))
                    }
                    do {
                        var positiveValue: CGFloat = 10.0
                        var negativeValue: CGFloat = -10.0
                        positiveValue.clamp(to: ClosedRange(uncheckedBounds: (0.0, 1.0)))
                        negativeValue.clamp(to: ClosedRange(uncheckedBounds: (0.0, 1.0)))
                        expect(positiveValue).to(beCloseTo(1.0))
                        expect(negativeValue).to(beCloseTo(0.0))
                    }
                    do {
                        var positiveValue: CGFloat = 10.0
                        var negativeValue: CGFloat = -10.0
                        positiveValue.clamp(0, 1.0)
                        negativeValue.clamp(0, 1.0)
                        expect(positiveValue).to(beCloseTo(1.0))
                        expect(negativeValue).to(beCloseTo(0.0))
                    }

                    do {
                        let positiveValue: CGFloat = 10.0
                        let negativeValue: CGFloat = -10.0
                        expect(positiveValue.clamped(to: ClosedRange(uncheckedBounds: (-1.0, 0.0)))).to(beCloseTo(0.0))
                        expect(negativeValue.clamped(to: ClosedRange(uncheckedBounds: (-1.0, 0.0)))).to(beCloseTo(-1.0))
                    }
                    do {
                        let positiveValue: CGFloat = 10.0
                        let negativeValue: CGFloat = -10.0
                        expect(positiveValue.clamped(-1.0, 0.0)).to(beCloseTo(0.0))
                        expect(negativeValue.clamped(-1.0, 0.0)).to(beCloseTo(-1.0))
                    }
                    do {
                        var positiveValue: CGFloat = 10.0
                        var negativeValue: CGFloat = -10.0
                        positiveValue.clamp(to: ClosedRange(uncheckedBounds: (-1.0, 0.0)))
                        negativeValue.clamp(to: ClosedRange(uncheckedBounds: (-1.0, 0.0)))
                        expect(positiveValue).to(beCloseTo(0.0))
                        expect(negativeValue).to(beCloseTo(-1.0))
                    }
                    do {
                        var positiveValue: CGFloat = 10.0
                        var negativeValue: CGFloat = -10.0
                        positiveValue.clamp(-1.0, 0.0)
                        negativeValue.clamp(-1.0, 0.0)
                        expect(positiveValue).to(beCloseTo(0.0))
                        expect(negativeValue).to(beCloseTo(-1.0))
                    }
                }
                it("Angle") {
                    expect(CGFloat(30).degreesToRadians).to(beCloseTo(0.5235987756))
                    expect(CGFloat(0.5235987756).radiansToDegrees).to(beCloseTo(30))
                    expect(CGFloat.pi2).to(beCloseTo(CGFloat.pi / 2))
                    expect(CGFloat.pi4).to(beCloseTo(CGFloat.pi / 4))
                    expect(CGFloat.pi8).to(beCloseTo(CGFloat.pi / 8))
                }
                it("Decimal") {
                    expect(CGFloat(0.0004).decimal(4)).to(equal(0.0004))
                    expect(CGFloat(0.0004).decimal(3)).to(equal(0.000))
                    expect(CGFloat(0.0004).decimal(2)).to(equal(0.00))
                    expect(CGFloat(0.0004).decimal(1)).to(equal(0.0))
                    expect(CGFloat(0.0004).decimal(0)).to(equal(0))

                    expect(CGFloat(0.0005).decimal(4)).to(equal(0.0005))
                    expect(CGFloat(0.0005).decimal(3)).to(equal(0.001))
                    expect(CGFloat(0.0005).decimal(2)).to(equal(0.00))
                    expect(CGFloat(0.0005).decimal(1)).to(equal(0.0))
                    expect(CGFloat(0.0005).decimal(0)).to(equal(0))

                    expect(CGFloat(0.004).decimal(4)).to(equal(0.004))
                    expect(CGFloat(0.004).decimal(3)).to(equal(0.004))
                    expect(CGFloat(0.004).decimal(2)).to(equal(0.00))
                    expect(CGFloat(0.004).decimal(1)).to(equal(0.0))
                    expect(CGFloat(0.004).decimal(0)).to(equal(0))

                    expect(CGFloat(0.005).decimal(4)).to(equal(0.005))
                    expect(CGFloat(0.005).decimal(3)).to(equal(0.005))
                    expect(CGFloat(0.005).decimal(2)).to(equal(0.01))
                    expect(CGFloat(0.005).decimal(1)).to(equal(0.0))
                    expect(CGFloat(0.005).decimal(0)).to(equal(0))

                    expect(CGFloat(0.04).decimal(4)).to(equal(0.04))
                    expect(CGFloat(0.04).decimal(3)).to(equal(0.04))
                    expect(CGFloat(0.04).decimal(2)).to(equal(0.04))
                    expect(CGFloat(0.04).decimal(1)).to(equal(0.0))
                    expect(CGFloat(0.04).decimal(0)).to(equal(0))

                    expect(CGFloat(0.05).decimal(4)).to(equal(0.05))
                    expect(CGFloat(0.05).decimal(3)).to(equal(0.05))
                    expect(CGFloat(0.05).decimal(2)).to(equal(0.05))
                    expect(CGFloat(0.05).decimal(1)).to(equal(0.1))
                    expect(CGFloat(0.05).decimal(0)).to(equal(0))

                    expect(Double(0.0004).decimal(4)).to(equal(0.0004))
                    expect(Double(0.0004).decimal(3)).to(equal(0.000))
                    expect(Double(0.0004).decimal(2)).to(equal(0.00))
                    expect(Double(0.0004).decimal(1)).to(equal(0.0))
                    expect(Double(0.0004).decimal(0)).to(equal(0))

                    expect(Double(0.0005).decimal(4)).to(equal(0.0005))
                    expect(Double(0.0005).decimal(3)).to(equal(0.001))
                    expect(Double(0.0005).decimal(2)).to(equal(0.00))
                    expect(Double(0.0005).decimal(1)).to(equal(0.0))
                    expect(Double(0.0005).decimal(0)).to(equal(0))

                    expect(Double(0.004).decimal(4)).to(equal(0.004))
                    expect(Double(0.004).decimal(3)).to(equal(0.004))
                    expect(Double(0.004).decimal(2)).to(equal(0.00))
                    expect(Double(0.004).decimal(1)).to(equal(0.0))
                    expect(Double(0.004).decimal(0)).to(equal(0))

                    expect(Double(0.005).decimal(4)).to(equal(0.005))
                    expect(Double(0.005).decimal(3)).to(equal(0.005))
                    expect(Double(0.005).decimal(2)).to(equal(0.01))
                    expect(Double(0.005).decimal(1)).to(equal(0.0))
                    expect(Double(0.005).decimal(0)).to(equal(0))

                    expect(Double(0.04).decimal(4)).to(equal(0.04))
                    expect(Double(0.04).decimal(3)).to(equal(0.04))
                    expect(Double(0.04).decimal(2)).to(equal(0.04))
                    expect(Double(0.04).decimal(1)).to(equal(0.0))
                    expect(Double(0.04).decimal(0)).to(equal(0))

                    expect(Double(0.05).decimal(4)).to(equal(0.05))
                    expect(Double(0.05).decimal(3)).to(equal(0.05))
                    expect(Double(0.05).decimal(2)).to(equal(0.05))
                    expect(Double(0.05).decimal(1)).to(equal(0.1))
                    expect(Double(0.05).decimal(0)).to(equal(0))

                    expect(Float(0.0004).decimal(4)).to(equal(0.0004))
                    expect(Float(0.0004).decimal(3)).to(equal(0.000))
                    expect(Float(0.0004).decimal(2)).to(equal(0.00))
                    expect(Float(0.0004).decimal(1)).to(equal(0.0))
                    expect(Float(0.0004).decimal(0)).to(equal(0))

                    expect(Float(0.0005).decimal(4)).to(equal(0.0005))
                    expect(Float(0.0005).decimal(3)).to(equal(0.001))
                    expect(Float(0.0005).decimal(2)).to(equal(0.00))
                    expect(Float(0.0005).decimal(1)).to(equal(0.0))
                    expect(Float(0.0005).decimal(0)).to(equal(0))

                    expect(Float(0.004).decimal(4)).to(equal(0.004))
                    expect(Float(0.004).decimal(3)).to(equal(0.004))
                    expect(Float(0.004).decimal(2)).to(equal(0.00))
                    expect(Float(0.004).decimal(1)).to(equal(0.0))
                    expect(Float(0.004).decimal(0)).to(equal(0))

                    expect(Float(0.005).decimal(4)).to(equal(0.005))
                    expect(Float(0.005).decimal(3)).to(equal(0.005))
                    expect(Float(0.005).decimal(2)).to(equal(0.01))
                    expect(Float(0.005).decimal(1)).to(equal(0.0))
                    expect(Float(0.005).decimal(0)).to(equal(0))

                    expect(Float(0.04).decimal(4)).to(equal(0.04))
                    expect(Float(0.04).decimal(3)).to(equal(0.04))
                    expect(Float(0.04).decimal(2)).to(equal(0.04))
                    expect(Float(0.04).decimal(1)).to(equal(0.0))
                    expect(Float(0.04).decimal(0)).to(equal(0))

                    expect(Float(0.05).decimal(4)).to(equal(0.05))
                    expect(Float(0.05).decimal(3)).to(equal(0.05))
                    expect(Float(0.05).decimal(2)).to(equal(0.05))
                    expect(Float(0.05).decimal(1)).to(equal(0.1))
                    expect(Float(0.05).decimal(0)).to(equal(0))
                }
                it("Description") {
                    expect(String(describing: CGFloat(0.00004))).to(match("4e-05"))
                    expect(String(describing: CGFloat(0.00005))).to(match("5e-05"))
                    expect(String(describing: CGFloat(0.0004))).to(match("0.0004"))
                    expect(String(describing: CGFloat(0.0005))).to(match("0.0005"))
                    expect(String(describing: CGFloat(0.004))).to(match("0.004"))
                    expect(String(describing: CGFloat(0.005))).to(match("0.005"))
                }
            }
            describe("CGPoint") {
                it("Calculation") {
                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        expect(pt0 + pt1).to(equal(CGPoint(x: 20.0, y: 20.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        pt0 += pt1
                        expect(pt0).to(equal(CGPoint(x: 20.0, y: 20.0)))
                    }
                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(pt0 + scalar).to(equal(CGPoint(x: 20.0, y: 20.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        pt0 += scalar
                        expect(pt0).to(equal(CGPoint(x: 20.0, y: 20.0)))
                    }

                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        expect(pt0 - pt1).to(equal(CGPoint(x: 0.0, y: 0.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        pt0 -= pt1
                        expect(pt0).to(equal(CGPoint(x: 0.0, y: 0.0)))
                    }
                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(pt0 - scalar).to(equal(CGPoint(x: 0.0, y: 0.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        pt0 -= scalar
                        expect(pt0).to(equal(CGPoint(x: 0.0, y: 0.0)))
                    }

                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        expect(pt0 * pt1).to(equal(CGPoint(x: 100.0, y: 100.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        pt0 *= pt1
                        expect(pt0).to(equal(CGPoint(x: 100.0, y: 100.0)))
                    }
                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(pt0 * scalar).to(equal(CGPoint(x: 100.0, y: 100.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        pt0 *= scalar
                        expect(pt0).to(equal(CGPoint(x: 100.0, y: 100.0)))
                    }

                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        expect(pt0 / pt1).to(equal(CGPoint(x: 1.0, y: 1.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        pt0 /= pt1
                        expect(pt0).to(equal(CGPoint(x: 1.0, y: 1.0)))
                    }
                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(pt0 / scalar).to(equal(CGPoint(x: 1.0, y: 1.0)))
                    }
                    do {
                        var pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let scalar: CGFloat = 10.0
                        pt0 /= scalar
                        expect(pt0).to(equal(CGPoint(x: 1.0, y: 1.0)))
                    }

                    do {
                        let pt0: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt1: CGPoint = pt0.normalize(from: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
                        expect(pt1).to(equal(CGPoint(x: 20.0, y: 20.0)))
                        let pt2: CGPoint = pt1.revert(to: UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0))
                        expect(pt2).to(equal(pt0))
                    }

                    do {
                        let pt0: CGPoint = .init(x: 0.0, y: 0.0)
                        let pt1: CGPoint = .init(x: 10.0, y: 10.0)
                        let pt2: CGPoint = .init(x: -10.0, y: -10.0)
                        expect(pt0.distance(to: .zero)).to(beCloseTo(0))
                        expect(pt0.distance(to: pt1)).to(beCloseTo(14.142135623730951))
                        expect(pt0.distance(to: pt2)).to(beCloseTo(14.142135623730951))
                    }
                }
            }

            describe("CGSize") {
                it("Calculation") {
                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        expect(size0 + size1).to(equal(CGSize(width: 20.0, height: 20.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        size0 += size1
                        expect(size0).to(equal(CGSize(width: 20.0, height: 20.0)))
                    }
                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(size0 + scalar).to(equal(CGSize(width: 20.0, height: 20.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        size0 += scalar
                        expect(size0).to(equal(CGSize(width: 20.0, height: 20.0)))
                    }

                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        expect(size0 - size1).to(equal(CGSize(width: 0.0, height: 0.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        size0 -= size1
                        expect(size0).to(equal(CGSize(width: 0.0, height: 0.0)))
                    }
                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(size0 - scalar).to(equal(CGSize(width: 0.0, height: 0.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        size0 -= scalar
                        expect(size0).to(equal(CGSize(width: 0.0, height: 0.0)))
                    }

                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        expect(size0 * size1).to(equal(CGSize(width: 100.0, height: 100.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        size0 *= size1
                        expect(size0).to(equal(CGSize(width: 100.0, height: 100.0)))
                    }
                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(size0 * scalar).to(equal(CGSize(width: 100.0, height: 100.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        size0 *= scalar
                        expect(size0).to(equal(CGSize(width: 100.0, height: 100.0)))
                    }

                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        expect(size0 / size1).to(equal(CGSize(width: 1.0, height: 1.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let size1: CGSize = .init(width: 10.0, height: 10.0)
                        size0 /= size1
                        expect(size0).to(equal(CGSize(width: 1.0, height: 1.0)))
                    }
                    do {
                        let size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(size0 / scalar).to(equal(CGSize(width: 1.0, height: 1.0)))
                    }
                    do {
                        var size0: CGSize = .init(width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        size0 /= scalar
                        expect(size0).to(equal(CGSize(width: 1.0, height: 1.0)))
                    }
                }
                it("Orientation") {
                    expect(CGSize(width: 20.0, height: 10.0).isPortrait).to(beFalse())
                    expect(CGSize(width: 20.0, height: 10.0).isLandscape).to(beTrue())
                    expect(CGSize(width: 10.0, height: 20.0).isPortrait).to(beTrue())
                    expect(CGSize(width: 10.0, height: 20.0).isLandscape).to(beFalse())
                    expect(CGSize(width: 20.0, height: 10.0).orientation).to(equal(UIInterfaceOrientation.landscapeLeft))
                    expect(CGSize(width: 10.0, height: 20.0).orientation).to(equal(UIInterfaceOrientation.portrait))
                }
            }
            describe("CGRect") {
                it("Calculation") {
                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        expect(rect0 + rect1).to(equal(CGRect(x: 0, y: 0, width: 20.0, height: 20.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        rect0 += rect1
                        expect(rect0).to(equal(CGRect(x: 0, y: 0, width: 20.0, height: 20.0)))
                    }
                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(rect0 + scalar).to(equal(CGRect(x: 10.0, y: 10.0, width: 20.0, height: 20.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        rect0 += scalar
                        expect(rect0).to(equal(CGRect(x: 10.0, y: 10.0, width: 20.0, height: 20.0)))
                    }

                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        expect(rect0 - rect1).to(equal(CGRect(x: 0, y: 0, width: 0.0, height: 0.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        rect0 -= rect1
                        expect(rect0).to(equal(CGRect(x: 0, y: 0, width: 0.0, height: 0.0)))
                    }
                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(rect0 - scalar).to(equal(CGRect(x: -10.0, y: -10.0, width: 0.0, height: 0.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        rect0 -= scalar
                        expect(rect0).to(equal(CGRect(x: -10.0, y: -10.0, width: 0.0, height: 0.0)))
                    }

                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        expect(rect0 * rect1).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        rect0 *= rect1
                        expect(rect0).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                    }
                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(rect0 * scalar).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        rect0 *= scalar
                        expect(rect0).to(equal(CGRect(x: 0, y: 0, width: 100.0, height: 100.0)))
                    }

                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 10.0, y: 10.0, width: 10.0, height: 10.0)
                        expect(rect0 / rect1).to(equal(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let rect1: CGRect = .init(x: 10.0, y: 10.0, width: 10.0, height: 10.0)
                        rect0 /= rect1
                        expect(rect0).to(equal(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)))
                    }
                    do {
                        let rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(rect0 / scalar).to(equal(CGRect(x: 0, y: 0, width: 1.0, height: 1.0)))
                    }
                    do {
                        var rect0: CGRect = .init(x: 0, y: 0, width: 10.0, height: 10.0)
                        let scalar: CGFloat = 10.0
                        rect0 /= scalar
                        expect(rect0).to(equal(CGRect(x: 0, y: 0, width: 1.0, height: 1.0)))
                    }

                    do {
                        expect(CGRect(x: 10, y: 10, width: 10.0, height: 10.0).bounds).to(equal(CGRect(x: 0, y: 0, width: 10.0, height: 10.0)))
                        expect(CGRect(x: 10, y: 10, width: 10.0, height: 10.0).position).to(equal(CGPoint(x: 15.0, y: 15.0)))
                    }
                }
            }
            describe("CGVector") {
                it("Calculation") {
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        expect(vec0 + vec1).to(equal(CGVector(dx: 20.0, dy: 20.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        vec0 += vec1
                        expect(vec0).to(equal(CGVector(dx: 20.0, dy: 20.0)))
                    }
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(vec0 + scalar).to(equal(CGVector(dx: 20.0, dy: 20.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        vec0 += scalar
                        expect(vec0).to(equal(CGVector(dx: 20.0, dy: 20.0)))
                    }

                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        expect(vec0 - vec1).to(equal(CGVector(dx: 0.0, dy: 0.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        vec0 -= vec1
                        expect(vec0).to(equal(CGVector(dx: 0.0, dy: 0.0)))
                    }
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(vec0 - scalar).to(equal(CGVector(dx: 0.0, dy: 0.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        vec0 -= scalar
                        expect(vec0).to(equal(CGVector(dx: 0.0, dy: 0.0)))
                    }

                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        expect(vec0 * vec1).to(equal(CGVector(dx: 100.0, dy: 100.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        vec0 *= vec1
                        expect(vec0).to(equal(CGVector(dx: 100.0, dy: 100.0)))
                    }
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(vec0 * scalar).to(equal(CGVector(dx: 100.0, dy: 100.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        vec0 *= scalar
                        expect(vec0).to(equal(CGVector(dx: 100.0, dy: 100.0)))
                    }

                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        expect(vec0 / vec1).to(equal(CGVector(dx: 1.0, dy: 1.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 10.0, dy: 10.0)
                        vec0 /= vec1
                        expect(vec0).to(equal(CGVector(dx: 1.0, dy: 1.0)))
                    }
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        expect(vec0 / scalar).to(equal(CGVector(dx: 1.0, dy: 1.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let scalar: CGFloat = 10.0
                        vec0 /= scalar
                        expect(vec0).to(equal(CGVector(dx: 1.0, dy: 1.0)))
                    }
                    do {
                        expect(CGVector(angle: 0.0)).to(equal(CGVector(dx: 1.0, dy: 0.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        expect(vec0.offset(dx: 10.0, dy: 10.0)).to(equal(CGVector(dx: 20.0, dy: 20.0)))
                    }
                    do {
                        var vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 20.0, dy: 20.0)
                        expect(vec0.lengthSquared()).to(equal(200.0))
                        expect(vec0.length()).to(equal(14.142135623730951))
                        expect(vec0.distanceTo(vec1)).to(equal(14.142135623730951))
                        expect(vec0.normalized()).to(equal(CGVector(dx: 0.7071067811865475, dy: 0.7071067811865475)))
                        expect(vec0.normalize()).to(equal(CGVector(dx: 0.7071067811865475, dy: 0.7071067811865475)))
                    }
                    do {
                        let vec0: CGVector = .init(dx: 10.0, dy: 10.0)
                        let vec1: CGVector = .init(dx: 20.0, dy: 20.0)
                        expect(CGVector.lerp(start: vec0, end: vec1, t: 2)).to(equal(CGVector(dx: 30.0, dy: 30.0)))
                    }
                }
            }

            describe("CGColor") {
                it("Conversion") {
                    let rgba0: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [])!.rgba
                    expect(rgba0.red).to(beCloseTo(0.0))
                    expect(rgba0.green).to(beCloseTo(0.0))
                    expect(rgba0.blue).to(beCloseTo(0.0))
                    expect(rgba0.alpha).to(beCloseTo(0.0))
                    let rgba1: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1])?.rgba
                    expect(rgba1?.red).to(beCloseTo(1.0))
                    expect(rgba1?.green).to(beCloseTo(0.0))
                    expect(rgba1?.blue).to(beCloseTo(0.0))
                    expect(rgba1?.alpha).to(beCloseTo(0.0))
                    let rgba2: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1, 0, 0])?.rgba
                    expect(rgba2?.red).to(beCloseTo(1.0))
                    expect(rgba2?.green).to(beCloseTo(0.0))
                    expect(rgba2?.blue).to(beCloseTo(0.0))
                    expect(rgba2?.alpha).to(beCloseTo(0.0))
                    let rgba3: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1, 0, 0, 0.5])?.rgba
                    expect(rgba3?.red).to(beCloseTo(1.0))
                    expect(rgba3?.green).to(beCloseTo(0.0))
                    expect(rgba3?.blue).to(beCloseTo(0.0))
                    expect(rgba3?.alpha).to(beCloseTo(0.5))
                }
                it("Calculation") {
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        expect(col0 + col1).to(equal(UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        expect(col0 - col1).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 0).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        col0 += col1
                        expect(col0 + col1).to(equal(UIColor(red: 1, green: 1, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        expect(col0 + scalar).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        col0 += scalar
                        expect(col0).to(equal(UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor))
                    }

                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        expect(col0 - col1).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 0).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        col0 -= col1
                        expect(col0).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 0).cgColor))
                    }
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        expect(col0 - scalar).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        col0 -= scalar
                        expect(col0).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 0).cgColor))
                    }

                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        expect(col0 * col1).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 0, green: 1, blue: 0, alpha: 1).cgColor
                        col0 *= col1
                        expect(col0).to(equal(UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        expect(col0 * scalar).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 01).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        col0 *= scalar
                        expect(col0).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor))
                    }

                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                        expect(col0 / col1).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let col1: CGColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
                        col0 /= col1
                        expect(col0).to(equal(UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor))
                    }
                    do {
                        let col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        expect(col0 / scalar).to(equal(UIColor(red: 0.1, green: 0, blue: 0, alpha: 0.1).cgColor))
                    }
                    do {
                        var col0: CGColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
                        let scalar: CGFloat = 10.0
                        col0 /= scalar
                        expect(col0).to(equal(UIColor(red: 0.1, green: 0, blue: 0, alpha: 0.1).cgColor))
                    }
                }
                it("Calculation") {
//                    do {
//                        expect(CGColor(angle: 0.0)).to(equal(CGColor(dx: 1.0, dy: 0.0)))
//                    }
//                    do {
//                        var col0: CGColor = .init(dx: 10.0, dy: 10.0)
//                        expect(col0.offset(dx: 10.0, dy: 10.0)).to(equal(CGColor(dx: 20.0, dy: 20.0)))
//                    }
//                    do {
//                        var col0: CGColor = .init(dx: 10.0, dy: 10.0)
//                        let col1: CGColor = .init(dx: 20.0, dy: 20.0)
//                        expect(col0.lengthSquared()).to(equal(200.0))
//                        expect(col0.length()).to(equal(14.142135623730951))
//                        expect(col0.distanceTo(col1)).to(equal(14.142135623730951))
//                        expect(col0.normalized()).to(equal(CGColor(dx: 0.7071067811865475, dy: 0.7071067811865475)))
//                        expect(col0.normalize()).to(equal(CGColor(dx: 0.7071067811865475, dy: 0.7071067811865475)))
//                    }
                }
            }
//            description("CGAffineTransform") {
//                it("Calculate") {
//                }
//            }
        }
    }
}
