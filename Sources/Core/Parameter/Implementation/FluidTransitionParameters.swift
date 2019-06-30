//
//  FluidTransitionParameters.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

struct FluidTransitionParameters: FluidParametersCompatible {
    /** Type Aliases */
    typealias ControllerDelegate = FluidViewControllerTransitioningDelegate

    typealias RootNavigationControllerDelegate = FluidTransitionRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidTransitionSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidTransitionDestinationViewControllerDelegate

    /** References for `FluidViewControllerTransitioningDelegate` */
    weak var controllerDelegate: ControllerDelegate? = nil

    /** References for controllers */
    weak var rootNavigationController: FluidNavigationController? = nil
    weak var sourceViewController: FluidSourceViewController! = nil
    weak var destinationViewController: FluidDestinationViewController! = nil

    /** References for delegates */
    weak var rootNavigationControllerDelegate: RootNavigationControllerDelegate? = nil
    weak var sourceViewControllerDelegate: SourceViewControllerDelegate! = nil
    weak var destinationViewControllerDelegate: DestinationViewControllerDelegate! = nil

    /** References for `FluidResizableTransitionDelegate` */
    weak var destinationResizableDelegate: FluidResizableTransitionDelegate? = nil

    /** An `UIViewControllerContextTransitioning` object. */
    weak var context: UIViewControllerContextTransitioning?

    /** The `FluidTransitionType` value. */
    var driverType: FluidDriverType
    /** The `FluidTransitionAnimationType` value. */
    var animationType: FluidAnimationType
    /** The `FluidTransitionInteractionType` value. */
    var interactionType: FluidDriverInteractionType

    /** Views for `FluidActionDelegate` */
    weak var containerView: UIView!
    weak var sourceView: UIView!
    weak var destinationView: UIView!
    weak var animationView: UIView! = nil

    /** Shortcut for `FluidConfigurationDelegate` */
    var allowInteractivePresent: Bool
    var allowInteractiveDismiss: Bool
    var allowDismissFromChild: Bool
//    var sourceShouldNotifyUpdateState: Bool
//    var destinationShouldNotifyUpdateState: Bool
    var allowDismissWhenTapBackground: Bool

    /** The `FluidPresentationStyle` value. */
    var presentationStyle: FluidPresentationStyle
    /** The `FluidBackgroundStyle` value. */
    var backgroundStyle: FluidBackgroundStyle

    /** The easing for the presentation. */
    var presentEasing: FluidAnimatorEasing
    /** The easing for the dismissal. */
    var dismissEasing: FluidAnimatorEasing

    /** The duration for the presentation. */
    var presentDuration: TimeInterval
    /** The duration for the dismissal. */
    var dismissDuration: TimeInterval

    /** Initial frame dimension */
    var initialDimension: FluidInitialFrameDimension
    /** Final frame dimension */
    var finalDimension: FluidFinalFrameDimension

    /** Initial frame style */
    var initialStyle: FluidInitialFrameStyle
    /** Final frame style */
    var finalStyle: FluidFinalFrameStyle

    /** The screen size value when the transition begins. */
    var initialContainerSize: CGSize
    /** The screen size value when the transition ends. If the `mode` is` .rotate`, the `initialContainerSize` and the `finalContainerSize` will have different values. */
    var finalContainerSize: CGSize

    /** The duration of the transition. */
    var activeDuration: TimeInterval
    /** The `FluidAnimatorEasing` value of the transition. */
    var activeEasing: FluidAnimatorEasing

    /** The `Bool` value that determines whether the view should perform resize interaction. */
    var shouldPerformResizing: Bool
    /** The `CGFloat` value that determines minimum vertical margin for resizing. */
    var minimumMarginForResizing: CGFloat
    /** The `Array` value containing `CGFloat` that determines the positions that the panning view should be snapped to after interaction end. */
    var snapPositionsForResizing: [CGFloat]

    var expandedConstantForResizing: CGFloat
    var baseConstantForResizing: CGFloat
    var constantRangeForResizing: CGFloat

    /** Layout constraint */
    var layout: FluidLayout! = nil

    /** The `Bool` value that indicates whether the shadow should be casted. */
    var shouldCastShadow: Bool
    /** The `Bool` value that indicates whether the corners should be masked. */
    var shouldMaskCorner: Bool

    /** The `UIView` object for the animators. */
    weak var interruptibleView: FluidInterruptibleView? = nil
    weak var progressView: FluidProgressView? = nil
    weak var backgroundView: FluidBackgroundCompatible? = nil
    weak var shadowView: FluidShadowView? = nil

    /** The animators */
    var progressAnimator: FluidCoreAnimator? = nil
    var progressBlock: FluidAnimatorCompatible.ProgressBlock? = nil
    var stateBlock: FluidAnimatorCompatible.StateBlock? = nil
    var interruptibleAnimator: FluidInterruptibleAnimator? = nil
    var backgroundAnimator: FluidPropertyAnimator? = nil
    var framePropertyAnimators: [FluidPropertyAnimator]? = nil
    var frameCoreAnimators: [FluidCoreAnimator]? = nil
    var extraPropertyAnimators: [FluidPropertyAnimator]? = nil
    var extraCoreAnimators: [FluidCoreAnimator]? = nil
}
