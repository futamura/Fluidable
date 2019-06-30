//
//  QuartzCore+Ext.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import CoreGraphics

/* MARK: - Frame & Struct */
internal extension CALayer {
    var origin: CGPoint {
        get { return frame.origin }
        set { frame = CGRect(x: newValue.x, y: newValue.y, width: width, height: height) }
    }

    var size: CGSize {
        get { return frame.size }
        set { frame = CGRect(x: minX, y: minY, width: newValue.width, height: newValue.height) }
    }

    var minX: CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(x: newValue, y: minY, width: width, height: height) }
    }

    var left: CGFloat {
        get { return frame.origin.x }
        set { frame = CGRect(x: newValue, y: minY, width: width, height: height) }
    }

    var midX: CGFloat {
        get { return frame.midX }
        set { frame = CGRect(x: newValue - width * 0.5, y: minY, width: width, height: height) }
    }

    var centerX: CGFloat {
        get { return frame.midX }
        set { frame = CGRect(x: newValue - width * 0.5, y: minY, width: width, height: height) }
    }

    var maxX: CGFloat {
        get { return minX + width }
        set { frame = CGRect(x: newValue - width, y: minY, width: width, height: height) }
    }

    var right: CGFloat {
        get { return minX + width }
        set { frame = CGRect(x: newValue - width, y: minY, width: width, height: height) }
    }

    var minY: CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(x: minX, y: newValue, width: width, height: height) }
    }

    var top: CGFloat {
        get { return frame.origin.y }
        set { frame = CGRect(x: minX, y: newValue, width: width, height: height) }
    }

    var midY: CGFloat {
        get { return frame.midY }
        set { frame = CGRect(x: minX, y: newValue - height * 0.5, width: width, height: height) }
    }

    var centerY: CGFloat {
        get { return frame.midY }
        set { frame = CGRect(x: minX, y: newValue - height * 0.5, width: width, height: height) }
    }

    var maxY: CGFloat {
        get { return minY + height }
        set { frame = CGRect(x: minX, y: newValue - height, width: width, height: height) }
    }

    var bottom: CGFloat {
        get { return minY + height }
        set { frame = CGRect(x: minX, y: newValue - height, width: width, height: height) }
    }

    var width: CGFloat {
        get { return bounds.width }
        set { frame = CGRect(x: minX, y: minY, width: newValue, height: height) }
    }

    var height: CGFloat {
        get { return bounds.height }
        set { frame = CGRect(x: minX, y: minY, width: width, height: newValue) }
    }

    var center: CGPoint {
        set { frame = CGRect(x: newValue.x - frame.size.width * 0.5, y: newValue.y - frame.size.height * 0.5, width: width, height: height) }
        get { return CGPoint(x: origin.x + size.width * 0.5, y: origin.y + size.height * 0.5) }
    }
}

internal extension CALayer {
    func sublayer(with name: String) -> CALayer? {
        return self.sublayers?.first { $0.name == name }
    }
}

internal extension CALayer {
    var snapshotImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
        guard let context: CGContext = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    func setShadow(color: UIColor, offset: CGSize, radius: CGFloat) {
        shadowColor = color.cgColor
        shadowOffset = offset
        shadowRadius = radius
        shadowOpacity = 1
        shouldRasterize = true
        rasterizationScale = UIScreen.main.scale
    }

    func removeAllSublayers() {
        sublayers?.forEach { (sender) in
            sender.removeFromSuperlayer()
        }
    }
}

/**
 CATransform3D
 */
public extension CATransform3D {
    init(with transform: CGAffineTransform) { self = CATransform3DMakeAffineTransform(transform) }
    init(tx: CGFloat = 0, ty: CGFloat = 0, tz: CGFloat = 0) { self = CATransform3DMakeTranslation(tx, ty, tz) }
    init(scale: CGFloat) { self = CATransform3DMakeScale(scale, scale, scale) }
    init(sx: CGFloat = 1, sy: CGFloat = 1, sz: CGFloat = 1) { self = CATransform3DMakeScale(sx, sy, sz) }
    init(angle: CGFloat, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) { self = CATransform3DMakeRotation(angle, x, y, z) }
}

