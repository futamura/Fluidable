//
//  FluidFrameStyle+Implementation.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/25.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The initial frame style that conforms to the `FluidFrameStyleCompatible` protocol.
 */
public struct FluidInitialFrameStyle: FluidFrameStyleCompatible {
    /** A `CGFloat` value that determines a frame alpha. */
    public internal(set) var alpha: CGFloat!
    /** A `CGFloat` value that determines a corner radius. */
    public internal(set) var cornerRadius: CGFloat
    /** A `FluidRoundCornerStyle` value that determines which corners should be rounded. */
    public internal(set) var cornerStyle: FluidRoundCornerStyle? = .none
    /** A `CGColor` value that determines a shadow color. */
    public internal(set) var shadowColor: CGColor
    /** A `Float` value that determines a shadow opacity. */
    public internal(set) var shadowOpacity: CGFloat
    /** A `CGFloat` value that determines a shadow radius. */
    public internal(set) var shadowRadius: CGFloat
    /** A `CGSize` value that determines a shadow offset. */
    public internal(set) var shadowOffset: CGSize
    /** A `Boolean` value that indicates whether a background of a view controller is transparent. If set true, a shadow mask will be subtracted its rect. */
    public internal(set) var isTransparentBackground: Bool = true

    public init(alpha: CGFloat? = nil,
                cornerRadius: CGFloat = 0.0,
                shadowColor: CGColor = UIColor.black.cgColor,
                shadowOpacity: CGFloat = 0.0,
                shadowRadius: CGFloat = 3.0,
                shadowOffset: CGSize = .zero) {
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
    }
}

extension FluidInitialFrameStyle {
    internal mutating func validate(for presentationStyle: FluidPresentationStyle, finalFrameStyle: FluidFinalFrameStyle) -> FluidInitialFrameStyle {
        self.alpha = self.alpha ?? {
            switch presentationStyle {
            case .fluid:  return 1
            case .scale:  return 0
            case .slide:  return 1
            case .drawer: return 1
            }
        }()
        self.cornerStyle = finalFrameStyle.cornerStyle
        self.isTransparentBackground = finalFrameStyle.isTransparentBackground
        return self
    }
}

/**
 The final frame style that conforms to the `FluidFrameStyleCompatible` protocol.
 */
public struct FluidFinalFrameStyle: FluidFrameStyleCompatible {
    /** A `CGFloat` value that determines a frame alpha. */
    public internal(set) var alpha: CGFloat!
    /** A `CGFloat` value that determines a corner radius. */
    public internal(set) var cornerRadius: CGFloat
    /** A `FluidRoundCornerStyle` value that determines which corners should be rounded. */
    public internal(set) var cornerStyle: FluidRoundCornerStyle?
    /** A `CGColor` value that determines a shadow color. */
    public internal(set) var shadowColor: CGColor
    /** A `Float` value that determines a shadow opacity. */
    public internal(set) var shadowOpacity: CGFloat
    /** A `CGFloat` value that determines a shadow radius. */
    public internal(set) var shadowRadius: CGFloat
    /** A `CGSize` value that determines a shadow offset. */
    public internal(set) var shadowOffset: CGSize
    /** A `Boolean` value that indicates whether a background of a view controller is transparent. If set true, a shadow mask will be subtracted its rect. */
    public internal(set) var isTransparentBackground: Bool = false

    public init(alpha: CGFloat? = nil,
                cornerRadius: CGFloat = 0.0,
                cornerStyle: FluidRoundCornerStyle? = .none,
                shadowColor: CGColor = UIColor.black.cgColor,
                shadowOpacity: CGFloat = 0.0,
                shadowRadius: CGFloat = 3.0,
                shadowOffset: CGSize = .zero) {
        self.alpha = alpha
        self.cornerRadius = cornerRadius
        self.cornerStyle = cornerStyle
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.isTransparentBackground = !FluidConst.isNewerSystemVersion
    }
}

extension FluidFinalFrameStyle {
    internal mutating func validate(for presentationStyle: FluidPresentationStyle) -> FluidFinalFrameStyle {
        self.alpha = self.alpha ?? 1
        self.cornerStyle = self.cornerStyle ?? {
            switch presentationStyle {
            case .fluid, .scale, .slide: return .all
            case .drawer(let position):
                switch position {
                case .top:    return .bottom
                case .right:  return .left
                case .bottom: return .top
                case .left:   return .right
                }
            }
        }()
        return self
    }
}
