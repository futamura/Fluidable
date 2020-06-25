//
//  FluidCoreAnimator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Helper
 */
internal extension FluidCoreAnimator {
    func createAnimation<T: FluidCoreAnimatorKeyCompatible>(layer: CALayer?, keyPath: FluidCoreAnimatorPath<T>, from: T?, to: T?,
                                                   duration: CFTimeInterval? = nil, beginTime: CFTimeInterval? = nil, timeOffset: CFTimeInterval? = nil,
                                                   easing: FluidAnimatorEasing? = nil,
                                                   isRemovedOnCompletion: Bool? = nil, fillMode: CAMediaTimingFillMode? = nil,
                                                   repeatCount: Float? = nil, repeatDuration: CFTimeInterval? = nil, autoreverses: Bool? = nil) -> CAAnimation? {
        guard let layer: CALayer = (((try? FluidCoreAnimatorValidator.validate(layer: layer, id: self.groupAnimationId)) as CALayer??)) ?? nil,
              let value: (from: T, to: T) = try? FluidCoreAnimatorValidator.validate(layer: layer, keyPath: keyPath, from: from, to: to, id: self.groupAnimationId) else {
            return nil
        }
        let easing: FluidAnimatorEasing = easing ?? FluidAnimatorEasing.linear
        switch easing {
        case .spring(let mass, let stiffness, let damping, let velocity):
            let animation: CASpringAnimation = CASpringAnimation(keyPath: keyPath.rawValue)
            /* NOTE: Easing */
            animation.mass = mass
            animation.stiffness = stiffness
            animation.damping = damping
            animation.initialVelocity = velocity.length()
            /* NOTE: Value */
            animation.fromValue = value.from
            animation.toValue = value.to
            /* NOTE: Time */
            if let value: CFTimeInterval = duration { animation.duration = value }
            if let value: CFTimeInterval = beginTime { animation.beginTime = value }
            if let value: CFTimeInterval = timeOffset { animation.timeOffset = value }
            /* NOTE: Render */
            if let value: Bool = isRemovedOnCompletion { animation.isRemovedOnCompletion = value }
            if let value: CAMediaTimingFillMode = fillMode { animation.fillMode = value }
            /* NOTE: Repeat */
            if let value: Float = repeatCount { animation.repeatCount = value }
            if let value: CFTimeInterval = repeatDuration { animation.repeatDuration = value }
            if let value: Bool = autoreverses { animation.autoreverses = value }
            return animation
        default:
            let animation: CABasicAnimation = CABasicAnimation(keyPath: keyPath.rawValue)
            /* NOTE: Easing */
            animation.timingFunction = easing.timingFunction
            /* NOTE: Value */
            animation.fromValue = value.from
            animation.toValue = value.to
            /* NOTE: Time */
            if let value: CFTimeInterval = duration { animation.duration = value }
            if let value: CFTimeInterval = beginTime { animation.beginTime = value }
            if let value: CFTimeInterval = timeOffset { animation.timeOffset = value }
            /* NOTE: Render */
            if let value: Bool = isRemovedOnCompletion { animation.isRemovedOnCompletion = value }
            if let value: CAMediaTimingFillMode = fillMode { animation.fillMode = value }
            /* NOTE: Repeat */
            if let value: Float = repeatCount { animation.repeatCount = value }
            if let value: CFTimeInterval = repeatDuration { animation.repeatDuration = value }
            if let value: Bool = autoreverses { animation.autoreverses = value }
            return animation
        }
    }

    func createTransition(startProgress: Float, endProgress: Float, type: FluidCoreAnimatorTransitionType, subtype: FluidCoreAnimatorTransitionSubtype?,
                          duration: CFTimeInterval? = nil, beginTime: CFTimeInterval? = nil, timeOffset: CFTimeInterval? = nil,
                          easing: FluidAnimatorEasing? = nil,
                          isRemovedOnCompletion: Bool? = nil, fillMode: CAMediaTimingFillMode? = nil,
                          repeatCount: Float? = nil, repeatDuration: CFTimeInterval? = nil, autoreverses: Bool? = nil) -> CATransition {
        let transition = CATransition()
        /* NOTE: Transition */
        transition.startProgress = startProgress
        transition.endProgress = endProgress
        transition.type = type.rawValue
        if let subtype: FluidCoreAnimatorTransitionSubtype = subtype { transition.subtype = subtype.rawValue }
        /* NOTE: Time */
        if let value: CFTimeInterval = duration { transition.duration = value }
        if let value: CFTimeInterval = beginTime { transition.beginTime = value }
        if let value: CFTimeInterval = timeOffset { transition.timeOffset = value }
        /* NOTE: Render */
        if let value: Bool = isRemovedOnCompletion { transition.isRemovedOnCompletion = value }
        if let value: CAMediaTimingFillMode = fillMode { transition.fillMode = value }
        /* NOTE: Repeat */
        if let value: Float = repeatCount { transition.repeatCount = value }
        if let value: CFTimeInterval = repeatDuration { transition.repeatDuration = value }
        if let value: Bool = autoreverses { transition.autoreverses = value }
        /* NOTE: Timing function */
        transition.timingFunction = (easing ?? FluidAnimatorEasing.linear).timingFunction
        return transition
    }

    func createProgressAnimation(duration: CFTimeInterval? = nil, beginTime: CFTimeInterval? = nil, timeOffset: CFTimeInterval? = nil,
                                 easing: FluidAnimatorEasing? = nil,
                                 isRemovedOnCompletion: Bool? = nil, fillMode: CAMediaTimingFillMode? = nil,
                                 repeatCount: Float? = nil, repeatDuration: CFTimeInterval? = nil, autoreverses: Bool? = nil) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "progress")
        /* NOTE: Value */
        animation.fromValue = CGFloat(0)
        animation.toValue = CGFloat(1)
        /* NOTE: Time */
        if let value: CFTimeInterval = duration { animation.duration = value }
        if let value: CFTimeInterval = beginTime { animation.beginTime = value }
        if let value: CFTimeInterval = timeOffset { animation.timeOffset = value }
        /* NOTE: Render */
        if let value: Bool = isRemovedOnCompletion { animation.isRemovedOnCompletion = value }
        if let value: CAMediaTimingFillMode = fillMode { animation.fillMode = value }
        /* NOTE: Repeat */
        if let value: Float = repeatCount { animation.repeatCount = value }
        if let value: CFTimeInterval = repeatDuration { animation.repeatDuration = value }
        if let value: Bool = autoreverses { animation.autoreverses = value }
        /* NOTE: Timing function */
        animation.timingFunction = (easing ?? FluidAnimatorEasing.linear).timingFunction
        return animation
    }
}
