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

extension FluidBackgroundStyle: CustomStringConvertible {
    /* The description. */
    public var description: String {
        switch self {
        case .blur(let radius, let color, let alpha): return "blur(radius: \(radius), color: \(color), alpha: \(alpha))"
        case .dim(let color): return "dim(color: \(color)"
        case .none: return "none"
        }
    }
}

public extension FluidBackgroundStyle {
    var index: Int {
        switch self {
        case .blur: return 0
        case .dim:  return 1
        case .none: return 2
        }
    }

    init?(index: Int) {
        switch index {
        case 0:  self = .blur(radius: 8.0, color: .clear, alpha: 1.0)
        case 1:  self = .dim(color: UIColor.black.withAlphaComponent(0.8))
        case 2:  self = .none
        default: return nil
        }
    }
}
