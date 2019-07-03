//
//  CoreGraphics+Ext.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import CoreGraphics

extension Comparable {
    func clamped(_ lower: ClosedRange<Self>.Bound, _ upper: ClosedRange<Self>.Bound) -> Self {
        return self < lower ? lower : (upper < self ? upper : self)
    }

    func clamped(to range: ClosedRange<Self>) -> Self {
        return self.clamped(range.lowerBound, range.upperBound)
    }

    mutating func clamp(_ lower: ClosedRange<Self>.Bound, _ upper: ClosedRange<Self>.Bound) {
        self = self.clamped(lower, upper)
    }

    mutating func clamp(to range: ClosedRange<Self>) {
        self = self.clamped(range.lowerBound, range.upperBound)
    }
}

//internal extension BinaryInteger {
//    var degreesToRadians: CGFloat { return CGFloat(Int(self)) * .pi / 180 }
//}

internal extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

extension Float {
    func decimal(_ digit: Int = 3) -> Float {
        let d: Float = pow(10, Float(digit))
        return (self * d).rounded() / d
    }
}

extension Double {
    func decimal(_ digit: Int = 3) -> Double {
        let d: Double = pow(10, Double(digit))
        return (self * d).rounded() / d
    }
}

internal extension CGFloat {
    func decimal(_ digit: CGFloat = 3) -> CGFloat {
        let d: CGFloat = pow(10, digit.rounded())
        return (self * d).rounded() / d
    }
}

internal extension CGFloat {
    static var pi2: CGFloat { return CGFloat.pi / 2 }
    static var pi4: CGFloat { return CGFloat.pi / 4 }
    static var pi8: CGFloat { return CGFloat.pi / 8 }
}

//extension CGFloat {
//    public var description: String {
//        return String(describing: self.decimal(4))
//    }
//}

internal extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y) }
    static func + (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x + scalar, y: point.y + scalar) }

    static func += (lhs: inout CGPoint, rhs: CGPoint) { return lhs = lhs + rhs }
    static func += (point: inout CGPoint, scalar: CGFloat) { return point = point + scalar }

    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y) }
    static func - (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x - scalar, y: point.y - scalar) }

    static func -= (lhs: inout CGPoint, rhs: CGPoint) { return lhs = lhs - rhs }
    static func -= (point: inout CGPoint, scalar: CGFloat) { return point = point - scalar }

    static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y) }
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x * scalar, y: point.y * scalar) }

    static func *= (lhs: inout CGPoint, rhs: CGPoint) { return lhs = lhs * rhs }
    static func *= (point: inout CGPoint, scalar: CGFloat) { return point = point * scalar }

    static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint { return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y) }
    static func / (point: CGPoint, scalar: CGFloat) -> CGPoint { return CGPoint(x: point.x / scalar, y: point.y / scalar) }

    static func /= (lhs: inout CGPoint, rhs: CGPoint) { return lhs = lhs / rhs }
    static func /= (point: inout CGPoint, scalar: CGFloat) { return point = point / scalar }
    /**
     A function normalizing content offset.
     */
    func normalize(from inset: UIEdgeInsets) -> CGPoint { return CGPoint(x: self.x + inset.left, y: self.y + inset.top) }

    /**
     A function reverting a normalized content offset.
     */
    func revert(to inset: UIEdgeInsets) -> CGPoint { return CGPoint(x: self.x - inset.left, y: self.y - inset.top) }

    func distance(to point: CGPoint) -> CGFloat { return (self - point).length() }

    func length() -> CGFloat { return sqrt(x * x + y * y) }
}

//extension CGPoint: CustomStringConvertible {
//    public var description: String {
//        return "(x: \(self.x.decimal(4)), y: \(self.y.decimal(4)))"
//    }
//}

internal extension CGSize {
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    static func + (size: CGSize, scalar: CGFloat) -> CGSize { return CGSize(width: size.width + scalar, height: size.height + scalar) }

    static func += (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs + rhs }
    static func += (size: inout CGSize, scalar: CGFloat) { return size = size + scalar }

