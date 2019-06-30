//
//  FluidGestureInfo.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 A struct showing information about an interactive transition gesture
 */
public struct FluidGestureInfo {
//    /** A `CGRect` value that indicates a frame size when interaction starts. */
//    var initialFrame: CGRect
    /** A `CGPoint` value that indicates a current location on `FluidDestinationViewController`. */
    var locationLocal: CGPoint
    /** A `CGPoint` value that indicates a current location on `UIWindow`. */
    var locationGlobal: CGPoint
    /** A `CGPoint` value that indicates a translation being received from `UIPanGestureRecognizer`. */
    var translation: CGPoint
    /** A `CGVector` value that indicates a velocity being received from `UIPanGestureRecognizer`. */
    var velocity: CGVector
    /** A `FluidPanDirection` value that indicates a current gesture direction. */
    var direction: FluidGestureDirection

    init(locationLocal: CGPoint? = nil, locationGlobal: CGPoint? = nil, translation: CGPoint? = nil, velocity: CGVector? = nil, direction: FluidGestureDirection? = nil) {
        self.locationLocal = locationLocal ?? .zero
        self.locationGlobal = locationGlobal ?? .zero
        self.translation = translation ?? .zero
        self.velocity = velocity ?? .zero
        self.direction = direction ?? .none
    }
}
