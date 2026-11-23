//
//  FluidNavigationViewAnimator+Animated.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

extension FluidNavigationViewAnimator {
    func animationWillStart(isReversed: Bool) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🕊💥", [])
        return self.createFrameAnimation(isReversed) + self.createCornerRadiusPropertyAnimation(isReversed) + self.createShadowPropertyAnimation(isReversed)
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
