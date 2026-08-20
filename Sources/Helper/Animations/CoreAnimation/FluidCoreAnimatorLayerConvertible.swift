//
//  FluidCoreAnimatorLayerConvertible.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

@MainActor public protocol FluidCoreAnimatorLayerConvertible {
    func toLayer() -> CALayer?
}

extension UIView: FluidCoreAnimatorLayerConvertible {
    public func toLayer() -> CALayer? { return self.layer }
}

extension CALayer: FluidCoreAnimatorLayerConvertible {
    public func toLayer() -> CALayer? { return self }
}
