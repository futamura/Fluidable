//
//  FluidNavigationViewAnimator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 FluidNavigationAnimator
 */
internal class FluidNavigationViewAnimator: NSObject, FluidViewAnimatorCompatible {
    /** Type Aliases */
    typealias Parameters = FluidNavigationParameters
    typealias ControllerDelegate = FluidNavigationControllerDelegate
    typealias RootNavigationControllerDelegate = FluidNavigationRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidNavigationSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidNavigationDestinationViewControllerDelegate

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