public extension CATransform3D {
    static var identity: CATransform3D { return CATransform3DIdentity }
    var isIdentity: Bool { return CATransform3DIsIdentity(self) }
}

public extension CATransform3D {
    var affineTransform: CGAffineTransform? {
        if !CATransform3DIsAffine(self) { return nil }
        return CATransform3DGetAffineTransform(self)
    }
}

public extension CATransform3D {
    func translated(x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DTranslate(self, x, y, z)
    }

    func scaled(x: CGFloat = 1, y: CGFloat = 1, z: CGFloat = 1) -> CATransform3D {
        return CATransform3DScale(self, x, y, z)
    }

    func scaled(s: CGFloat) -> CATransform3D {
        return CATransform3DScale(self, s, s, s)
    }

    func rotated(by angle: CGFloat, x: CGFloat = 0, y: CGFloat = 0, z: CGFloat = 0) -> CATransform3D {
        return CATransform3DRotate(self, angle, x, y, z)
    }

    func concatenated(with transform: CATransform3D) -> CATransform3D {
        return CATransform3DConcat(self, transform)
    }

    /** Inverts the receiver. Stays at the original matrix if the receiver has no inverse. */
    mutating func invert() {
        self = self.inverted
    }

    /** Invert and return the result. Returns the original matrix if the receiver has no inverse. */
    var inverted: CATransform3D {
        return CATransform3DInvert(self)
    }
}

public extension CATransform3D {
}

extension CATransform3D: Equatable {
    public static func == (lhs: CATransform3D, rhs: CATransform3D) -> Bool {
        return CATransform3DEqualToTransform(lhs, rhs)
    }
}

internal extension CATransform3D {
    static prefix func - (transform: CATransform3D) -> CATransform3D {
        return transform.inverted
    }

    static func + (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
        return CATransform3D(m11: lhs.m11 + rhs.m11, m12: lhs.m12 + rhs.m12, m13: lhs.m13 + rhs.m13, m14: lhs.m14 + rhs.m14,
                             m21: lhs.m21 + rhs.m21, m22: lhs.m22 + rhs.m22, m23: lhs.m23 + rhs.m23, m24: lhs.m24 + rhs.m24,
                             m31: lhs.m31 + rhs.m31, m32: lhs.m32 + rhs.m32, m33: lhs.m33 + rhs.m33, m34: lhs.m34 + rhs.m34,
                             m41: lhs.m41 + rhs.m41, m42: lhs.m42 + rhs.m42, m43: lhs.m43 + rhs.m43, m44: lhs.m44 + rhs.m44)
    }
    static func + (transform: CATransform3D, scalar: CGFloat) -> CATransform3D {
        return CATransform3D(m11: transform.m11 + scalar, m12: transform.m12 + scalar, m13: transform.m13 + scalar, m14: transform.m14 + scalar,
                             m21: transform.m21 + scalar, m22: transform.m22 + scalar, m23: transform.m23 + scalar, m24: transform.m24 + scalar,
                             m31: transform.m31 + scalar, m32: transform.m32 + scalar, m33: transform.m33 + scalar, m34: transform.m34 + scalar,
                             m41: transform.m41 + scalar, m42: transform.m42 + scalar, m43: transform.m43 + scalar, m44: transform.m44 + scalar)
    }

    static func += (lhs: inout CATransform3D, rhs: CATransform3D) { lhs = lhs + rhs }
    static func += (transform: inout CATransform3D, scalar: CGFloat) { transform = transform + scalar }

