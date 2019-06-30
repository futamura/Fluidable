//
//  FluidRoundCornerStyle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 A struct determining which corners should be rounded.
 */
public struct FluidRoundCornerStyle: OptionSet {
    /** The raw value. */
    public let rawValue: Int

    /** Top left corner and top right corner. */
    public static let top: FluidRoundCornerStyle = .init(rawValue: 1 << 0)
    /** Top right corner and bottom right corner. */
    public static let right: FluidRoundCornerStyle = .init(rawValue: 1 << 1)
    /** Bottom left corner and bottom right corner. */
    public static let bottom: FluidRoundCornerStyle = .init(rawValue: 1 << 2)
    /** Top left corner and bottom left corner. */
    public static let left: FluidRoundCornerStyle = .init(rawValue: 1 << 3)
    /** All corners. */
    public static let all: FluidRoundCornerStyle = [.top, .right, .left, .left]
    /** No corners. */
    public static let none: FluidRoundCornerStyle = []

    /** The initializer that instantiates `FluidRoundCornerStyle` object.

     - parameter rawValue: The raw value.
     */
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }

    /** The `UIRectCorner` value. */
    public var roundingCorners: UIRectCorner? {
        switch self {
        case .all:    return .allCorners
        case .top:    return [.topLeft, .topRight]
        case .right:  return [.topRight, .bottomRight]
        case .bottom: return [.bottomLeft, .bottomRight]
        case .left:   return [.topLeft, .bottomLeft]
        default: return nil
        }
    }

    /** The `CACornerMask` value, available on iOS 11 or later. */
    @available(iOS 11.0, *)
    public var maskedCorners: CACornerMask {
        switch self {
        case .all:    return [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        case .top:    return [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        case .right:  return [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        case .bottom: return [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        case .left:   return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        default:      return []
        }
    }
}

extension FluidRoundCornerStyle: CustomStringConvertible {
    /** The description. */
    public var description: String {
        var options: [String] = [String]()
        if self.contains(.top) { options.append("top") }
        if self.contains(.right) { options.append("right") }
        if self.contains(.bottom) { options.append("bottom") }
        if self.contains(.left) { options.append("left") }
        guard options.count > 0 else { return "none" }
        return options.joined(separator: ", ")
    }
}
