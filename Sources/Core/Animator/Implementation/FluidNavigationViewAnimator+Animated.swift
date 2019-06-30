//
//  FluidNavigationViewAnimator+Animated.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidNavigationViewAnimator {
    func animationWillStart(isReversed: Bool) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🕊💥", [])
        if #available(iOS 11.0, *) {
            return self.createFrameAnimation(isReversed) + self.createCornerRadiusPropertyAnimation(isReversed) + self.createShadowPropertyAnimation(isReversed)
        } else {
            return self.createFrameAnimation(isReversed) + self.createCornerRadiusCoreAnimation(isReversed) + self.createShadowCoreAnimation(isReversed)
        }
    }

    func animationDidStart() {
    }

    func animationDidUpdate(progress: CGFloat) {
    }

    func animationDidFinish(isCancelled: Bool) {
    }

    func animationWillInvalidate(willRemoveContainer: Bool) {
    }
}
