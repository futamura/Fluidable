//
//  FluidTransitionViewAnimator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 FluidTransitionAnimator
 */
internal class FluidTransitionViewAnimator: NSObject, FluidViewAnimatorCompatible {
    /** Type Aliases */
    typealias Parameters = FluidTransitionParameters
    typealias ControllerDelegate = FluidViewControllerTransitioningDelegate
    typealias RootNavigationControllerDelegate = FluidTransitionRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidTransitionSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidTransitionDestinationViewControllerDelegate

    /** Variables for interaction */
    var pausedAnimationProgress: CGFloat = 0
    var interactionProgress: CGFloat = 0
    var pausedInteractionProgress: CGFloat = 0
    var resizePosition: CGFloat = 0
    var pausedGestureInfo: FluidGestureInfo?
    var currentGestureInfo: FluidGestureInfo?

    /** The frame and style variables to reduce computational load */
    var storedFromFrame: CGRect!
    var storedToFrame: CGRect!
    var storedFromStyle: FluidFrameStyleCompatible!
    var storedToStyle: FluidFrameStyleCompatible!

    /** Base layout constants for resizing */
    var baseConstants: FluidLayoutEdgeConstant!

    /* The display timer for fluid interaction. */
    var animationTimer: FluidViewAnimatorTimer?

    override init() {
        super.init()
    }
}
