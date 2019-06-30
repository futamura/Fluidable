//
//  FluidViewAnimatorCompatible+Helper.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Utility
 */
extension FluidViewAnimatorCompatible {
    /**
     The function that converts the transition progress to the animator progress.

     - parameter transitionProgress: The transition progress, the value is between 0 to 1.
     - parameter transitionDuration: The transition duration, measured in seconds.
     - parameter animatorDuration: The animation duration, measured in seconds.
     - parameter animatorDelay: The animation delay, measured in seconds. Same as `CABasicAnimation.beginTime`.
     - returns: The converted progress value.
     */
    func convertProgress(transitionProgress: CGFloat, transitionDuration: TimeInterval,
                         animatorDuration: TimeInterval?, animatorDelay: TimeInterval?) -> CGFloat {
        /* NOTE: Convert values to CGFloat */
        let transitionDuration: CGFloat = CGFloat(transitionDuration)
        let animatorDuration: CGFloat = CGFloat(animatorDuration ?? self.activeDuration)
        let animatorDelay: CGFloat = CGFloat(animatorDelay ?? 0)
        let percentDelay: CGFloat = animatorDelay / transitionDuration
        /* NOTE: Convert the transition progress to the current animator progress */
        let transitionProgressWithOffset: CGFloat = (transitionProgress - percentDelay) / (1.0 - percentDelay) /* NOTE: Transition duration subtracted from delay */
        guard transitionProgressWithOffset >= 0 else { return 0 } /* NOTE: Wait until the delay time has passed */
        let transitionDurationLeftInAnimator: CGFloat = transitionDuration - animatorDelay /* NOTE: Maximum transition duration remaining in the current animator */
        let reduceFactor: CGFloat = animatorDuration / transitionDurationLeftInAnimator /* NOTE: The percentage of the transition duration to maximum transition duration remaining in the current animator */
        return (transitionProgressWithOffset / reduceFactor).clamped(0, 1)
    }
}

internal extension FluidViewAnimatorCompatible {
    func applyShadowProperties(frame: CGRect, cornerRadius: CGFloat, cornerStyle: FluidRoundCornerStyle?, shadowColor: CGColor?, shadowOpacity: CGFloat,
                               shadowRadius: CGFloat, shadowOffset: CGSize, isTransparentBackground: Bool) {
        guard self.shadowView != nil else { return }
//        self.shadowView?.frame = frame
        self.shadowView?.layer.frame = frame
        self.shadowView?.layer.cornerRadius = cornerRadius
        self.shadowView?.layer.shadowColor = shadowColor
        self.shadowView?.layer.shadowOpacity = Float(shadowOpacity)
        self.shadowView?.layer.shadowRadius = shadowRadius
        self.shadowView?.layer.shadowOffset = shadowOffset
        if let shadowPath: CGPath = FluidShadowLayer.createShadowPath(frame: frame,
                                                                      cornerRadius: cornerRadius,
                                                                      roundingCorners: cornerStyle?.roundingCorners,
                                                                      shadowRadius: shadowRadius,
                                                                      shadowOffset: shadowOffset) {
            self.shadowView?.layer.shadowPath = shadowPath
        }
        if let maskPath: CGPath = FluidShadowLayer.createShadowMask(bounds: frame.bounds,
                                                                    cornerRadius: cornerRadius,
                                                                    roundingCorners: cornerStyle?.roundingCorners,
                                                                    shadowRadius: shadowRadius,
                                                                    shadowOffset: shadowOffset,
                                                                    isTransparentBackground: isTransparentBackground)?.path {
            (self.shadowView?.layer.mask as? CAShapeLayer)?.path = maskPath
        }
    }
}

private extension FluidViewAnimatorCompatible {
    func spring(target: CGFloat, current: inout CGFloat, velocity: inout CGFloat, spring: CGFloat = 0.05, friction: CGFloat = 0.95) {
        let diff: CGFloat = target - current
        let acceleration: CGFloat = diff * spring
        velocity += acceleration
        velocity *= friction
        current += velocity
    }
}

