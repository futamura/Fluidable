//
//  QuartzCoreSpec.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class QuartzCoreSpec: QuickSpec {
    override func spec() {
        describe("QuartzCore") {
            describe("CALayer") {
                it("Property") {
                    let layer: CALayer = .init()
                    layer.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
                    layer.origin = CGPoint(x: 10, y: 10)
                    expect(layer.origin).to(equal(CGPoint(x: 10, y: 10)))
                    layer.size = CGSize(width: 100, height: 100)
                    expect(layer.size).to(equal(CGSize(width: 100, height: 100)))
                    layer.minX = 20
                    layer.minY = 20
                    expect(layer.minX).to(equal(20))
                    expect(layer.minY).to(equal(20))
                    layer.left = 40
                    layer.top = 40
                    expect(layer.left).to(equal(40))
                    expect(layer.top).to(equal(40))
                    layer.midX = 70
                    layer.midY = 70
                    expect(layer.midX).to(equal(70))
                    expect(layer.midY).to(equal(70))
                    layer.maxX = 140
                    layer.maxY = 140
                    expect(layer.maxX).to(equal(140))
                    expect(layer.maxY).to(equal(140))
                    layer.center = CGPoint(x: 60, y: 60)
                    expect(layer.center).to(equal(CGPoint(x: 60, y: 60)))
                    layer.centerX = 50
                    layer.centerY = 50
                    expect(layer.centerX).to(equal(50))
                    expect(layer.centerY).to(equal(50))
                    layer.right = 140
                    layer.bottom = 140
                    expect(layer.right).to(equal(140))
                    expect(layer.bottom).to(equal(140))
                    layer.width = 200
                    layer.height = 200
                    expect(layer.width).to(equal(200))
                    expect(layer.height).to(equal(200))
                }
                it("Utility") {
                    let layer: CALayer = .init()
                    layer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
                    let subLayer: CALayer = .init()
                    subLayer.name = "sublayer0"
                    subLayer.frame = CGRect(x: 10, y: 10, width: 100, height: 100)
                    layer.addSublayer(subLayer)
                    expect(layer.sublayer(with: "sublayer0")).notTo(beNil())
                    expect(layer.sublayer(with: "sublayer1")).to(beNil())
                    expect(layer.snapshotImage?.size).to(equal(CGSize(width: 100, height: 100)))
                    layer.setShadow(color: .black, offset: .zero, radius: 10)
                    expect(layer.shadowColor).to(equal(UIColor.black.cgColor))
                    expect(layer.shadowOffset).to(equal(.zero))
                    expect(layer.shadowRadius).to(equal(10))
                    layer.removeAllSublayers()
                    expect(layer.sublayer(with: "sublayer0")).to(beNil())
                }
            }
            describe("CATransform3D") {
                it("Initialization") {
                    let trans0: CATransform3D = CATransform3D(with: CGAffineTransform(tx: 2, ty: 2))
                    expect(trans0).to(equal(CATransform3D(m11: 1.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 2.0, m42: 2.0, m43: 0.0, m44: 1.0)))
                    let trans1: CATransform3D = CATransform3D(tx: 2, ty: 2, tz: 2)
                    expect(trans1).to(equal(CATransform3D(m11: 1.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 2.0, m42: 2.0, m43: 2.0, m44: 1.0)))
                    let trans2: CATransform3D = CATransform3D(scale: 2)
                    expect(trans2).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 2.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 1.0)))
                    let trans3: CATransform3D = CATransform3D(sx: 2, sy: 2)
                    expect(trans3).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 1.0)))
                    let trans4: CATransform3D = CATransform3D(angle: CGFloat.pi, x: 0, y: 0, z: 0)
                    expect(trans4).to(equal(CATransform3D(m11: 1.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 0.0, m42: 0.0, m43: 0.0, m44: 1.0)))
                }
                it("Property") {
                    expect(CATransform3D.identity).to(equal(CATransform3DIdentity))
                    expect(CATransform3D.identity.isIdentity).to(beTrue())
                    expect(CATransform3D(with: CGAffineTransform(tx: 2, ty: 2)).isIdentity).to(beFalse())
                    expect(CATransform3D.identity.affineTransform).to(equal(CGAffineTransform.identity))
                    expect(CATransform3D(with: CGAffineTransform(tx: 2, ty: 2)).affineTransform).to(equal(CGAffineTransform(tx: 2, ty: 2)))
                }
                it("Transform") {
                    expect(CATransform3D.identity.translated(x: 2, y: 2)).to(equal(CATransform3D(tx: 2, ty: 2)))
                    expect(CATransform3D.identity.scaled(x: 2, y: 2, z: 2)).to(equal(CATransform3D(sx: 2, sy: 2, sz: 2)))
                    expect(CATransform3D.identity.scaled(s: 2)).to(equal(CATransform3D(sx: 2, sy: 2, sz: 2)))
                    do {
                        var trans: CATransform3D = CATransform3D.identity.translated(x: 2, y: 2)
                        trans.invert()
                        expect(trans).to(equal(CATransform3D(tx: -2, ty: -2)))
                    }
                    expect(CATransform3D.identity.translated(x: 2, y: 2).inverted).to(equal(CATransform3D(tx: -2, ty: -2)))
                    expect(CATransform3D.identity.rotated(by: CGFloat.pi, x: 0, y: 0, z: 0)).to(equal(CATransform3D(angle: CGFloat.pi, x: 0, y: 0, z: 0)))
                    expect(CATransform3D.identity.translated(x: 2, y: 2).concatenated(with: CATransform3D(tx: 2, ty: 2))).to(equal(CATransform3D(tx: 4, ty: 4)))
                }
                it("calculate") {
                    expect(-CATransform3D(tx: 2, ty: 2)).to(equal(CATransform3D(tx: -2, ty: -2)))
                    expect(CATransform3D(tx: 2, ty: 2) + CATransform3D(tx: 4, ty: 4)).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 2.0, m34: 0.0, m41: 6.0, m42: 6.0, m43: 0.0, m44: 2.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans += CATransform3D(tx: 4, ty: 4)
                        expect(trans).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 2.0, m34: 0.0, m41: 6.0, m42: 6.0, m43: 0.0, m44: 2.0)))
                    }
                    expect(CATransform3D(tx: 2, ty: 2) + 4).to(equal(CATransform3D(m11: 5.0, m12: 4.0, m13: 4.0, m14: 4.0, m21: 4.0, m22: 5.0, m23: 4.0, m24: 4.0, m31: 4.0, m32: 4.0, m33: 5.0, m34: 4.0, m41: 6.0, m42: 6.0, m43: 4.0, m44: 5.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans += 4
                        expect(trans).to(equal(CATransform3D(m11: 5.0, m12: 4.0, m13: 4.0, m14: 4.0, m21: 4.0, m22: 5.0, m23: 4.0, m24: 4.0, m31: 4.0, m32: 4.0, m33: 5.0, m34: 4.0, m41: 6.0, m42: 6.0, m43: 4.0, m44: 5.0)))
                    }

                    expect(CATransform3D(tx: 2, ty: 2) - CATransform3D(tx: 4, ty: 4)).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 2.0, m34: 0.0, m41: -2.0, m42: -2.0, m43: 0.0, m44: 2.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans -= CATransform3D(tx: 4, ty: 4)
                        expect(trans).to(equal(CATransform3D(m11: 2.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 2.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 2.0, m34: 0.0, m41: -2.0, m42: -2.0, m43: 0.0, m44: 2.0)))
                    }
                    expect(CATransform3D(tx: 2, ty: 2) - 4).to(equal(CATransform3D(m11: -3.0, m12: -4.0, m13: -4.0, m14: -4.0, m21: -4.0, m22: -3.0, m23: -4.0, m24: -4.0, m31: -4.0, m32: -4.0, m33: -3.0, m34: -4.0, m41: -2.0, m42: -2.0, m43: -4.0, m44: -3.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans -= 4
                        expect(trans).to(equal(CATransform3D(m11: -3.0, m12: -4.0, m13: -4.0, m14: -4.0, m21: -4.0, m22: -3.0, m23: -4.0, m24: -4.0, m31: -4.0, m32: -4.0, m33: -3.0, m34: -4.0, m41: -2.0, m42: -2.0, m43: -4.0, m44: -3.0)))
                    }

                    expect(CATransform3D(tx: 2, ty: 2) * CATransform3D(tx: 4, ty: 4)).to(equal(CATransform3D(m11: 1.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 6.0, m42: 6.0, m43: 0.0, m44: 1.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans *= CATransform3D(tx: 4, ty: 4)
                        expect(trans).to(equal(CATransform3D(m11: 1.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 1.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 1.0, m34: 0.0, m41: 6.0, m42: 6.0, m43: 0.0, m44: 1.0)))
                    }
                    expect(CATransform3D(tx: 2, ty: 2) * 4).to(equal(CATransform3D(m11: 4.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 4.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 4.0, m34: 0.0, m41: 8.0, m42: 8.0, m43: 0.0, m44: 4.0)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans *= 4
                        expect(trans).to(equal(CATransform3D(m11: 4.0, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 4.0, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 4.0, m34: 0.0, m41: 8.0, m42: 8.0, m43: 0.0, m44: 4.0)))
                    }

                    expect(CATransform3D(tx: 2, ty: 2) / 4).to(equal(CATransform3D(m11: 0.25, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.25, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.25, m34: 0.0, m41: 0.5, m42: 0.5, m43: 0.0, m44: 0.25)))
                    do {
                        var trans = CATransform3D(tx: 2, ty: 2)
                        trans /= 4
                        expect(trans).to(equal(CATransform3D(m11: 0.25, m12: 0.0, m13: 0.0, m14: 0.0, m21: 0.0, m22: 0.25, m23: 0.0, m24: 0.0, m31: 0.0, m32: 0.0, m33: 0.25, m34: 0.0, m41: 0.5, m42: 0.5, m43: 0.0, m44: 0.25)))
                    }

                    do {
                        var trans: CATransform3D = .identity
                        trans = trans.translated(x: 2, y: 2, z: 2)
                        expect(trans.decompose().translation).to(equal(Vector3(x: 2, y: 2, z: 2)))
                        trans = trans.scaled(x: 2, y: 2, z: 2)
                        expect(trans.decompose().scale).to(equal(Vector3(x: 2, y: 2, z: 2)))
                        trans = trans.rotated(by: CGFloat.pi, x: 1, y: 0, z: 0)
                        expect(trans.decompose().rotation).to(equal(Vector3(x: Float.pi, y: 0, z: 0)))
                    }
                }
            }
        }
    }
}
