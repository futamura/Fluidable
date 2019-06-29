//
//  FluidBackgroundView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

public protocol FluidBackgroundCompatible: NSObjectProtocol {
    var visibility: CGFloat { set get }
}

extension FluidBackgroundCompatible where Self: UIView {
    func fitToSuperview() {
        if let view: UIView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: view.topAnchor).activate()
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).activate()
            self.leftAnchor.constraint(equalTo: view.leftAnchor).activate()
            self.rightAnchor.constraint(equalTo: view.rightAnchor).activate()
        }
    }
}

internal class FluidBlurredBackgroundView: BlurView, FluidBackgroundCompatible {
    var baseBlurRadius: CGFloat = 0

    /** A percentage of visibility. */
    @objc internal dynamic var visibility: CGFloat = -1 {
        didSet {
            guard self.visibility != oldValue else { return }
            self.blurRadius = self.baseBlurRadius * self.visibility.clamped(0, 1)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(radius: CGFloat, color: UIColor, alpha: CGFloat) {
        super.init(effect: nil)
        self.baseBlurRadius = radius
        self.blurRadius = 0
        self.colorTint = color
        self.colorTintAlpha = alpha
        self.visibility = 0
        self.isUserInteractionEnabled = false
        self.tag = FluidConst.backgroundViewTag
    }

    deinit { Logger()?.log("🥶🧹🧹🧹️", []) }

    override func updateConstraints() {
        self.fitToSuperview()
        super.updateConstraints()
    }
}

internal class FluidDimmedBackgroundView: UIView, FluidBackgroundCompatible {
    @objc internal dynamic var visibility: CGFloat = -1 {
        didSet {
            guard self.visibility != oldValue else { return }
            self.alpha = self.visibility.clamped(0, 1)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.alpha = 0
        self.isUserInteractionEnabled = false
        self.tag = FluidConst.backgroundViewTag
        self.visibility = 0
    }

    deinit { Logger()?.log("🥶🧹🧹🧹️", []) }

    override func updateConstraints() {
        self.fitToSuperview()
        super.updateConstraints()
    }
}

/**
 https://github.com/efremidze/VisualEffectView/blob/master/Sources/VisualEffectView.swift
 */
internal class BlurView: UIVisualEffectView {
    /** Returns the instance of UIBlurEffect. */
    private let blurEffect: UIBlurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type).init()

    /** Tint color. The default value is nil. */
    @objc dynamic internal var colorTint: UIColor? {
        get { return _value(forKey: "colorTint") as? UIColor }
        set { _setValue(newValue, forKey: "colorTint") }
    }

    /** Tint color alpha. The default value is 0.0. */
    @objc dynamic open var colorTintAlpha: CGFloat {
        get { return _value(forKey: "colorTintAlpha") as! CGFloat }
        set { _setValue(newValue, forKey: "colorTintAlpha") }
    }

    /** Blur radius. The default value is 0.0. */
    @objc dynamic open var blurRadius: CGFloat {
        get { return _value(forKey: "blurRadius") as! CGFloat }
        set { _setValue(newValue, forKey: "blurRadius") }
    }

    /** Scale factor. The scale factor determines how content in the view is mapped from the logical coordinate space (measured in points) to the device coordinate space (measured in pixels). The default value is 1.0. */
    @objc dynamic open var scale: CGFloat {
        get { return _value(forKey: "scale") as! CGFloat }
        set { _setValue(newValue, forKey: "scale") }
    }

    /** Initialization */
    internal override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        configure()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        self.scale = 1
    }

    /** Returns the value for the key on the blurEffect. */
    private func _value(forKey key: String) -> Any? {
        return blurEffect.value(forKeyPath: key)
    }

    /** Sets the value for the key on the blurEffect. */
    private func _setValue(_ value: Any?, forKey key: String) {
        blurEffect.setValue(value, forKeyPath: key)
        self.effect = blurEffect
    }
}
