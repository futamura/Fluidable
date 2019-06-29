//
//  FluidNavigationViewAnimator+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Configuring frame animation
 */
extension FluidNavigationViewAnimator {
    func createFrameAnimation(_ isReversed: Bool = false) -> [FluidAnimatorCompatible] {
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: 👌 Configure properties to animate */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let transitionEasing: FluidAnimatorEasing = !isReversed ? self.activeEasing : .easeInOutQuad
        let fromContainerSize: CGSize = self.fromContainerSize(isReversed)
        let toContainerSize: CGSize = self.toContainerSize(isReversed)
        let fromFrame: CGRect = self.fromViewFrame(isReversed, self.resizePosition)
        let toFrame: CGRect = self.toViewFrame(isReversed, self.resizePosition)
//        let fromTransform: CATransform3D = self.fromViewTransform(isReversed)
        let toTransform: CATransform3D = self.toViewTransform(isReversed)
        let fromConstants: FluidLayoutEdgeConstant = .init(size: fromContainerSize, frame: fromFrame)
        let toConstants: FluidLayoutEdgeConstant = .init(size: toContainerSize, frame: toFrame)
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        Logger()?.log("🕊🛠", [
            "isReversed:".lpad() + String(describing: isReversed),
            "animationType:".lpad() + String(describing: self.animationType),
            "presentationStyle:".lpad() + String(describing: self.presentationStyle),
            "backgroundStyle:".lpad() + String(describing: self.backgroundStyle),
            "activeDuration:".lpad() + String(describing: activeDuration),
            "transitionDuration:".lpad() + String(describing: transitionDuration),
            "activeEasing:".lpad() + String(describing: activeEasing),
            "transitionEasing:".lpad() + String(describing: transitionEasing),
            "containerView:".lpad() + String(describing: containerView),
            "sourceView:".lpad() + String(describing: sourceView),
            "animationView:".lpad() + String(describing: animationView),
            "animationView.layer.frame:".lpad() + String(describing: animationView.layer.frame),
            "animationView.layer.presentation()?.frame:".lpad() + String(describing: animationView.layer.presentation()?.frame),
            "destinationView:".lpad() + String(describing: destinationView),
            "destinationView.layer.frame:".lpad() + String(describing: destinationView.layer.frame),
            "destinationView.layer.presentation()?.frame:".lpad() + String(describing: destinationView.layer.presentation()?.frame),
            "fromContainerSize:".lpad() + String(describing: fromContainerSize),
            "toContainerSize:".lpad() + String(describing: toContainerSize),
            "fromFrame:".lpad() + String(describing: fromFrame),
            "toFrame:".lpad() + String(describing: toFrame),
//            "fromTransform:".lpad() + String(describing: fromTransform),
            "toTransform:".lpad() + String(describing: toTransform),
            "fromConstants:".lpad() + String(describing: fromConstants),
            "toConstants:".lpad() + String(describing: toConstants),
            "fromStyle:".lpad() + String(describing: fromStyle),
            "toStyle:".lpad() + String(describing: toStyle),
        ])
        /* NOTE: 👍 Set properties before run animation */
        if self.animationType.isPresent {
            self.animationView.alpha = fromStyle.alpha
            self.animationView.frame = fromFrame
            self.animationView.transform = toTransform.toCGAffineTransform()
//            self.layout.apply(edges: fromConstants)
            self.containerView.updateLayoutImmediately()
        }
        /* NOTE: 🐅 Configure constraint animator */
        self.containerView.setNeedsLayout()
        let frameConstraintAnimator: FluidPropertyAnimator = .init(duration: transitionDuration, easing: transitionEasing, id: "frameConstraintAnimator (\(String(describing: self.animationType).capitalized))")
        frameConstraintAnimator.add({ [weak self] in
            guard let `self`: FluidNavigationViewAnimator = self else { return }
            self.animationView.alpha = toStyle.alpha
            self.animationView.frame = toFrame
            self.animationView.transform = toTransform.toCGAffineTransform()
//            self.layout.apply(edges: toConstants)
            self.containerView.layoutIfNeeded()
        })
        animators.append(frameConstraintAnimator)
        /* NOTE: Return animators */
        return animators
    }
}