    static func - (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height) }
    static func - (size: CGSize, scalar: CGFloat) -> CGSize { return CGSize(width: size.width - scalar, height: size.height - scalar) }

    static func -= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs - rhs }
    static func -= (size: inout CGSize, rhs: CGFloat) { return size = size - rhs }

    static func * (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height) }
    static func * (size: CGSize, scalar: CGFloat) -> CGSize { return CGSize(width: size.width * scalar, height: size.height * scalar) }

    static func *= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs * rhs }
    static func *= (size: inout CGSize, scalar: CGFloat) { return size = size * scalar }

    static func / (lhs: CGSize, rhs: CGSize) -> CGSize { return CGSize(width: lhs.width / rhs.width, height: lhs.height / rhs.height) }
    static func / (size: CGSize, scalar: CGFloat) -> CGSize { return CGSize(width: size.width / scalar, height: size.height / scalar) }

    static func /= (lhs: inout CGSize, rhs: CGSize) { return lhs = lhs / rhs }
    static func /= (size: inout CGSize, scalar: CGFloat) { return size = size / scalar }

    var isPortrait: Bool { return self.width <= self.height }
    var isLandscape: Bool { return self.width > self.height }
    var orientation: UIInterfaceOrientation { return (self.width <= self.height) ? .portrait : .landscapeLeft }
}

//extension CGSize: CustomStringConvertible {
//    public var description: String {
//        return "(w: \(self.width.decimal(4)), h: \(self.height.decimal(4)))"
//    }
//}

internal extension CGRect {
    var bounds: CGRect {
        return CGRect(x: 0, y: 0, width: self.width, height: self.height)
    }
    var position: CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

internal extension CGRect {
    static func + (lhs: CGRect, rhs: CGRect) -> CGRect { return CGRect(x: lhs.origin.x + rhs.origin.x, y: lhs.origin.y + rhs.origin.y, width: lhs.width + rhs.width, height: lhs.height + rhs.height) }
    static func + (rect: CGRect, scalar: CGFloat) -> CGRect { return CGRect(x: rect.origin.x + scalar, y: rect.origin.y + scalar, width: rect.width + scalar, height: rect.height + scalar) }

    static func += (lhs: inout CGRect, rhs: CGRect) { lhs = lhs + rhs }
    static func += (rect: inout CGRect, scalar: CGFloat) { rect = rect + scalar }

    static func - (lhs: CGRect, rhs: CGRect) -> CGRect { return CGRect(x: lhs.origin.x - rhs.origin.x, y: lhs.origin.y - rhs.origin.y, width: lhs.width - rhs.width, height: lhs.height - rhs.height) }
    static func - (rect: CGRect, scalar: CGFloat) -> CGRect { return CGRect(x: rect.origin.x - scalar, y: rect.origin.y - scalar, width: rect.width - scalar, height: rect.height - scalar) }

    static func -= (lhs: inout CGRect, rhs: CGRect) { lhs = lhs - rhs }
    static func -= (rect: inout CGRect, scalar: CGFloat) { rect = rect - scalar }

    static func * (lhs: CGRect, rhs: CGRect) -> CGRect { return CGRect(x: lhs.origin.x * rhs.origin.x, y: lhs.origin.y * rhs.origin.y, width: lhs.width * rhs.width, height: lhs.height * rhs.height) }
    static func * (rect: CGRect, scalar: CGFloat) -> CGRect { return CGRect(x: rect.origin.x * scalar, y: rect.origin.y * scalar, width: rect.width * scalar, height: rect.height * scalar) }

    static func *= (lhs: inout CGRect, rhs: CGRect) { lhs = lhs * rhs }
    static func *= (rect: inout CGRect, scalar: CGFloat) { rect = rect * scalar }

    static func / (lhs: CGRect, rhs: CGRect) -> CGRect { return CGRect(x: lhs.origin.x / rhs.origin.x, y: lhs.origin.y / rhs.origin.y, width: lhs.width / rhs.width, height: lhs.height / rhs.height) }
    static func / (rect: CGRect, scalar: CGFloat) -> CGRect { return CGRect(x: rect.origin.x / scalar, y: rect.origin.y / scalar, width: rect.width / scalar, height: rect.height / scalar) }

