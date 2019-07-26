//
//  FluidNavigationViewAnimator+Interactive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Interactive transition for presentation
 */
extension FluidNavigationViewAnimator {
    func interactionDidStart(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        switch self.animationType {
        case .present:
            break
        case .dismiss, .rotate:
            // NOTE: Set variable
            self.storedFromFrame = self.finalDimension.frame()
            self.storedToFrame = self.initialDimension.frame()
            self.storedFromStyle = self.finalStyle
            self.storedToStyle = self.initialStyle
            switch self.interactionType {
            case .normal: self.baseConstants = .init(size: self.initialContainerSize, frame: self.storedFromFrame)
            case .fluid, .none: break
            }
            // NOTE: Start timer
            self.animationTimer?.stop()
            self.animationTimer = FluidViewAnimatorTimer()
            self.animationTimer?.start({ [weak self] in self?.animationTimerDidUpdate() })
        }
    }

    func interactionDidUpdate(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
    }

    func interactionDidFinish(isReversed: Bool, progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
    }
}

/**
 Handling interactive interaction
 */
extension FluidNavigationViewAnimator {
    func animationTimerDidUpdate() {
        guard self.animationTimer != nil else { return }
        self.dismissFrame()
    }

    func dismissFrame() {
        guard self.animationTimer != nil else { return }
        switch self.interactionType {
        case .normal:
            // NOTE: Frame
            let rangeFrame: CGRect = self.storedFromFrame - self.storedToFrame
            let targetFrame: CGRect = self.storedFromFrame - rangeFrame * self.interactionProgress
            // NOTE: Corner radius
            let rangeCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius
            let targetCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeCornerRadius * self.interactionProgress
            // NOTE: Apply frame
            self.layoutContainerView.frame = targetFrame
            self.layoutContainerView.updateLayoutImmediately()
            self.layoutContainerView.layer.cornerRadius = targetCornerRadius
            // NOTE: Background
            self.backgroundView?.visibility = 1 - self.interactionProgress
            // NOTE: Shadow
            guard self.shadowView != nil else { return }
            // NOTE: Shadow corner radius
            let rangeShadowCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius
            let targetShadowCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeShadowCornerRadius * self.interactionProgress
            // NOTE: Shadow color
            let rangeShadowColor: CGColor = self.storedFromStyle.shadowColor - self.storedToStyle.shadowColor
            let targetShadowColor: CGColor = self.storedFromStyle.shadowColor - rangeShadowColor * self.interactionProgress
            // NOTE: Shadow opacity
            let rangeShadowOpacity: CGFloat = self.storedFromStyle.shadowOpacity - self.storedToStyle.shadowOpacity
            let targetShadowOpacity: CGFloat = self.storedFromStyle.shadowOpacity - rangeShadowOpacity * self.interactionProgress
            // NOTE: Shadow radius
            let rangeShadowRadius: CGFloat = self.storedFromStyle.shadowRadius - self.storedToStyle.shadowRadius
            let targetShadowRadius: CGFloat = self.storedFromStyle.shadowRadius - rangeShadowRadius * self.interactionProgress
            // NOTE: Shadow offset
            let rangeShadowOffset: CGSize = self.storedFromStyle.shadowOffset - self.storedToStyle.shadowOffset
            let targetShadowOffset: CGSize = self.storedFromStyle.shadowOffset - rangeShadowOffset * self.interactionProgress
            // NOTE: Shadow path
            let targetShadowPath: CGPath? = FluidShadowLayer.createShadowPath(frame: targetFrame,
                                                                              cornerRadius: targetCornerRadius,
                                                                              roundingCorners: self.storedFromStyle.roundingCorners,
                                                                              shadowRadius: targetShadowRadius,
                                                                              shadowOffset: targetShadowOffset)
            // NOTE: Shadow mask
            let targetShadowMask: CGPath? = FluidShadowLayer.createShadowMask(bounds: targetFrame,
                                                                              cornerRadius: targetCornerRadius,
                                                                              roundingCorners: self.storedFromStyle.roundingCorners,
                                                                              shadowRadius: targetShadowRadius,
                                                                              shadowOffset: targetShadowOffset,
                                                                              isTransparentBackground: self.storedFromStyle.isTransparentBackground)?.path
            // NOTE: Apply shadow
            self.shadowView?.layer.frame = targetFrame
            self.shadowView?.layer.cornerRadius = targetShadowCornerRadius
            self.shadowView?.layer.shadowColor = targetShadowColor
            self.shadowView?.layer.shadowOpacity = Float(targetShadowOpacity)
            self.shadowView?.layer.shadowRadius = targetShadowRadius
            self.shadowView?.layer.shadowOffset = targetShadowOffset
            self.shadowView?.layer.shadowPath = targetShadowPath
            (self.shadowView?.layer.mask as? CAShapeLayer)?.path = targetShadowMask
        case .fluid:
            break
        case .none:
            break
        }
    }
}
