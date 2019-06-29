//
//  FluidTransitionViewAnimator+Animated.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidTransitionViewAnimator {
    func animationWillStart(isReversed: Bool) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🕊💥", [])
        if #available(iOS 11.0, *) {
            return self.createFrameAnimation(isReversed) + self.createCornerRadiusPropertyAnimation(isReversed) + self.createShadowPropertyAnimation(isReversed)
        } else {
            return self.createFrameAnimation(isReversed) + self.createCornerRadiusCoreAnimation(isReversed) + self.createShadowCoreAnimation(isReversed)
        }
    }

    func animationDidStart() {
//        Logger()?.log("🕊💥", [])
//        self.debugAnimators()
    }

    func animationDidUpdate(progress: CGFloat) {
//        self.debugAnimators()
    }

    func animationDidFinish(isCancelled: Bool) {
//        Logger()?.log("🕊💥", ["isCancelled:".lpad() + String(describing: isCancelled)])
//        self.debugAnimators()
    }

    func animationWillInvalidate(willRemoveContainer: Bool) {
//        Logger()?.log("🕊💥", ["willRemoveContainer:".lpad() + String(describing: willRemoveContainer)])
    }
}