    static func /= (lhs: inout CGRect, rhs: CGRect) { lhs = lhs / rhs }
    static func /= (rect: inout CGRect, scalar: CGFloat) { rect = rect / scalar }
}

//extension CGRect: CustomStringConvertible {
//    public var description: String {
//        return "(x: \(self.origin.x.decimal(4)), y: \(self.origin.y.decimal(4)), w: \(self.bounds.width.decimal(4)), h: \(self.bounds.height.decimal(4)))"
//    }
//}

internal extension CGVector {
    /**
     Creates a new CGVector given a CGPoint.
     */
    init(point: CGPoint) {
        self.init(dx: point.x, dy: point.y)
    }

    /**
     Given an angle in radians, creates a vector of length 1.0 and returns the
     result as a new CGVector. An angle of 0 is assumed to point to the right.
     */
    init(angle: CGFloat) {
        self.init(dx: cos(angle), dy: sin(angle))
    }

    /**
     Adds (dx, dy) to the vector.
     */
    mutating func offset(dx: CGFloat, dy: CGFloat) -> CGVector {
        self.dx += dx
        self.dy += dy
        return self
    }

    /**
     Returns the length (magnitude) of the vector described by the CGVector.
     */
    func length() -> CGFloat { return sqrt(dx * dx + dy * dy) }

    /**
     Returns the squared length of the vector described by the CGVector.
     */
    func lengthSquared() -> CGFloat { return dx * dx + dy * dy }

    /**
     Normalizes the vector described by the CGVector to length 1.0 and returns
     the result as a new CGVector.
     */
    func normalized() -> CGVector {
        let len = length()
        return len > 0 ? self / len : CGVector.zero
    }

    /**
     Normalizes the vector described by the CGVector to length 1.0.
     */
    mutating func normalize() -> CGVector {
        self = normalized()
        return self
    }

    /**
     Calculates the distance between two CGVectors. Pythagoras!
     */
    func distanceTo(_ vector: CGVector) -> CGFloat { return (self - vector).length() }

    /**
     Returns the angle in radians of the vector described by the CGVector.
     The range of the angle is -π to π; an angle of 0 points to the right.
     */
    var angle: CGFloat { return atan2(dy, dx) }

    /**
     Rotate the vector.
     */
    func rotate(_ angle: CGFloat) -> CGVector { return CGVector(dx: dx * cos(angle) - dy * sin(angle), dy: dx * sin(angle) + dy * cos(angle)) }
}

internal extension CGVector {
    /** Adds two CGVector values and returns the result as a new CGVector. */
    static func + (lhs: CGVector, rhs: CGVector) -> CGVector { return CGVector(dx: lhs.dx + rhs.dx, dy: lhs.dy + rhs.dy) }
    /** Adds a CGFloat value to a CGVector value and returns the result as a new CGVector. */
    static func + (vector: CGVector, scalar: CGFloat) -> CGVector { return CGVector(dx: vector.dx + scalar, dy: vector.dy + scalar) }

    /** Increments a CGVector with the value of another. */
    static func += (lhs: inout CGVector, rhs: CGVector) { lhs = lhs + rhs }
    /** Increments a CGVector value with a CGFloat value. */
    static func += (vector: inout CGVector, scalar: CGFloat) { vector = vector + scalar }

    /** Subtracts two CGVector values and returns the result as a new CGVector. */
    static func - (lhs: CGVector, rhs: CGVector) -> CGVector { return CGVector(dx: lhs.dx - rhs.dx, dy: lhs.dy - rhs.dy) }
    /** Subtracts a CGFloat value from a CGVector value and returns the result as a new CGVector. */
    static func - (vector: CGVector, scalar: CGFloat) -> CGVector { return CGVector(dx: vector.dx - scalar, dy: vector.dy - scalar) }

    /** Decrements a CGVector with the value of another. */
    static func -= (lhs: inout CGVector, rhs: CGVector) { lhs = lhs - rhs }
    /** Decrements a CGVector with a CGFloat value. */
    static func -= (vector: inout CGVector, scalar: CGFloat) { vector = vector - scalar }

    /** Multiplies two CGVector values and returns the result as a new CGVector. */
    static func * (lhs: CGVector, rhs: CGVector) -> CGVector { return CGVector(dx: lhs.dx * rhs.dx, dy: lhs.dy * rhs.dy) }
    /** Multiplies the x and y fields of a CGVector with the same scalar value and returns the result as a new CGVector. */
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector { return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar) }

