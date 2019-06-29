//
//  FluidLayoutEdgeConstraint.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Layout constraints
 */
public struct FluidLayoutCenteredFullScreenConstraint {
    let midX: NSLayoutConstraint
    let midY: NSLayoutConstraint
    let width: NSLayoutConstraint
    let height: NSLayoutConstraint

    init(_ midX: NSLayoutConstraint, _ midY: NSLayoutConstraint, _ width: NSLayoutConstraint, _ height: NSLayoutConstraint) {
        self.midX = midX
        self.midY = midY
        self.width = width
        self.height = height
    }
}

public struct FluidLayoutEdgeConstraint {
    let top: NSLayoutConstraint
    let bottom: NSLayoutConstraint
    let left: NSLayoutConstraint
    let right: NSLayoutConstraint

    init(_ top: NSLayoutConstraint, _ bottom: NSLayoutConstraint, _ left: NSLayoutConstraint, _ right: NSLayoutConstraint) {
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }
}

/**
 Layout constants
 */
public struct FluidLayoutEdgeConstant {
    var top: CGFloat
    var bottom: CGFloat
    var left: CGFloat
    var right: CGFloat

    init(size: CGSize, frame: CGRect) {
        let maxX: CGFloat = size.width
        let maxY: CGFloat = size.height
        self.top = frame.minY
        self.bottom = frame.maxY - maxY
        self.left = frame.minX
        self.right = frame.maxX - maxX
    }

    init?(top: CGFloat?, bottom: CGFloat?, left: CGFloat?, right: CGFloat?) {
        guard let top: CGFloat = top, let bottom: CGFloat = bottom,
              let left: CGFloat = left, let right: CGFloat = right else { return nil }
        self.top = top
        self.bottom = bottom
        self.left = left
        self.right = right
    }

    mutating func apply(top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil) {
        if let value: CGFloat = top { self.top = value }
        if let value: CGFloat = bottom { self.bottom = value }
        if let value: CGFloat = left { self.left = value }
        if let value: CGFloat = right { self.right = value }
    }
}

extension FluidLayoutEdgeConstant: Equatable {
    /** The function that conforms to `Equatable`. */
    public static func == (lhs: FluidLayoutEdgeConstant, rhs: FluidLayoutEdgeConstant) -> Bool {
        return lhs.top == rhs.top && lhs.bottom == rhs.bottom && lhs.left == rhs.left && lhs.right == rhs.right
    }
}

extension FluidLayoutEdgeConstant: CustomStringConvertible {
    public var description: String {
        return "(t: \(self.top.decimal(4)), b: \(self.bottom.decimal(4)), l: \(self.left.decimal(4)), r: \(self.right.decimal(4)))"
    }
}
