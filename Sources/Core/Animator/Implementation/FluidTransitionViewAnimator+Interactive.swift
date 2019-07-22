//
//  FluidTransitionViewAnimator+Interactive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Interactive transition for presentation
 */
extension FluidTransitionViewAnimator {
    func interactionDidStart(progress: CGFloat, position: CGFloat, info: FluidGestureInfo) {
        switch self.animationType {
        case .present:
            break
        case .dismiss, .rotate:
            /* NOTE: Set variable */
            self.storedFromFrame = self.finalDimension.frame()
            self.storedToFrame = self.initialDimension.frame()
            self.storedFromStyle = self.finalStyle
            self.storedToStyle = self.initialStyle
            switch self.interactionType {
            case .normal: self.baseConstants = .init(size: self.initialContainerSize, frame: self.storedFromFrame)
            case .fluid, .none: break
            }
            /* NOTE: Start timer */
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
extension FluidTransitionViewAnimator {
    func animationTimerDidUpdate() {
        guard self.animationTimer != nil else { return }
        switch self.interactionType {
        case .normal where 0 < self.resizePosition: self.resizeFrame()
        case .normal: self.dismissFrame()
        case .fluid: self.dismissFrame()
        case .none: break
        }
    }

    func dismissFrame() {
        guard self.animationTimer != nil else { return }
        /* NOTE: Update background */
        self.backgroundView?.visibility = 1 - self.interactionProgress
        switch self.interactionType {
        case .normal:
            let containerSize: CGSize = self.transitionContainerView.frame.size
            /* NOTE: Frame */
            let rangeFrame: CGRect = self.storedFromFrame - self.storedToFrame
            let targetFrame: CGRect = self.storedFromFrame - rangeFrame * self.interactionProgress
            /* NOTE: Corner radius */
            let rangeCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius
            let targetCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeCornerRadius * self.interactionProgress
            /* NOTE: Apply frame */
            self.layout.apply(edges: .init(size: containerSize, frame: targetFrame))
            self.layoutContainerView.updateLayoutImmediately()
            /* NOTE: Mask */
            if #available(iOS 11.0, *) {
                self.layoutContainerView.layer.cornerRadius = targetCornerRadius
            } else {
                self.layoutContainerView.layer.mask = FluidCornerMaskLayer(bounds: targetFrame.bounds,
                                                                           cornerRadius: targetCornerRadius,
                                                                           roundingCorners: self.storedFromStyle.roundingCorners)
            }
            /* NOTE: Shadow */
            if self.shadowView != nil {
                /* NOTE: Shadow corner radius */
                let rangeShadowCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius
                let targetShadowCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeShadowCornerRadius * self.interactionProgress
                /* NOTE: Shadow color */
                let rangeShadowColor: CGColor = self.storedFromStyle.shadowColor - self.storedToStyle.shadowColor
                let targetShadowColor: CGColor = self.storedFromStyle.shadowColor - rangeShadowColor * self.interactionProgress
                /* NOTE: Shadow opacity */
                let rangeShadowOpacity: CGFloat = self.storedFromStyle.shadowOpacity - self.storedToStyle.shadowOpacity
                let targetShadowOpacity: CGFloat = self.storedFromStyle.shadowOpacity - rangeShadowOpacity * self.interactionProgress
                /* NOTE: Shadow radius */
                let rangeShadowRadius: CGFloat = self.storedFromStyle.shadowRadius - self.storedToStyle.shadowRadius
                let targetShadowRadius: CGFloat = self.storedFromStyle.shadowRadius - rangeShadowRadius * self.interactionProgress
                /* NOTE: Shadow offset */
                let rangeShadowOffset: CGSize = self.storedFromStyle.shadowOffset - self.storedToStyle.shadowOffset
                let targetShadowOffset: CGSize = self.storedFromStyle.shadowOffset - rangeShadowOffset * self.interactionProgress
                /* NOTE: Shadow path */
                let targetShadowPath: CGPath? = FluidShadowLayer.createShadowPath(frame: targetFrame,
                                                                                  cornerRadius: targetCornerRadius,
                                                                                  roundingCorners: self.storedFromStyle.roundingCorners,
                                                                                  shadowRadius: targetShadowRadius,
                                                                                  shadowOffset: targetShadowOffset)
                /* NOTE: Shadow mask */
                let targetShadowMask: CGPath? = FluidShadowLayer.createShadowMask(bounds: targetFrame,
                                                                                  cornerRadius: targetCornerRadius,
                                                                                  roundingCorners: self.storedFromStyle.roundingCorners,
                                                                                  shadowRadius: targetShadowRadius,
                                                                                  shadowOffset: targetShadowOffset,
                                                                                  isTransparentBackground: self.storedFromStyle.isTransparentBackground)?.path
                /* NOTE: Apply shadow */
//            self.applyShadowProperties(frame: targetFrame,
//                                       cornerRadius: targetShadowCornerRadius,
//                                       cornerStyle: self.storedToStyle.cornerStyle,
//                                       shadowColor: targetShadowColor,
//                                       shadowOpacity: targetShadowOpacity,
//                                       shadowRadius: targetShadowRadius,
//                                       shadowOffset: targetShadowOffset,
//                                       isTransparentBackground: self.storedToStyle.isTransparentBackground)
                self.shadowView?.layer.frame = targetFrame
                self.shadowView?.layer.cornerRadius = targetShadowCornerRadius
                self.shadowView?.layer.shadowColor = targetShadowColor
                self.shadowView?.layer.shadowOpacity = Float(targetShadowOpacity)
                self.shadowView?.layer.shadowRadius = targetShadowRadius
                self.shadowView?.layer.shadowOffset = targetShadowOffset
                self.shadowView?.layer.shadowPath = targetShadowPath
                (self.shadowView?.layer.mask as? CAShapeLayer)?.path = targetShadowMask
            }
                /* NOTE: Translation transform */
//        let transform: CATransform3D = {
//            let currentTranslation: CGPoint = self.layoutContainerView.transform.translation
//            let gestureTranslation: CGPoint = info.translation
//            let targetTranslation: CGPoint = currentTranslation + gestureTranslation
//            return CATransform3D(tx: targetTranslation.x, ty: targetTranslation.y)
//        }()
                /* NOTE: Apply transform */
//        self.layoutContainerView.layer.transform = transform
//        self.shadowView?.layer.transform = transform
        case .fluid:
            guard let pausedGestureInfo: FluidGestureInfo = self.pausedGestureInfo else { return }
            guard let currentGestureInfo: FluidGestureInfo = self.currentGestureInfo else { return }
            let behavior: FluidInteractionBehavior = self.presentationStyle.interactionBehavior
            /* NOTE: Scale transform */
            let targetScale: CGFloat = behavior.isScale ? 1 - self.interactionProgress * 0.1 : 1.0
            let scaleTransform: CATransform3D = CATransform3D(sx: targetScale, sy: targetScale)
            /* NOTE: Translation transform */
            let currentTranslation: CGPoint = self.layoutContainerView.transform.translation
            let pausedGestureTranslation: CGPoint = pausedGestureInfo.translation
            let currentGestureTranslation: CGPoint = currentGestureInfo.translation
            let diffGestureTranslation: CGPoint = currentGestureTranslation - pausedGestureTranslation
            var targetTranslation: CGPoint = currentTranslation + (diffGestureTranslation - currentTranslation) / 4 /* NOTE: Moving to gesture translation */
            targetTranslation = targetTranslation + (.zero - targetTranslation) / 2 /* NOTE: Pulling back by attraction force */
            let translationTransform: CATransform3D = {
                if behavior.isBidirectional {
                    return CATransform3D(tx: targetTranslation.x, ty: targetTranslation.y)
                } else if behavior.isVertical {
                    return CATransform3D(tx: self.layoutContainerView.transform.tx, ty: targetTranslation.y)
                } else {
                    return .identity
                }
            }()
            /* NOTE: Apply transform */
            let targetTransform: CATransform3D = scaleTransform * translationTransform
            self.layoutContainerView.transform = targetTransform.toCGAffineTransform()
            /* NOTE: Corner radius */
            let rangeCornerRadius: CGFloat = (self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius) * 0.8
            let targetCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeCornerRadius * self.interactionProgress
            /* NOTE: Mask */
            if #available(iOS 11.0, *) {
                self.layoutContainerView.layer.cornerRadius = targetCornerRadius
            } else {
                self.layoutContainerView.layer.mask = FluidCornerMaskLayer(bounds: self.storedFromFrame.bounds,
                                                                           cornerRadius: targetCornerRadius,
                                                                           roundingCorners: self.storedFromStyle.roundingCorners)
            }
            /* NOTE: Shadow */
            guard self.shadowView != nil else { return }
            /* NOTE: Shadow frame */
//            let targetSize: CGSize = self.storedFromFrame.size * targetScale
//            let targetOrigin: CGPoint = self.storedFromFrame.origin + CGPoint(x: targetTranslation.x, y: targetTranslation.y)
//            let shadowFrame: CGRect = CGRect(origin: targetOrigin, size: targetSize)
////            var shadowFrame: CGRect = self.finalDimension.frame()
////            shadowFrame.origin += targetTranslation
////            shadowFrame.size *= CGFloat(scaleTransform.decompose().scale.x)
            let shadowFrame: CGRect = self.layoutContainerView.layer.frame
            /* NOTE: Shadow corner radius */
            let rangeShadowCornerRadius: CGFloat = (self.storedFromStyle.cornerRadius - self.storedToStyle.cornerRadius) * 0.5
            let targetShadowCornerRadius: CGFloat = self.storedFromStyle.cornerRadius - rangeShadowCornerRadius * self.interactionProgress
            /* NOTE: Shadow color */
            let rangeShadowColor: CGColor = (self.storedFromStyle.shadowColor - self.storedToStyle.shadowColor) * 0.5
            let targetShadowColor: CGColor = self.storedFromStyle.shadowColor - rangeShadowColor * self.interactionProgress
            /* NOTE: Shadow opacity */
            let rangeShadowOpacity: CGFloat = (self.storedFromStyle.shadowOpacity - self.storedToStyle.shadowOpacity) * 0.5
            let targetShadowOpacity: CGFloat = self.storedFromStyle.shadowOpacity - rangeShadowOpacity * self.interactionProgress
            /* NOTE: Shadow radius */
            let rangeShadowRadius: CGFloat = (self.storedFromStyle.shadowRadius - self.storedToStyle.shadowRadius) * 0.5
            let targetShadowRadius: CGFloat = self.storedFromStyle.shadowRadius - rangeShadowRadius * self.interactionProgress
            /* NOTE: Shadow offset */
            let rangeShadowOffset: CGSize = (self.storedFromStyle.shadowOffset - self.storedToStyle.shadowOffset) * 0.5
            let targetShadowOffset: CGSize = self.storedFromStyle.shadowOffset - rangeShadowOffset * self.interactionProgress
            /* NOTE: Shadow path */
            let targetShadowPath: CGPath? = FluidShadowLayer.createShadowPath(frame: shadowFrame,
                                                                              cornerRadius: targetCornerRadius,
                                                                              roundingCorners: self.storedFromStyle.roundingCorners,
                                                                              shadowRadius: targetShadowRadius,
                                                                              shadowOffset: targetShadowOffset)
            /* NOTE: Shadow mask */
            let targetShadowMask: CGPath? = FluidShadowLayer.createShadowMask(bounds: shadowFrame.bounds,
                                                                              cornerRadius: targetCornerRadius,
                                                                              roundingCorners: self.storedFromStyle.roundingCorners,
                                                                              shadowRadius: targetShadowRadius,
                                                                              shadowOffset: targetShadowOffset,
                                                                              isTransparentBackground: self.storedFromStyle.isTransparentBackground)?.path
            /* NOTE: Apply shadow */
//            self.shadowView?.layer.transform = targetTransform
            self.shadowView?.layer.frame = shadowFrame
            self.shadowView?.layer.cornerRadius = targetShadowCornerRadius
            self.shadowView?.layer.shadowColor = targetShadowColor
            self.shadowView?.layer.shadowOpacity = Float(targetShadowOpacity)
            self.shadowView?.layer.shadowRadius = targetShadowRadius
            self.shadowView?.layer.shadowOffset = targetShadowOffset
            self.shadowView?.layer.shadowPath = targetShadowPath
            (self.shadowView?.layer.mask as? CAShapeLayer)?.path = targetShadowMask
            /* NOTE: Update background */
            let targetVisibility: CGFloat = 1 - self.interactionProgress * 0.5
            self.backgroundView?.visibility = targetVisibility
        case .none:
            break
        }
    }

    func resizeFrame() {
        guard self.animationTimer != nil,
              let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition else { return }
        guard drawerPosition.isBottom else { return } /* IMPORTANT: The resizing interaction is available for only the bottom drawer on the current version */
        /* NOTE: View Frame */
        switch self.interactionType {
        case .normal:
            /* NOTE: Calculate resized margin */
            let targetConstant: CGFloat = self.baseConstantForResizing - self.constantRangeForResizing * self.resizePosition
            let baseConstant: CGFloat = self.baseConstantForResizing
            let expandedConstant: CGFloat = self.expandedConstantForResizing
            let forbidResize: Bool = !self.shouldPerformResizing
            let forbidRange: CGFloat = FluidConst.forbidResizingConstantRange
            let easeFactor: CGFloat = 4
            let baseAttractiveFactor: CGFloat = forbidResize ? 1.5 : 3
            let expandAttractiveFactor: CGFloat = 2
            switch drawerPosition {
            case .top where self.resizePosition > 1:
                var currentConstant: CGFloat = self.layout.bottom.constant
                if forbidResize {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                    currentConstant = currentConstant.clamped(baseConstant, baseConstant + forbidRange)
                } else if targetConstant < baseConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else if targetConstant > expandedConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (expandedConstant - currentConstant) / expandAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else {
                    currentConstant = targetConstant
                }
                self.baseConstants.apply(bottom: currentConstant.clamped(-CGFloat.greatestFiniteMagnitude, 0))
            case .top:
                self.baseConstants.apply(bottom: targetConstant.clamped(-CGFloat.greatestFiniteMagnitude, 0))
            case .bottom where self.resizePosition > 1:
                var currentConstant: CGFloat = self.layout.top.constant
                if forbidResize {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                    currentConstant = currentConstant.clamped(baseConstant - forbidRange, baseConstant)
                } else if targetConstant > baseConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else if targetConstant < expandedConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (expandedConstant - currentConstant) / expandAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else {
                    currentConstant = targetConstant
                }
                self.baseConstants.apply(top: currentConstant.clamped(0, CGFloat.greatestFiniteMagnitude))
            case .bottom:
                self.baseConstants.apply(top: targetConstant.clamped(0, CGFloat.greatestFiniteMagnitude))
            case .left where self.resizePosition > 1:
                var currentConstant: CGFloat = self.layout.right.constant
                if forbidResize {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                    currentConstant = currentConstant.clamped(baseConstant, baseConstant + forbidRange)
                } else if targetConstant < baseConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else if targetConstant > expandedConstant {
                    currentConstant += (targetConstant - currentConstant) / easeFactor
                    currentConstant += (expandedConstant - currentConstant) / expandAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else {
                    currentConstant = targetConstant
                }
                self.baseConstants.apply(right: currentConstant.clamped(-CGFloat.greatestFiniteMagnitude, 0))
            case .left:
                self.baseConstants.apply(right: targetConstant.clamped(-CGFloat.greatestFiniteMagnitude, 0))
            case .right where self.resizePosition > 1:
                var currentConstant: CGFloat = self.layout.left.constant
                if forbidResize {
                    currentConstant += (targetConstant - currentConstant) / 4
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                    currentConstant = currentConstant.clamped(baseConstant - forbidRange, baseConstant)
                } else if targetConstant > baseConstant {
                    currentConstant += (targetConstant - currentConstant) / 4
                    currentConstant += (baseConstant - currentConstant) / baseAttractiveFactor /* NOTE: Pulling back by attraction force */
                } else if targetConstant < expandedConstant {
                    currentConstant += (targetConstant - currentConstant) / 4
                    currentConstant += (expandedConstant - currentConstant) / 2 /* NOTE: Pulling back by attraction force */
                } else {
                    currentConstant = targetConstant
                }
                self.baseConstants.apply(left: currentConstant.clamped(0, CGFloat.greatestFiniteMagnitude))
            case .right:
                self.baseConstants.apply(left: targetConstant.clamped(0, CGFloat.greatestFiniteMagnitude))
            }
            self.layout.apply(edges: self.baseConstants)
            self.layoutContainerView.updateLayoutImmediately()
            /* NOTE: Mask */
            if #available(iOS 11.0, *) {
                self.layoutContainerView.layer.cornerRadius = self.storedFromStyle.cornerRadius
            } else {
                self.layoutContainerView.layer.mask = FluidCornerMaskLayer(bounds: self.layoutContainerView.frame.bounds,
                                                                           cornerRadius: self.storedFromStyle.cornerRadius,
                                                                           roundingCorners: self.storedFromStyle.roundingCorners)
            }
            /* NOTE: Shadow */
            if let shadowView: FluidShadowView = self.shadowView {
                self.applyShadowProperties(frame: self.layoutContainerView.frame,
                                           cornerRadius: shadowView.shadowCornerRadius,
                                           cornerStyle: self.storedFromStyle.cornerStyle,
                                           shadowColor: shadowView.shadowColor,
                                           shadowOpacity: shadowView.shadowOpacity,
                                           shadowRadius: shadowView.shadowRadius,
                                           shadowOffset: shadowView.shadowOffset,
                                           isTransparentBackground: self.storedFromStyle.isTransparentBackground)
            }
        case .fluid:
            break
        case .none:
            break
        }
    }
}
