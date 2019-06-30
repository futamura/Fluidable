//
//  FluidCoreAnimatorTransitionType.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations for `CATransitionType`.
 */
public struct FluidCoreAnimatorTransitionType {
    typealias RawValue = CATransitionType
    /** The layer’s content fades as it becomes visible or hidden. */
    public static var fade: FluidCoreAnimatorTransitionType { return .init(rawValue: .fade) }
    /** The layer’s content slides into place over any existing content. The Common Transition Subtypes are used with this transition. */
    public static var moveIn: FluidCoreAnimatorTransitionType { return .init(rawValue: .moveIn) }
    /** The layer’s content pushes any existing content as it slides into place. The Common Transition Subtypes are used with this transition. */
    public static var push: FluidCoreAnimatorTransitionType { return .init(rawValue: .push) }
    /** The layer’s content is revealed gradually in the direction specified by the transition subtype. The Common Transition Subtypes are used with this transition.. */
    public static var reveal: FluidCoreAnimatorTransitionType { return .init(rawValue: .reveal) }
    let rawValue: RawValue
}

/**
 The enumerations for `CATransitionSubtype`.
 */
public struct FluidCoreAnimatorTransitionSubtype {
    typealias RawValue = CATransitionSubtype
    /** The transition begins at the right side of the layer. */
    public static var right: FluidCoreAnimatorTransitionSubtype { return .init(rawValue: .fromRight) }
    /** The transition begins at the left side of the layer. */
    public static var left: FluidCoreAnimatorTransitionSubtype { return .init(rawValue: .fromLeft) }
    /** The transition begins at the top of the layer. */
    public static var top: FluidCoreAnimatorTransitionSubtype { return .init(rawValue: .fromTop) }
    /** The transition begins at the bottom of the layer. */
    public static var bottom: FluidCoreAnimatorTransitionSubtype { return .init(rawValue: .fromBottom) }
    let rawValue: RawValue
}
