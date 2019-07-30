//
//  FluidPresentationStyle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
 Enumerations to determine an animated navigation style.
 */

public enum FluidTransitionStyle {
    /** The fluid transition with modal view */
    case fluid(behavior: FluidInteractionBehavior)
    /** The scale transition with fullscreen view */
    case scale
    /**
     FullScreen view with slide transition
     - parameter direction: A `FluidSlideDirection` value indicating which direction to slide from.
     */
    case slide(direction: FluidSlideDirection)
    /**
     Drawer view with slide transition
     - parameter position: A `FluidDrawerPosition` value indicating where to display.
     */
    case drawer(position: FluidDrawerPosition)
}

/** The function that conforms to `Equatable`. */
extension FluidTransitionStyle: Equatable {
    public static func == (lhs: FluidTransitionStyle, rhs: FluidTransitionStyle) -> Bool {
        return lhs.description == rhs.description
    }
}

extension FluidTransitionStyle {
    public var isFluid: Bool {
        switch self {
        case .fluid:  return true
        case .scale:  return false
        case .slide:  return false
        case .drawer: return false
        }
    }
    public var isScale: Bool {
        switch self {
        case .fluid:  return false
        case .scale:  return true
        case .slide:  return false
        case .drawer: return false
        }
    }
    public var isSlide: Bool {
        switch self {
        case .fluid:  return false
        case .scale:  return false
        case .slide:  return true
        case .drawer: return false
        }
    }
    public var isDrawer: Bool {
        switch self {
        case .fluid:  return false
        case .scale:  return false
        case .slide:  return false
        case .drawer: return true
        }
    }
}

extension FluidTransitionStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fluid(let behavior): return "fluid(\(behavior))"
        case .scale: return "scale"
        case .slide(let direction):  return "slide(\(direction))"
        case .drawer(let position):  return "drawer(\(position))"
        }
    }
}

extension FluidTransitionStyle {
    public init?(index: Int) {
        switch index {
        case 0:  self = .fluid(behavior: .all)
        case 1:  self = .scale
        case 2:  self = .slide(direction: .fromRight)
        case 3:  self = .drawer(position: .bottom)
        default: return nil
        }
    }
}
