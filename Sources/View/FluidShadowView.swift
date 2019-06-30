//
//  FluidShadowView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

public class FluidShadowView: UIView {
    override public class var layerClass: AnyClass { return FluidShadowLayer.self }
    override public var layer: FluidShadowLayer { return super.layer as! FluidShadowLayer }

    @objc dynamic var shadowCornerRadius: CGFloat {
        get { return self.layer.shadowCornerRadius }
        set { self.layer.shadowCornerRadius = newValue }
    }
    var shadowRoundingCorners: UIRectCorner? {
        get { return self.layer.shadowRoundingCorners }
        set { self.layer.shadowRoundingCorners = newValue }
    }
    @objc dynamic var shadowOpacity: CGFloat {
        get { return CGFloat(self.layer.shadowOpacity) }
        set { self.layer.shadowOpacity = Float(newValue) }
    }
    @objc dynamic var shadowColor: CGColor? {
        get { return self.layer.shadowColor }
        set { self.layer.shadowColor = newValue }
    }
    @objc dynamic var shadowRadius: CGFloat {
        get { return self.layer.shadowRadius }
        set { self.layer.shadowRadius = newValue }
    }
    @objc dynamic var shadowOffset: CGSize {
        get { return self.layer.shadowOffset }
        set { self.layer.shadowOffset = newValue }
    }
    @objc dynamic var isTransparentBackground: Bool {
        get { return self.layer.isTransparentBackground }
        set { self.layer.isTransparentBackground = newValue }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(shadowCornerRadius: CGFloat, shadowRoundingCorners: UIRectCorner?,
         shadowOpacity: CGFloat, shadowColor: CGColor, shadowRadius: CGFloat, shadowOffset: CGSize,
         isTransparentBackground: Bool) {
        super.init(frame: .zero)
        self.tag = FluidConst.shadowViewTag
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        self.shadowCornerRadius = shadowCornerRadius
        self.shadowRoundingCorners = shadowRoundingCorners
        self.shadowOpacity = shadowOpacity
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowOffset = shadowOffset
        self.backgroundColor = .clear
        self.isTransparentBackground = isTransparentBackground
        self.isUserInteractionEnabled = false
    }

    deinit { Logger()?.log("🤢🧹🧹🧹", []) }
}

extension FluidShadowView {
    func castShadow(frame: CGRect,
                    shadowCornerRadius: CGFloat? = nil, shadowRoundingCorners: UIRectCorner? = nil,
                    shadowColor: CGColor? = nil, shadowOpacity: CGFloat? = nil,
                    shadowRadius: CGFloat? = nil, shadowOffset: CGSize? = nil,
                    isTransparentBackground: Bool? = nil) {
        self.layer.castShadow(frame: frame,
                              shadowCornerRadius: shadowCornerRadius, shadowRoundingCorners: shadowRoundingCorners,
                              shadowColor: shadowColor, shadowOpacity: Float(shadowOpacity ?? CGFloat(self.layer.shadowOpacity)),
                              shadowRadius: shadowRadius, shadowOffset: shadowOffset,
                              isTransparentBackground: isTransparentBackground)
    }
}
