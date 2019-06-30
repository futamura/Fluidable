//
//  FluidShadowLayer.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

public class FluidShadowLayer: CAShapeLayer {
    @NSManaged var shadowCornerRadius: CGFloat
    var shadowRoundingCorners: UIRectCorner? = .none
    @NSManaged var isTransparentBackground: Bool

    override convenience init() {
        self.init(frame: .zero)
    }

    init(frame: CGRect) {
        super.init()
        self.frame = frame
        self.shadowCornerRadius = 0
        self.shadowRoundingCorners = .none
        self.isTransparentBackground = false
        self.masksToBounds = true
        self.rasterizationScale = UIScreen.main.scale
        self.shouldRasterize = true
    }

    override init(layer: Any) {
        super.init(layer: layer)
        guard let layer: FluidShadowLayer = layer as? FluidShadowLayer else { return }
        self.shadowCornerRadius = layer.shadowCornerRadius
        self.shadowRoundingCorners = layer.shadowRoundingCorners
        self.isTransparentBackground = layer.isTransparentBackground
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.shadowCornerRadius = CGFloat(aDecoder.decodeFloat(forKey: #keyPath(shadowCornerRadius)))
//        self.shadowRoundingCorners = CGFloat(aDecoder.decodeFloat(forKey: #keyPath(shadowRoundingCorners)))
        self.isTransparentBackground = Bool(aDecoder.decodeBool(forKey: #keyPath(isTransparentBackground)))
    }

    override public func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(Float(self.shadowCornerRadius), forKey: #keyPath(shadowCornerRadius))
//        aCoder.encode(Float(self.shadowRoundingCorners), forKey: #keyPath(shadowRoundingCorners))
        aCoder.encode(Bool(self.isTransparentBackground), forKey: #keyPath(isTransparentBackground))
    }

    override public class func needsDisplay(forKey key: String) -> Bool {
        switch key {
        case #keyPath(shadowCornerRadius),
             #keyPath(isTransparentBackground):
            return true
        default:  return super.needsDisplay(forKey: key)
        }
    }

    deinit { Logger()?.log("👻🧹🧹🧹️", []) }
}

extension FluidShadowLayer {
    func castShadow(frame: CGRect,
                    shadowCornerRadius: CGFloat? = nil, shadowRoundingCorners: UIRectCorner? = nil,
                    shadowColor: CGColor? = nil, shadowOpacity: Float? = nil,
                    shadowRadius: CGFloat? = nil, shadowOffset: CGSize? = nil,
                    isTransparentBackground: Bool? = nil) {
        self.shadowCornerRadius = shadowCornerRadius ?? self.shadowCornerRadius
        self.shadowRoundingCorners = shadowRoundingCorners ?? self.shadowRoundingCorners
        self.shadowOpacity = shadowOpacity ?? self.shadowOpacity
        self.shadowColor = shadowColor ?? self.shadowColor
        self.shadowRadius = shadowRadius ?? self.shadowRadius
        self.shadowOffset = shadowOffset ?? self.shadowOffset
        self.isTransparentBackground = isTransparentBackground ?? self.isTransparentBackground
        if self.frame != frame {
            self.frame = FluidShadowLayer.createShadowFrame(frame: frame,
                                                            shadowRadius: self.shadowRadius, shadowOffset: self.shadowOffset)
            self.shadowPath = FluidShadowLayer.createShadowPath(frame: frame,
                                                                cornerRadius: self.shadowCornerRadius, roundingCorners: self.shadowRoundingCorners,
                                                                shadowRadius: self.shadowRadius, shadowOffset: self.shadowOffset)
        }
        if self.frame.bounds != frame.bounds {
            self.mask = FluidShadowLayer.createShadowMask(bounds: frame.bounds,
                                                          cornerRadius: self.shadowCornerRadius, roundingCorners: self.shadowRoundingCorners,
                                                          shadowRadius: self.shadowRadius, shadowOffset: self.shadowOffset,
                                                          isTransparentBackground: self.isTransparentBackground)
        }
    }
}

extension FluidShadowLayer {
    static func createShadowFrame(frame: CGRect, shadowRadius: CGFloat, shadowOffset: CGSize) -> CGRect {
        let diameter: CGFloat = shadowRadius * 2
        let offset: CGSize = shadowOffset
        var rect: CGRect = frame
        rect.origin.x -= diameter - offset.width
        rect.origin.y -= diameter - offset.height
        rect.size.width += diameter * 2
        rect.size.height += diameter * 2
        return rect
    }

    static func createShadowPath(frame: CGRect,
                                 cornerRadius: CGFloat, roundingCorners: UIRectCorner?,
                                 shadowRadius: CGFloat, shadowOffset: CGSize) -> CGPath? {
        if #available(iOS 11.0, *) {
            let offset: CGSize = .zero
            var rect: CGRect = frame
            rect.origin.x = offset.width
            rect.origin.y = offset.height
            return UIBezierPath(bounds: rect, cornerRadius: cornerRadius, roundingCorners: roundingCorners).cgPath
        } else {
            let diameter: CGFloat = 0
            let offset: CGSize = .zero
            var rect: CGRect = frame
            rect.origin.x = diameter - offset.width
            rect.origin.y = diameter - offset.height
            return UIBezierPath(bounds: rect, cornerRadius: cornerRadius, roundingCorners: roundingCorners).cgPath
        }
    }

    static func createShadowMask(bounds: CGRect,
                                 cornerRadius: CGFloat, roundingCorners: UIRectCorner?,
                                 shadowRadius: CGFloat, shadowOffset: CGSize,
                                 isTransparentBackground: Bool) -> CAShapeLayer? {
        if isTransparentBackground {
            let diameter: CGFloat = shadowRadius * 2
            let offset: CGSize = shadowOffset

            var maskRect: CGRect = bounds
            maskRect.size.width += diameter * 2
            maskRect.size.height += diameter * 2
            let maskPath = UIBezierPath(rect: maskRect)

            var subtractRect: CGRect = bounds
            subtractRect.origin.x += diameter - offset.width
            subtractRect.origin.y += diameter - offset.height
            var subtractPath: UIBezierPath = UIBezierPath(bounds: subtractRect, cornerRadius: cornerRadius, roundingCorners: roundingCorners)
            subtractPath.close()
            subtractPath = subtractPath.reversing()

            maskPath.append(subtractPath)
            maskPath.append(maskPath)

            let maskLayer = CAShapeLayer()
            maskLayer.frame = maskRect
            maskLayer.path = maskPath.cgPath
            return maskLayer
        } else {
            return nil
        }
    }
}