    static func - (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D { return lhs + (-rhs) }
    static func - (transform: CATransform3D, scalar: CGFloat) -> CATransform3D {
        return CATransform3D(m11: transform.m11 - scalar, m12: transform.m12 - scalar, m13: transform.m13 - scalar, m14: transform.m14 - scalar,
                             m21: transform.m21 - scalar, m22: transform.m22 - scalar, m23: transform.m23 - scalar, m24: transform.m24 - scalar,
                             m31: transform.m31 - scalar, m32: transform.m32 - scalar, m33: transform.m33 - scalar, m34: transform.m34 - scalar,
                             m41: transform.m41 - scalar, m42: transform.m42 - scalar, m43: transform.m43 - scalar, m44: transform.m44 - scalar)
    }

    static func -= (lhs: inout CATransform3D, rhs: CATransform3D) { lhs = lhs - rhs }
    static func -= (transform: inout CATransform3D, scalar: CGFloat) { transform = transform - scalar }

    static func * (lhs: CATransform3D, rhs: CATransform3D) -> CATransform3D {
        return lhs.concatenated(with: rhs)
    }
    static func * (transform: CATransform3D, scalar: CGFloat) -> CATransform3D {
        return CATransform3D(m11: transform.m11 * scalar, m12: transform.m12 * scalar, m13: transform.m13 * scalar, m14: transform.m14 * scalar,
                             m21: transform.m21 * scalar, m22: transform.m22 * scalar, m23: transform.m23 * scalar, m24: transform.m24 * scalar,
                             m31: transform.m31 * scalar, m32: transform.m32 * scalar, m33: transform.m33 * scalar, m34: transform.m34 * scalar,
                             m41: transform.m41 * scalar, m42: transform.m42 * scalar, m43: transform.m43 * scalar, m44: transform.m44 * scalar)
    }

    static func *= (lhs: inout CATransform3D, rhs: CATransform3D) { lhs = lhs * rhs }
    static func *= (transform: inout CATransform3D, scalar: CGFloat) { transform = transform * scalar }

    static func / (transform: CATransform3D, scalar: CGFloat) -> CATransform3D {
        guard scalar != 0 else { fatalError("Can't divide by 0.") }
        return CATransform3D(m11: transform.m11 / scalar, m12: transform.m12 / scalar, m13: transform.m13 / scalar, m14: transform.m14 / scalar,
                             m21: transform.m21 / scalar, m22: transform.m22 / scalar, m23: transform.m23 / scalar, m24: transform.m24 / scalar,
                             m31: transform.m31 / scalar, m32: transform.m32 / scalar, m33: transform.m33 / scalar, m34: transform.m34 / scalar,
                             m41: transform.m41 / scalar, m42: transform.m42 / scalar, m43: transform.m43 / scalar, m44: transform.m44 / scalar)
    }
    static func /= (transform: inout CATransform3D, scalar: CGFloat) { transform = transform / scalar }
}

extension CATransform3D {
    func decompose() -> (translation: Vector3, rotation: Vector3, scale: Vector3) {
        let m1 = Vector3(Float(self.m11), Float(self.m12), Float(self.m13))
        let m2 = Vector3(Float(self.m21), Float(self.m22), Float(self.m23))
        let m3 = Vector3(Float(self.m31), Float(self.m32), Float(self.m33))
        let m4 = Vector3(Float(self.m41), Float(self.m42), Float(self.m43))

        let t: Vector3 = m4

        let sx: Scalar = m1.length
        let sy: Scalar = m2.length
        let sz: Scalar = m3.length
        let s: Vector3 = Vector3(sx, sy, sz)

        let rx: Vector3 = m1 * sx
        let ry: Vector3 = m2 * sy
        let rz: Vector3 = m3 * sz

        let pitch: Float = atan2(ry.z, rz.z)
        let yaw: Float = atan2(-rx.z, hypot(ry.z, rz.z))
        let roll: Float = atan2(rx.y, rx.x)
        let r = Vector3(pitch, yaw, roll)

        return (t, r, s)
    }
}