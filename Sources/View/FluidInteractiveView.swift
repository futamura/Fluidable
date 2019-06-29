//
//  FluidInteractiveView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

public protocol FluidInteractiveView: class {
    func shrink(delayFactor: CGFloat, completion: ((UIViewAnimatingPosition) -> Void)?)
    func expand(delayFactor: CGFloat, completion: ((UIViewAnimatingPosition) -> Void)?)
    func restore(delayFactor: CGFloat, completion: ((UIViewAnimatingPosition) -> Void)?)
}

public extension FluidInteractiveView where Self: UIView {
    var shrinkScale: CGFloat { return 0.95 }
    var expandScale: CGFloat { return 1.05 }
    var restoreScale: CGFloat { return 1.0 }

    func shrink(delayFactor: CGFloat = 0, completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        self.layer.removeAllAnimations()
        self.setNeedsDisplay()
        let animator: UIViewPropertyAnimator = .init(duration: 0.60, easing: .easeOutExpo)
        animator.addAnimations({ [weak self] in
                                   self?.transform = .init(scaleX: self?.shrinkScale ?? 1.0, y: self?.shrinkScale ?? 1.0)
                                   self?.layer.displayIfNeeded()
                               }, delayFactor: delayFactor)
        animator.addCompletion({ (position: UIViewAnimatingPosition) in
            completion?(position)
        })
        animator.startAnimation()
    }

    func expand(delayFactor: CGFloat = 0, completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        self.layer.removeAllAnimations()
        self.setNeedsDisplay()
        let animator: UIViewPropertyAnimator = .init(duration: 0.0, easing: .spring(dampingRatio: 1.0, frequencyResponse: 0.3))
        animator.addAnimations({ [weak self] in
                                   self?.transform = .init(scaleX: self?.expandScale ?? 1.0, y: self?.expandScale ?? 1.0)
                                   self?.layer.displayIfNeeded()
                               }, delayFactor: delayFactor)
        animator.addCompletion({ (position: UIViewAnimatingPosition) in
            completion?(position)
        })
        animator.startAnimation()
    }

    func restore(delayFactor: CGFloat = 0, completion: ((UIViewAnimatingPosition) -> Void)? = nil) {
        self.layer.removeAllAnimations()
        self.setNeedsDisplay()
        let animator: UIViewPropertyAnimator = .init(duration: 0.0, easing: .spring(dampingRatio: 1.0, frequencyResponse: 0.3))
        animator.addAnimations({ [weak self] in
                                   self?.transform = .init(scaleX: self?.restoreScale ?? 1.0, y: self?.restoreScale ?? 1.0)
                                   self?.layer.displayIfNeeded()
                               }, delayFactor: delayFactor)
        animator.addCompletion({ (position: UIViewAnimatingPosition) in
            completion?(position)
        })
        animator.startAnimation()
    }

    func reset() {
        self.transform = .identity
    }
}
