//
//  FluidFrameStyle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The protocol that compatibles to `FluidInitialFrameStyle` amd `FluidFinalFrameStyle`.
 */
public protocol FluidFrameStyleCompatible {
    var alpha: CGFloat! { get }
    /** A `CGFloat` value that determines a corner radius. */
    var cornerRadius: CGFloat { get }
    /** A `FluidRoundCornerStyle` value that determines which corners should be rounded. */
    var cornerStyle: FluidRoundCornerStyle? { get }
    /** A `UIRectCorner` value that determines which corners should be rounded. */
    var roundingCorners: UIRectCorner? { get }
    /** A `CACornerMask` value that determines which corners should be rounded. */
    @available(iOS 11.0, *)
    var maskedCorners: CACornerMask { get }
    /** A `CGColor` value that determines a shadow color. */
    var shadowColor: CGColor { get }
    /** A `Float` value that determines a shadow opacity. */
    var shadowOpacity: CGFloat { get }
    /** A `CGFloat` value that determines a shadow radius. */
    var shadowRadius: CGFloat { get }
    /** A `CGSize` value that determines a shadow offset. */
    var shadowOffset: CGSize { get }
    /** A `Boolean` value that indicates whether a background of a view controller is transparent. If set true, a shadow mask will be subtracted its rect. */
    var isTransparentBackground: Bool { get }
}

extension FluidFrameStyleCompatible {
    /** A `UIRectCorner` value that determines which corners should be rounded. */
    public var roundingCorners: UIRectCorner? { return self.cornerStyle?.roundingCorners }
    @available(iOS 11.0, *)
    /** A `CACornerMask` value that determines which corners should be rounded. */
    public var maskedCorners: CACornerMask { return self.cornerStyle?.maskedCorners ?? [] }
}
