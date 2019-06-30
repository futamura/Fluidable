//
//  CAProgressLayer.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import CoreGraphics

protocol CAProgressLayerDelegate: CALayerDelegate {
    func progressDidChange(to progress: CGFloat)
}

extension CAProgressLayerDelegate {
    func progressDidChange(to progress: CGFloat) {}
}

class CAProgressLayer: CALayer {
    /* FIXME: Custom properties is not animatable when using UIViewPropertyAnimator */
    @NSManaged var progress: CGFloat
    private var previousProgress: CGFloat?
    private var progressDelegate: CAProgressLayerDelegate? { return self.delegate as? CAProgressLayerDelegate }

    var preferredInvocationFramePerSeconds: CFTimeInterval = 60 {
        didSet {
            self.invocationInterval = 1 / self.preferredInvocationFramePerSeconds
        }
    }
    private var invocationInterval: CFTimeInterval = 1 / 60
    private var previousInvocationTime: CFTimeInterval = CACurrentMediaTime()

    override init() {
        super.init()
        self.frame = .zero
        self.progress = 0
    }

    init(frame: CGRect) {
        super.init()
        self.frame = frame
        self.progress = 0
    }

    override init(layer: Any) {
        super.init(layer: layer)
        guard let layer: CAProgressLayer = layer as? CAProgressLayer else { return }
        self.progress = layer.progress
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.progress = CGFloat(aDecoder.decodeFloat(forKey: #keyPath(progress)))
    }

    override func encode(with aCoder: NSCoder) {
        super.encode(with: aCoder)
        aCoder.encode(Float(self.progress), forKey: #keyPath(progress))
    }

    /* FIXME: Custom properties is not animatable when using UIViewPropertyAnimator */
//    override func action(forKey event: String) -> CAAction? {
//        switch event {
//        case #keyPath(progress):
//            if let animation: CABasicAnimation = super.action(forKey: "opacity") as? CABasicAnimation {
//                animation.keyPath = event
//                animation.fromValue = presentation()?.value(forKey: event)
//                animation.toValue = nil
//                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//                return animation
//            } else {
//                let animation = CABasicAnimation(keyPath: event)
//                animation.duration = 0.001
//                animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//                return animation
//            }
//        default:
//            break
//        }
//        return super.action(forKey: event)
//    }

    override class func needsDisplay(forKey key: String) -> Bool {
        if key == #keyPath(progress) { return true }
        return super.needsDisplay(forKey: key)
    }

    override func display() {
        super.display()
        guard let layer: CAProgressLayer = self.presentation() else { return }
        self.progress = layer.progress
        let invocationTime: CFTimeInterval = CACurrentMediaTime()
        let diffInvocationTime: CFTimeInterval = invocationTime - self.previousInvocationTime
        if diffInvocationTime >= self.invocationInterval && self.progress != self.previousProgress {
            self.progressDelegate?.progressDidChange(to: self.progress)
            self.previousProgress = self.progress
            self.previousInvocationTime = invocationTime
        }
    }
}

internal class UIProgressLayerView: UIView {
    override class var layerClass: AnyClass { return CAProgressLayer.self }
    override var layer: CAProgressLayer { return super.layer as! CAProgressLayer }

    /* FIXME: Custom properties is not animatable when using UIViewPropertyAnimator */
    @objc dynamic var progress: CGFloat {
        get { return self.layer.progress }
        set { self.layer.progress = newValue }
    }
}
