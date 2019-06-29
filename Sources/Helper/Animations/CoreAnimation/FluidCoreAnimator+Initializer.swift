//
//  FluidCoreAnimator+Initializer.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Initializing a Property Animator
 */
extension FluidCoreAnimator {
    /**
      The function that instantiates `Animation`

      - parameter layer: The reference to `CALayer` to be animated.
      - parameter id: The identifier for `CAAnimationGroup`.
      - parameter duration: The total duration of the animations, measured in seconds.
      - parameter beginTime: The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
      - parameter timeOffset: Additional offset in active local time.
      - parameter easing: The easing equation that returns a timing function defining the pacing of the animation.
      - parameter isRemovedOnCompletion: When true, the animation is removed from the render tree once its active duration has passed.
      - parameter fillMode: Defines how the timed object behaves outside its active duration. Local time may be clamped to either end of the active duration, or the element may be removed from the presentation. The legal values are `backwards', `forwards', `both' and `removed'.
      - parameter repeatCount: The repeat count of the object. May be fractional.
      - parameter repeatDuration: The repeat duration of the object.
      - parameter autoreverses: When true, the object plays backwards after playing forwards.
     */
    public convenience init?<T: FluidCoreAnimatorLayerConvertible>(for layerConvertible: T?,
                                                                   id: String? = nil,
                                                                   duration: CFTimeInterval? = nil,
                                                                   beginTime: CFTimeInterval? = nil,
                                                                   timeOffset: CFTimeInterval? = nil,
                                                                   easing: FluidAnimatorEasing? = nil,
                                                                   isRemovedOnCompletion: Bool? = nil,
                                                                   fillMode: CAMediaTimingFillMode? = nil,
                                                                   repeatCount: Float? = nil,
                                                                   repeatDuration: CFTimeInterval? = nil,
                                                                   autoreverses: Bool? = nil) {
        self.init()
        let uuid: String = UUID().uuidString
        self.groupAnimationId = id ?? "\(Const.animationIdKey).\(uuid)"
        self.progressAnimationId = "\(self.groupAnimationId).progress"
        self.layer = layerConvertible?.toLayer()
        if let value: CFTimeInterval = duration { self.duration = value }
        if let value: CFTimeInterval = beginTime { self.beginTime = value }
        if let value: CFTimeInterval = timeOffset { self.timeOffset = value }
        if let value: FluidAnimatorEasing = easing { self.easing = value }
        if let value: Bool = isRemovedOnCompletion { self.isRemovedOnCompletion = value }
        if let value: CAMediaTimingFillMode = fillMode { self.fillMode = value }
        if let value: Float = repeatCount { self.repeatCount = value }
        if let value: CFTimeInterval = repeatDuration { self.repeatDuration = value }
        if let value: Bool = autoreverses { self.autoreverses = value }
    }
}
