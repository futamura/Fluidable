//
//  FluidBackgroundStyle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Enumerations indicating a background style.
 */
public enum FluidBackgroundStyle {
    /**
     Blurred background.

     - parameter radius: The blur radius value.
     - parameter color: The tint color value.
     - parameter alpha: The tint alpha value.
     */
    case blur(radius: CGFloat, color: UIColor, alpha: CGFloat)
    /**
     Dimmed background.

     - parameter color: The dimming color value.
     */
    case dim(color: UIColor)
    /**
     No background.
     */
    case none
}

public extension FluidBackgroundStyle {
    var index: Int {
        switch self {
        case .blur: return 0
        case .dim:  return 1
        case .none: return 2
        }
    }
}

extension FluidBackgroundStyle: Equatable {
    public static func == (lhs: FluidBackgroundStyle, rhs: FluidBackgroundStyle) -> Bool {
        return lhs.index == rhs.index
    }
}

extension FluidBackgroundStyle: CustomStringConvertible {
    /* The description. */
    public var description: String {
        switch self {
        case .blur(let radius, let color, let alpha): return "blur(radius: \(radius), color: \(color), alpha: \(alpha))"
        case .dim(let color): return "dim(color: \(color))"
        case .none: return "none"
        }
    }
}
