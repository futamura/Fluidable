//
//  FluidFrameDimension.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

public protocol FluidTransformConvertible {
    static var identity: Self { get }
    func toCATransform3D() -> CATransform3D
    func toCGAffineTransform() -> CGAffineTransform
}

extension CATransform3D: FluidTransformConvertible {
    public func toCATransform3D() -> CATransform3D { return self }
    public func toCGAffineTransform() -> CGAffineTransform { return self.affineTransform ?? .identity }
}

extension CGAffineTransform: FluidTransformConvertible {
    public func toCATransform3D() -> CATransform3D { return CATransform3D(with: self) }
    public func toCGAffineTransform() -> CGAffineTransform { return self }
}

/**
 The protocol that compatibles to `FluidInitialFrameDimension` amd `FluidFinalFrameDimension`.
 */
public protocol FluidFrameDimensionCompatible {
    func frame(for containerSize: CGSize?) -> CGRect
    func transform(for containerSize: CGSize?) -> CATransform3D
}
