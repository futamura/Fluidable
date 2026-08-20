//
//  FluidRoundCornerStyle.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 A struct determining which corners should be rounded.
 */
public struct FluidRoundCornerStyle: OptionSet, Sendable {
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
    public static let all: FluidRoundCornerStyle = [.top, .right, .bottom, .left]
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
        var corners: UIRectCorner = []
        if self.contains(.top) { corners.formUnion([.topLeft, .topRight]) }
        if self.contains(.right) { corners.formUnion([.topRight, .bottomRight]) }
        if self.contains(.bottom) { corners.formUnion([.bottomLeft, .bottomRight]) }
        if self.contains(.left) { corners.formUnion([.topLeft, .bottomLeft]) }
        guard !corners.isEmpty else { return nil }
        /* NOTE: `UIRectCorner.allCorners` has a raw value of `~0` and is not equal to the union of the four individual corners */
        return corners == [.topLeft, .topRight, .bottomLeft, .bottomRight] ? .allCorners : corners
    }

    /** The `CACornerMask` value, available on iOS 11 or later. */
    @available(iOS 11.0, *)
    public var maskedCorners: CACornerMask {
        var corners: CACornerMask = []
        if self.contains(.top) { corners.formUnion([.layerMinXMinYCorner, .layerMaxXMinYCorner]) }
        if self.contains(.right) { corners.formUnion([.layerMaxXMinYCorner, .layerMaxXMaxYCorner]) }
        if self.contains(.bottom) { corners.formUnion([.layerMinXMaxYCorner, .layerMaxXMaxYCorner]) }
        if self.contains(.left) { corners.formUnion([.layerMinXMinYCorner, .layerMinXMaxYCorner]) }
        return corners
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
