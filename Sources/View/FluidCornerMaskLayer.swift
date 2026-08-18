//
//  FluidCornerMaskLayer.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

internal class FluidCornerMaskLayer: CAShapeLayer {
    override var bounds: CGRect {
        didSet {
            guard self.bounds != oldValue else { return }
            self.updateMaskPath(bounds: self.bounds)
        }
    }
    nonisolated(unsafe) var fluidRoundingCorners: UIRectCorner?
    nonisolated(unsafe) var fluidCornerRadius: CGFloat = 0

    init(bounds: CGRect, cornerRadius: CGFloat, roundingCorners: UIRectCorner?) {
        super.init()
        self.frame = bounds
        self.updateMaskPath(bounds: bounds,
                            cornerRadius: cornerRadius,
                            roundingCorners: roundingCorners)
    }

    override init(layer: Any) {
        super.init(layer: layer)
        guard let layer: FluidCornerMaskLayer = layer as? FluidCornerMaskLayer else { return }
        self.fluidCornerRadius = layer.fluidCornerRadius
        self.fluidRoundingCorners = layer.fluidRoundingCorners
        self.frame = layer.frame
        self.setValue(layer.value(forKeyPath: "path"), forKeyPath: "path")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit { Logger()?.log("📄🧹🧹🧹️", []) }
}

extension FluidCornerMaskLayer {
    nonisolated func updateMaskPath(bounds: CGRect, cornerRadius: CGFloat? = nil, roundingCorners: UIRectCorner? = nil) {
        self.fluidCornerRadius = cornerRadius ?? self.fluidCornerRadius
        self.fluidRoundingCorners = roundingCorners ?? self.fluidRoundingCorners
        let path = UIBezierPath(bounds: bounds,
                                cornerRadius: self.fluidCornerRadius,
                                roundingCorners: self.fluidRoundingCorners).cgPath
        self.setValue(path, forKeyPath: "path")
    }
}

extension FluidCornerMaskLayer {
    static func createMaskPath(bounds: CGRect, cornerRadius: CGFloat, roundingCorners: UIRectCorner? = nil) -> CGPath {
        return UIBezierPath(bounds: bounds,
                            cornerRadius: cornerRadius,
                            roundingCorners: roundingCorners).cgPath
    }
}
