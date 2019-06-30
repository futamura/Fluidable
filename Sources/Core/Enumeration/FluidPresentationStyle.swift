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

public enum FluidPresentationStyle {
    /** The fade transition with modal view */
//    case fade
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
extension FluidPresentationStyle: Equatable {
    public static func == (lhs: FluidPresentationStyle, rhs: FluidPresentationStyle) -> Bool {
        return lhs.description == rhs.description
    }
}

extension FluidPresentationStyle {
    func toNavigationStyle() -> FluidNavigationStyle {
        switch self {
        case .fluid: return .scale
        case .scale: return .scale
        case .slide(let direction):  return .slide(direction: direction)
        case .drawer(let position):
            let direction: FluidSlideDirection = {
                switch position {
                case .top:    return .fromTop
                case .bottom: return .fromBottom
                case .left:   return .fromLeft
                case .right:  return .fromRight
                }
            }()
            return .slide(direction: direction)
        }
    }
    func toTransitionStyle() -> FluidTransitionStyle {
        switch self {
        case .fluid(let behavior): return .fluid(behavior: behavior)
        case .scale: return .scale
        case .slide(let direction): return .slide(direction: direction)
        case .drawer(let position): return .drawer(position: position)
        }
    }
}

extension FluidPresentationStyle {
    public var isFluid: Bool {
        switch self {
        case .fluid: return true
        case .scale, .slide, .drawer: return false
        }
    }
    public var isScale: Bool {
        switch self {
        case .scale: return true
        case .fluid, .slide, .drawer: return false
        }
    }
    public var isSlide: Bool {
        switch self {
        case .slide: return true
        case .fluid, .scale, .drawer: return false
        }
    }
    public var isVerticalSlide: Bool {
        switch self {
        case .slide(let position) where position.isFromTop || position.isFromBottom: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var isTopSlide: Bool {
        switch self {
        case .slide(let position) where position.isFromTop: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var isBottomSlide: Bool {
        switch self {
        case .slide(let position) where position.isFromBottom: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var isDrawer: Bool {
        switch self {
        case .drawer: return true
        case .fluid, .scale, .slide: return false
        }
    }
    public var isVerticalDrawer: Bool {
        switch self {
        case .drawer(let position) where position.isTop || position.isBottom: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var isTopDrawer: Bool {
        switch self {
        case .drawer(let position) where position.isTop: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var isBottomDrawer: Bool {
        switch self {
        case .drawer(let position) where position.isBottom: return true
        case .fluid, .scale, .slide, .drawer: return false
        }
    }
    public var interactionBehavior: FluidInteractionBehavior {
        switch self {
        case .fluid(let behavior): return behavior
        case .scale, .slide, .drawer: return .none
        }
    }
}

extension FluidPresentationStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fluid: return "fluid"
        case .scale: return "scale"
        case .slide(let direction):  return "slide(\(direction))"
        case .drawer(let position):  return "drawer(\(position))"
        }
    }
}

extension FluidPresentationStyle {
    public init?(index: Int) {
        switch index {
        case 0:  self = .fluid(behavior: .all)
        case 1:  self = .scale
        case 2:  self = .slide(direction: .fromRight)
        case 3:  self = .drawer(position: .bottom)
        default: return nil
        }
    }

    public init(fromNavigation navigationStyle: FluidNavigationStyle) {
        switch navigationStyle {
        case .scale: self = .scale
        case .fade: self = .scale
        case .slide(let direction): self = .slide(direction: direction)
        }
    }

    public init(fromTransition transitionStyle: FluidTransitionStyle) {
        switch transitionStyle {
        case .scale: self = .scale
        case .fluid(let behavior): self = .fluid(behavior: behavior)
        case .drawer(let position): self = .drawer(position: position)
        case .slide(let direction): self = .slide(direction: direction)
        }
    }
}

extension FluidPresentationStyle {
    var defaultPresentEasing: FluidAnimatorEasing {
        switch self {
        case .fluid:  if FluidConst.isNewerSystemVersion { return .spring } else { return .easeInOutQuad }
        case .scale:  if FluidConst.isNewerSystemVersion { return .spring } else { return .easeInOutQuad }
        case .slide:  return .easeOutCubic
        case .drawer: return .easeOutCubic
        }
    }
}

extension FluidPresentationStyle {
    var defaultDismissEasing: FluidAnimatorEasing {
        switch self {
        case .fluid:  if FluidConst.isNewerSystemVersion { return .spring } else { return .easeInOutQuad }
        case .scale:  if FluidConst.isNewerSystemVersion { return .spring } else { return .easeInOutQuad }
        case .slide:  return .easeInOutSine
        case .drawer: return .easeInOutSine
        }
    }
}

extension FluidPresentationStyle {
    var slideDirection: FluidSlideDirection? {
        switch self {
        case .slide(let direction): return direction
        default: return .none
        }
    }
}

extension FluidPresentationStyle {
    var drawerPosition: FluidDrawerPosition? {
        switch self {
        case .drawer(let position): return position
        default: return .none
        }
    }
}

extension FluidPresentationStyle {
    func dismissAxis() -> FluidGestureAxis {
        switch self {
        case .fluid, .scale: return .positiveY
        case .slide(let direction):
            switch direction {
            case .fromTop:    return .negativeY
            case .fromBottom: return .positiveY
            case .fromLeft:   return .negativeX
            case .fromRight:  return .positiveX
            }
        case .drawer(let position):
            switch position {
            case .top:    return .negativeY
            case .bottom: return .positiveY
            case .left:   return .negativeX
            case .right:  return .positiveX
            }
        }
    }

    func presentAxis() -> FluidGestureAxis {
        return self.dismissAxis().invert()
    }
}

/**
 A struct determining how behave while interactive dismissal transition. This option is available for only `FluidPresentationStyle.fluid`.
 */
public struct FluidInteractionBehavior: OptionSet {
    /** The raw value. */
    public let rawValue: Int

    /** Scale interaction. */
    public static let scale: FluidInteractionBehavior = .init(rawValue: 1 << 0)
    /** Vertical interaction. */
    public static let vertical: FluidInteractionBehavior = .init(rawValue: 1 << 1)
    /** Bidirectional interaction. */
    public static let bidirectional: FluidInteractionBehavior = .init(rawValue: 1 << 2)
    /** All interaction. */
    public static let all: FluidInteractionBehavior = [.scale, .bidirectional]
    /** No interaction. */
    public static let none: FluidInteractionBehavior = []

    /** The function that instantiates `FluidInteractionBehavior` object.

     - parameter rawValue: The raw value.
     */
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
}

extension FluidInteractionBehavior {
    public var isScale: Bool { return self.contains(.scale) }
    public var isVertical: Bool { return self.contains(.vertical) }
    public var isBidirectional: Bool { return self.contains(.bidirectional) }
}

extension FluidInteractionBehavior: CustomStringConvertible {
    /** The description. */
    public var description: String {
        var options: [String] = [String]()
        if self.contains(.scale) { options.append("scale") }
        if self.contains(.vertical) { options.append("vertical") }
        if self.contains(.bidirectional) { options.append("bidirectional") }
        guard options.count > 0 else { return "none" }
        return options.joined(separator: ", ")
    }
}

/**
 Enumerations to determine a direction of a slide transition.
 */
public enum FluidSlideDirection: Int {
    /** From top */
    case fromTop
    /** From bottom */
    case fromBottom
    /** From left */
    case fromLeft
    /** From right */
    case fromRight
}

public extension FluidSlideDirection {
    var isFromTop: Bool { return self == .fromTop }
    var isFromBottom: Bool { return self == .fromBottom }
    var isFromLeft: Bool { return self == .fromLeft }
    var isFromRight: Bool { return self == .fromRight }
    var isFromVertical: Bool { return self.isFromTop || self.isFromBottom }
    var isFromHorizontal: Bool { return self.isFromLeft || self.isFromRight }
}

extension FluidSlideDirection: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fromTop:    return "fromTop"
        case .fromBottom: return "fromBottom"
        case .fromLeft:   return "fromLeft"
        case .fromRight:  return "fromRight"
        }
    }
}

/**
 Enumerations indicating a drawer position.
 */
public enum FluidDrawerPosition {
    /** Top */
    case top
    /** Right */
    case right
    /** Bottom */
    case bottom
    /** Left */
    case left
}

public extension FluidDrawerPosition {
    var isTop: Bool { return self == .top }
    var isBottom: Bool { return self == .bottom }
    var isLeft: Bool { return self == .left }
    var isRight: Bool { return self == .right }
    var isVertical: Bool { return self.isTop || self.isBottom }
    var isHorizontal: Bool { return self.isLeft || self.isRight }
}

extension FluidDrawerPosition: CustomStringConvertible {
    public var description: String {
        switch self {
        case .top:    return "top"
        case .bottom: return "bottom"
        case .left:   return "left"
        case .right:  return "right"
        }
    }
}