    /** Multiplies a CGVector with another. */
    static func *= (lhs: inout CGVector, rhs: CGVector) { lhs = lhs * rhs }
    /** Multiplies the x and y fields of a CGVector with the same scalar value. */
    static func *= (vector: inout CGVector, scalar: CGFloat) { vector = vector * scalar }

    /** Divides two CGVector values and returns the result as a new CGVector. */
    static func / (lhs: CGVector, rhs: CGVector) -> CGVector { return CGVector(dx: lhs.dx / rhs.dx, dy: lhs.dy / rhs.dy) }
    /** Divides the dx and dy fields of a CGVector by the same scalar value and returns the result as a new CGVector. */
    static func / (vector: CGVector, scalar: CGFloat) -> CGVector { return CGVector(dx: vector.dx / scalar, dy: vector.dy / scalar) }
    /** Divides a CGVector by another. */
    static func /= (lhs: inout CGVector, rhs: CGVector) { lhs = lhs / rhs }
    /** Divides the dx and dy fields of a CGVector by the same scalar value. */
    static func /= (vector: inout CGVector, scalar: CGFloat) { vector = vector / scalar }

    /** Performs a linear interpolation between two CGVector values. */
    static func lerp(start: CGVector, end: CGVector, t: CGFloat) -> CGVector { return start + (end - start) * t }
}

