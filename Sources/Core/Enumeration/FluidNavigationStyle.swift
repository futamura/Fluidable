//
//  FluidNavigationStyle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Enumerations to determine an animated navigation style.
 */

public enum FluidNavigationStyle {
    /**
     The slide transition
     - parameter direction: A `FluidSlideDirection` value indicating which direction to slide from.
     */
    case slide(direction: FluidSlideDirection)
    /** The fade transition */
    case fade
    /** The scale transition */
    case scale
}

/** The function that conforms to `Equatable`. */
extension FluidNavigationStyle: Equatable {
    public static func == (lhs: FluidNavigationStyle, rhs: FluidNavigationStyle) -> Bool {
        return lhs.description == rhs.description
    }
}

extension FluidNavigationStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .slide(let direction):  return "slide(\(direction))"
        case .fade: return "fade"
        case .scale: return "scale"
        }
    }
}
