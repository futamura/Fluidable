//
//  FluidGestureAxis.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Enumerations indicating a panning direction of `UIPanGestureRecognizer`.
 */
public struct FluidGestureAxis: OptionSet {
    public let rawValue: Int

    static let positiveX: FluidGestureAxis = .init(rawValue: 1 << 0) /* Right */
    static let negativeX: FluidGestureAxis = .init(rawValue: 1 << 1) /* Left */
    static let positiveY: FluidGestureAxis = .init(rawValue: 1 << 2) /* Down */
    static let negativeY: FluidGestureAxis = .init(rawValue: 1 << 3) /* Up */
    static let none: FluidGestureAxis = []                           /* None */

    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    public func invert() -> FluidGestureAxis {
        switch self {
        case [.positiveX, .positiveY]: return [.negativeX, .negativeY]
        case [.positiveX, .negativeY]: return [.negativeX, .positiveY]
        case [.negativeX, .positiveY]: return [.positiveX, .negativeY]
        case [.negativeX, .negativeY]: return [.positiveX, .positiveY]
        case .positiveX: return .negativeX
        case .negativeX: return .positiveX
        case .positiveY: return .negativeY
        case .negativeY: return .positiveY
        default: return .none
        }
    }
}

extension FluidGestureAxis: CustomStringConvertible {
    public var description: String {
        var options: [String] = [String]()
        if self.contains(.positiveX) { options.append("positiveX (right)") }
        if self.contains(.negativeX) { options.append("negativeX (left)") }
        if self.contains(.positiveY) { options.append("positiveY (down)") }
        if self.contains(.negativeY) { options.append("negativeY (up)") }
        return options.count > 0 ? options.joined(separator: ", ") : "none"
    }
}