internal extension CGColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        if self.components?.count == 4 {
            return (red: self.components![0], green: self.components![1], blue: self.components![2], alpha: self.components![3])
        } else if self.components?.count == 3 {
            return (red: self.components![0], green: self.components![1], blue: self.components![2], alpha: 0)
        } else {
            return (red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
}

internal extension CGColor {
    static func + (lhs: CGColor, rhs: CGColor) -> CGColor {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return UIColor(red: (lhc.red + rhc.red).clamped(0, 1), green: (lhc.green + rhc.green).clamped(0, 1), blue: (lhc.blue + rhc.blue).clamped(0, 1), alpha: (lhc.alpha + rhc.alpha).clamped(0, 1)).cgColor
    }
    static func + (color: CGColor, scalar: CGFloat) -> CGColor {
        let c = color.rgba
        return UIColor(red: (c.red + scalar).clamped(0, 1), green: (c.green + scalar).clamped(0, 1), blue: (c.blue + scalar).clamped(0, 1), alpha: (c.alpha + scalar).clamped(0, 1)).cgColor
    }

    static func += (lhs: inout CGColor, rhs: CGColor) {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return lhs = UIColor(red: (lhc.red + rhc.red).clamped(0, 1), green: (lhc.green + rhc.green).clamped(0, 1), blue: (lhc.blue + rhc.blue).clamped(0, 1), alpha: (lhc.alpha + rhc.alpha).clamped(0, 1)).cgColor
    }
    static func += (color: inout CGColor, scalar: CGFloat) {
        let c = color.rgba
        return color = UIColor(red: (c.red + scalar).clamped(0, 1), green: (c.green + scalar).clamped(0, 1), blue: (c.blue + scalar).clamped(0, 1), alpha: (c.alpha + scalar).clamped(0, 1)).cgColor
    }

    static func - (lhs: CGColor, rhs: CGColor) -> CGColor {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return UIColor(red: (lhc.red - rhc.red).clamped(0, 1), green: (lhc.green - rhc.green).clamped(0, 1), blue: (lhc.blue - rhc.blue).clamped(0, 1), alpha: (lhc.alpha - rhc.alpha).clamped(0, 1)).cgColor
    }
    static func - (color: CGColor, scalar: CGFloat) -> CGColor {
        let c = color.rgba
        return UIColor(red: (c.red - scalar).clamped(0, 1), green: (c.green - scalar).clamped(0, 1), blue: (c.blue - scalar).clamped(0, 1), alpha: (c.alpha - scalar).clamped(0, 1)).cgColor
    }

    static func -= (lhs: inout CGColor, rhs: CGColor) {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return lhs = UIColor(red: (lhc.red - rhc.red).clamped(0, 1), green: (lhc.green - rhc.green).clamped(0, 1), blue: (lhc.blue - rhc.blue).clamped(0, 1), alpha: (lhc.alpha - rhc.alpha).clamped(0, 1)).cgColor
    }
    static func -= (color: inout CGColor, scalar: CGFloat) {
        let c = color.rgba
        return color = UIColor(red: (c.red - scalar).clamped(0, 1), green: (c.green - scalar).clamped(0, 1), blue: (c.blue - scalar).clamped(0, 1), alpha: (c.alpha - scalar).clamped(0, 1)).cgColor
    }

    static func * (lhs: CGColor, rhs: CGColor) -> CGColor {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return UIColor(red: (lhc.red * rhc.red).clamped(0, 1), green: (lhc.green * rhc.green).clamped(0, 1), blue: (lhc.blue * rhc.blue).clamped(0, 1), alpha: (lhc.alpha * rhc.alpha).clamped(0, 1)).cgColor
    }
    static func * (color: CGColor, scalar: CGFloat) -> CGColor {
        let c = color.rgba
        return UIColor(red: (c.red * scalar).clamped(0, 1), green: (c.green * scalar).clamped(0, 1), blue: (c.blue * scalar).clamped(0, 1), alpha: (c.alpha * scalar).clamped(0, 1)).cgColor
    }

    static func *= (lhs: inout CGColor, rhs: CGColor) {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return lhs = UIColor(red: (lhc.red * rhc.red).clamped(0, 1), green: (lhc.green * rhc.green).clamped(0, 1), blue: (lhc.blue * rhc.blue).clamped(0, 1), alpha: (lhc.alpha * rhc.alpha).clamped(0, 1)).cgColor
    }
    static func *= (color: inout CGColor, scalar: CGFloat) {
        let c = color.rgba
        return color = UIColor(red: (c.red * scalar).clamped(0, 1), green: (c.green * scalar).clamped(0, 1), blue: (c.blue * scalar).clamped(0, 1), alpha: (c.alpha * scalar).clamped(0, 1)).cgColor
    }

    static func / (lhs: CGColor, rhs: CGColor) -> CGColor {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return UIColor(red: (lhc.red / rhc.red).clamped(0, 1), green: (lhc.green / rhc.green).clamped(0, 1), blue: (lhc.blue / rhc.blue).clamped(0, 1), alpha: (lhc.alpha / rhc.alpha).clamped(0, 1)).cgColor
    }
    static func / (color: CGColor, scalar: CGFloat) -> CGColor {
        let c = color.rgba
        return UIColor(red: (c.red / scalar).clamped(0, 1), green: (c.green / scalar).clamped(0, 1), blue: (c.blue / scalar).clamped(0, 1), alpha: (c.alpha / scalar).clamped(0, 1)).cgColor
    }

    static func /= (lhs: inout CGColor, rhs: CGColor) {
        let lhc = lhs.rgba
        let rhc = rhs.rgba
        return lhs = UIColor(red: (lhc.red / rhc.red).clamped(0, 1), green: (lhc.green / rhc.green).clamped(0, 1), blue: (lhc.blue / rhc.blue).clamped(0, 1), alpha: (lhc.alpha / rhc.alpha).clamped(0, 1)).cgColor
    }
    static func /= (color: inout CGColor, scalar: CGFloat) {
        let c = color.rgba
        return color = UIColor(red: (c.red / scalar).clamped(0, 1), green: (c.green / scalar).clamped(0, 1), blue: (c.blue / scalar).clamped(0, 1), alpha: (c.alpha / scalar).clamped(0, 1)).cgColor
    }
}

public extension CGAffineTransform {
    init(tx: CGFloat = 0, ty: CGFloat = 0) {
        self = CGAffineTransform(translationX: tx, y: ty)
    }

    init(scale: CGFloat) {
        self = CGAffineTransform(scaleX: scale, y: scale)
    }

    init(sx: CGFloat = 1, sy: CGFloat = 1) {
        self = CGAffineTransform(scaleX: sx, y: sy)
    }

    init(angle: CGFloat) {
        self = CGAffineTransform(rotationAngle: angle)
    }

    init(_ transforms: CGAffineTransform...) {
        var transform: CGAffineTransform = .identity
        transforms.forEach { transform = transform.concatenating($0) }
        self = transform
    }
}

//extension CGAffineTransform: CustomStringConvertible {
//    public var description: String {
//        return "CGAffineTransform(\(a), \(b), \(c), \(d), \(tx), \(ty)), \(sx), \(sy))"
//    }
//}

internal extension CGAffineTransform {
    /* Extract translation */
    var translation: CGPoint { return CGPoint(x: self.tx, y: self.ty) }
    /* Extract scale X */
    var sx: CGFloat { return sqrt(self.a * self.a + self.c * self.c) }
    /* Extract scale Y */
    var sy: CGFloat { return sqrt(self.b * self.b + self.d * self.d) }
    /* Extract scale */
    var scale: CGPoint { return CGPoint(x: self.sx, y: self.sy) }
    /* Extract rotation angle */
    var rotation: CGFloat { return CGFloat(atan2(self.b, self.a)) }
}

extension CGAffineTransform {
    func translated(x: CGFloat = 0, y: CGFloat = 0) -> CGAffineTransform {
        return self.translatedBy(x: x, y: y)
    }

    func scaled(x: CGFloat = 1, y: CGFloat = 1) -> CGAffineTransform {
        return self.scaledBy(x: x, y: y)
    }

    func scaled(s: CGFloat) -> CGAffineTransform {
        return self.scaledBy(x: s, y: s)
    }

    func concatenated(_ transforms: CGAffineTransform...) -> CGAffineTransform {
        var transform: CGAffineTransform = .identity
        transforms.forEach { transform = transform.concatenating($0) }
        return transform
    }

    var inverted: CGAffineTransform {
        return self.inverted()
    }

    var integralTransform: CGAffineTransform {
        return CGAffineTransform(a: round(a), b: round(b), c: round(c), d: round(d), tx: round(tx), ty: round(ty))
    }
}

internal extension CGAffineTransform {
    static func + (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
        return CGAffineTransform(a: lhs.a + rhs.a, b: lhs.b + rhs.b,
                                 c: lhs.c + rhs.c, d: lhs.d + rhs.d,
                                 tx: lhs.tx + rhs.tx, ty: lhs.ty + rhs.ty)
    }

    static func += (lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
        lhs = lhs + rhs
    }

    static func - (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
        return lhs + (-rhs)
    }

    static func -= (lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
        lhs = lhs - rhs
    }

    static prefix func - (matrix: CGAffineTransform) -> CGAffineTransform {
        return -1 * matrix
    }

    static func * (lhs: CGAffineTransform, rhs: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(a: lhs.a * rhs, b: lhs.b * rhs,
                                 c: lhs.c * rhs, d: lhs.d * rhs,
                                 tx: lhs.tx * rhs, ty: lhs.ty * rhs)
    }

    static func * (lhs: CGFloat, rhs: CGAffineTransform) -> CGAffineTransform {
        return rhs * lhs
    }

    static func * (lhs: CGAffineTransform, rhs: CGAffineTransform) -> CGAffineTransform {
        return lhs.concatenating(rhs)
    }

    static func *= (lhs: inout CGAffineTransform, rhs: CGAffineTransform) {
        lhs = lhs * rhs
    }

    static func * (lhs: CGPoint, rhs: CGAffineTransform) -> CGPoint {
        return lhs.applying(rhs)
    }

    static func *= (lhs: inout CGPoint, rhs: CGAffineTransform) {
        lhs = lhs * rhs
    }

    static func * (lhs: CGSize, rhs: CGAffineTransform) -> CGSize {
        return lhs.applying(rhs)
    }

    static func *= (lhs: inout CGSize, rhs: CGAffineTransform) {
        lhs = lhs * rhs
    }

    static func * (lhs: CGRect, rhs: CGAffineTransform) -> CGRect {
        return lhs.applying(rhs)
    }

    static func *= (lhs: inout CGRect, rhs: CGAffineTransform) {
        lhs = lhs * rhs
    }

    static func / (lhs: CGAffineTransform, rhs: CGFloat) -> CGAffineTransform {
        guard rhs != 0 else { fatalError("Can't divide by 0") }
        return lhs * (1 / rhs)
    }

    static func /= (lhs: inout CGAffineTransform, rhs: CGFloat) {
        lhs = lhs / rhs
    }
}