internal extension FluidViewAnimatorCompatible {
    func debugAnimators() {
        var msg: String = "\n"
//        msg += "animationView.frame:".lpad() + String(debug: self.animationView.frame) + "\n"
//        msg += "destinationView.frame:".lpad() + String(debug: self.destinationView.frame) + "\n"
        msg += "animationView.frame:".lpad() + String(debug: self.animationView.layer.presentation()?.frame) + "\n"
        msg += "destinationView.frame:".lpad() + String(debug: self.destinationView.layer.presentation()?.frame) + "\n"
        msg += "\n"
        msg += "identifier:".lpad() + String(debug: self.interruptibleAnimator?.identifier) + "\n"
        msg += "duration:".lpad() + String(debug: self.interruptibleAnimator?.duration) + "\n"
        msg += "delay:".lpad() + String(debug: self.interruptibleAnimator?.delay) + "\n"
        msg += "stateEx:".lpad() + String(debug: self.interruptibleAnimator?.stateEx) + "\n"
        msg += "fractionComplete:".lpad() + String(debug: self.interruptibleAnimator?.fractionComplete.decimal()) + "\n"
        msg += "\n"
        self.framePropertyAnimators?.forEach {
            msg += "identifier:".lpad() + String(debug: $0.identifier) + "\n"
            msg += "duration:".lpad() + String(debug: $0.duration) + "\n"
            msg += "delay:".lpad() + String(debug: $0.delay) + "\n"
            msg += "stateEx:".lpad() + String(debug: $0.stateEx) + "\n"
            msg += "fractionComplete:".lpad() + String(debug: $0.fractionComplete.decimal()) + "\n"
            msg += "animatorProgress:".lpad() + String(debug: $0.animatorProgress.decimal()) + "\n"
            msg += "\n"
        }
        self.frameCoreAnimators?.forEach {
            msg += "identifier:".lpad() + String(debug: $0.identifier) + "\n"
            msg += "easing:".lpad() + String(debug: $0.easing) + "\n"
            msg += "duration:".lpad() + String(debug: $0.duration) + "\n"
            msg += "animatorState:".lpad() + String(debug: $0.animatorState) + "\n"
            msg += "animatorProgress:".lpad() + String(debug: $0.animatorProgress.decimal()) + "\n"
            msg += "\n"
        }
        self.extraPropertyAnimators?.forEach {
            msg += "identifier:".lpad() + String(debug: $0.identifier) + "\n"
            msg += "duration:".lpad() + String(debug: $0.duration) + "\n"
            msg += "delay:".lpad() + String(debug: $0.delay) + "\n"
            msg += "stateEx:".lpad() + String(debug: $0.stateEx) + "\n"
            msg += "fractionComplete:".lpad() + String(debug: $0.fractionComplete.decimal()) + "\n"
            msg += "animatorProgress:".lpad() + String(debug: $0.animatorProgress.decimal()) + "\n"
            msg += "\n"
        }
        self.extraCoreAnimators?.forEach {
            msg += "identifier:".lpad() + String(debug: $0.identifier) + "\n"
            msg += "easing:".lpad() + String(debug: $0.easing) + "\n"
            msg += "duration:".lpad() + String(debug: $0.duration) + "\n"
            msg += "animatorState:".lpad() + String(debug: $0.animatorState) + "\n"
            msg += "animatorProgress:".lpad() + String(debug: $0.animatorProgress.decimal()) + "\n"
            msg += "\n"
        }
        if let animator: FluidPropertyAnimator = self.backgroundAnimator {
            msg += "identifier:".lpad() + String(debug: animator.identifier) + "\n"
            msg += "duration:".lpad() + String(debug: animator.duration) + "\n"
            msg += "delay:".lpad() + String(debug: animator.delay) + "\n"
            msg += "stateEx:".lpad() + String(debug: animator.stateEx) + "\n"
            msg += "fractionComplete:".lpad() + String(debug: animator.fractionComplete.decimal()) + "\n"
            msg += "animatorProgress:".lpad() + String(debug: animator.animatorProgress.decimal()) + "\n"
            msg += "\n"
        }
        Logger()?.log("🕊🐛", [
            msg
        ])
    }
}
