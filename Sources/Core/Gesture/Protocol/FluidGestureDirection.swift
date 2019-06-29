//
//  FluidGestureDirection.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Enumerations indicating a panning direction of `UIPanGestureRecognizer`.
 */
public enum FluidGestureDirection: Int {
    /** From 315 to 345 degree */
    case topLeft
    /** From 345 (-15) to 15 degree */
    case topCenter
    /** From 15 to 45 degree */
    case topRight
    /** From 45 to 75 degree */
    case rightTop
    /** From 75 to 105 degree */
    case rightMiddle
    /** From 105 to 135 degree */
    case rightBottom
    /** From 135 to 165 degree */
    case bottomRight
    /** From 165 to 195 degree */
    case bottomCenter
    /** From 195 to 225 degree */
    case bottomLeft
    /** From 225 to 255 degree */
    case leftBottom
    /** From 255 to 285 degree */
    case leftMiddle
    /** From 285 to 315 degree */
    case leftTop
    /** No direction */
    case none

    /**
     A function that detects a pan gesture direction.

     - parameter point: A `CGPoint` value.
     - returns: A `FluidPanDirection` object.
     */
    init(point: CGPoint?) {
        guard let point: CGPoint = point, point != .zero else {
            self = .none
            return
        }
        self.init(vector: CGVector(point: point))
    }

    /**
     A function that detects a pan gesture direction.

     - parameter vector: A `CGVector` value.
     - returns: A `FluidPanDirection` object.
     */
    init(vector: CGVector) {
        guard vector != .zero else {
            self = .none
            return
        }
        let radianToRotate: CGFloat = .pi * 1.5 + .pi / 48.0 /* Rotate the vector so that the top becomes the base point */
        let degree: CGFloat = vector.rotate(radianToRotate).angle.radiansToDegrees + 180 /* Convert to a positive number */
        let degreeRounded: Int = Int(degree / 30)
        switch degreeRounded {
        case 11: self = .topLeft      /* 315 to 345 */
        case 0:  self = .topCenter    /* 345 (-15) to 15 */
        case 1:  self = .topRight     /* 15 to 45 */
        case 2:  self = .rightTop     /* 45 to 75 */
        case 3:  self = .rightMiddle  /* 75 to 105 */
        case 4:  self = .rightBottom  /* 105 to 135 */
        case 5:  self = .bottomRight  /* 135 to 165 */
        case 6:  self = .bottomCenter /* 165 to 195 */
        case 7:  self = .bottomLeft   /* 195 to 225 */
        case 8:  self = .leftBottom   /* 225 to 255 */
        case 9:  self = .leftMiddle   /* 255 to 285 */
        case 10: self = .leftTop      /* 285 to 315 */
        default: self = .none
        }
    }
}

extension FluidGestureDirection {
    var isTopLeft: Bool { return self == .topLeft }
    var isTopCenter: Bool { return self == .topCenter }
    var isTopRight: Bool { return self == .topRight }
    var isRightTop: Bool { return self == .rightTop }
    var isRightMiddle: Bool { return self == .rightMiddle }
    var isRightBottom: Bool { return self == .rightBottom }
    var isBottomRight: Bool { return self == .bottomRight }
    var isBottomCenter: Bool { return self == .bottomCenter }
    var isBottomLeft: Bool { return self == .bottomLeft }
    var isLeftBottom: Bool { return self == .leftBottom }
    var isLeftMiddle: Bool { return self == .leftMiddle }
    var isLeftTop: Bool { return self == .leftTop }
    var isNone: Bool { return self == .none }

    var isApproxTop: Bool { return self.isLeftTop || self.isTopLeft || self.isTopCenter || self.isTopRight || self.isRightTop }
    var isApproxBottom: Bool { return self.isLeftBottom || self.isBottomLeft || self.isBottomCenter || self.isBottomRight || self.isRightBottom }
    var isApproxLeft: Bool { return self.isTopLeft || self.isLeftTop || self.isLeftMiddle || self.isLeftBottom || self.isBottomLeft }
    var isApproxRight: Bool { return self.isTopRight || self.isRightTop || self.isRightMiddle || self.isRightBottom || self.isBottomRight }

    var isNarrowTop: Bool { return self.isTopLeft || self.isTopCenter || self.isTopRight }
    var isNarrowBottom: Bool { return self.isBottomLeft || self.isBottomCenter || self.isBottomRight }
    var isNarrowLeft: Bool { return self.isLeftTop || self.isLeftMiddle || self.isLeftBottom }
    var isNarrowRight: Bool { return self.isRightTop || self.isRightMiddle || self.isRightBottom }

    var isApproxVertical: Bool { return self.isApproxTop || self.isApproxBottom }
    var isApproxHorizontal: Bool { return self.isApproxLeft || self.isApproxRight }

    var isNarrowVertical: Bool { return self.isNarrowTop || self.isNarrowBottom }
    var isNarrowHorizontal: Bool { return self.isNarrowLeft || self.isNarrowRight }

    var isStrictVertical: Bool { return self.isTopCenter || self.isBottomCenter }
    var isStrictHorizontal: Bool { return self.isLeftMiddle || self.isRightMiddle }
}

extension FluidGestureDirection: CustomStringConvertible {
    public var description: String {
        switch self {
        case .topLeft:      return "topLeft"
        case .topCenter:    return "topCenter"
        case .topRight:     return "topRight"
        case .rightTop:     return "rightTop"
        case .rightMiddle:  return "rightMiddle"
        case .rightBottom:  return "rightBottom"
        case .bottomLeft:   return "bottomLeft"
        case .bottomCenter: return "bottomCenter"
        case .bottomRight:  return "bottomRight"
        case .leftTop:      return "leftTop"
        case .leftMiddle:   return "leftMiddle"
        case .leftBottom:   return "leftBottom"
        case .none:         return "none"
        }
    }
}
