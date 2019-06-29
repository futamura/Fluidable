//
//  FluidParametersAccessible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal protocol FluidParametersAccessible: NSObjectProtocol {
    associatedtype ControllerDelegate: FluidControllerDelegateCompatible
    associatedtype Parameters: FluidParametersCompatible

    associatedtype RootNavigationControllerDelegate
    associatedtype SourceViewControllerDelegate
    associatedtype DestinationViewControllerDelegate

    /** The `UIViewControllerContextTransitioning` object. */
    var context: UIViewControllerContextTransitioning? { get }

    /** The `FluidTransitionType` value. */
    var driverType: FluidDriverType { get }
    /** The `FluidTransitionAnimationType` value. */
    var animationType: FluidAnimationType { get }
    /** The `FluidTransitionInteractionType` value. */
    var interactionType: FluidDriverInteractionType { get }

    /** The `FluidParametersCompatible` object. */
    var parameters: Parameters! { set get }

    /** The reference to `FluidControllerDelegateCompatible`. */
    var controllerDelegate: ControllerDelegate? { get }

    /** References for navigation controllers */
    var rootNavigationController: FluidNavigationController? { get }
    var sourceViewController: FluidSourceViewController! { get }
    var destinationViewController: FluidDestinationViewController! { get }

    /** References for delegates */
    var rootNavigationControllerDelegate: RootNavigationControllerDelegate? { get }
    var sourceViewControllerDelegate: SourceViewControllerDelegate! { get }
    var destinationViewControllerDelegate: DestinationViewControllerDelegate! { get }

    /** The reference to the container view. */
    var containerView: UIView! { get }
    /** The reference to the source view that transition starts from. */
    var sourceView: UIView! { get }
    /** The reference to the destination view that displayed above the source view. */
    var destinationView: UIView! { get }
    /** The reference to the animated view that displayed above the source view. */
    var animationView: UIView! { get }

    /** The `Bool` value that determines whether an interactive present transition can begin. */
    var allowInteractivePresent: Bool { get }
    /** The `Bool` value that determines whether an interactive dismissal transition can begin. */
    var allowInteractiveDismiss: Bool { get }

//    /** The `Bool` value that determines whether the source delegate receives animation progress event. */
//    var sourceShouldNotifyUpdateState: Bool { get }
//    /** The `Bool` value that determines whether the destination delegate receives animation progress event. */
//    var destinationShouldNotifyUpdateState: Bool { get }

    /** The reference to `FluidResizableDelegate`. */
    var destinationResizableDelegate: FluidResizableTransitionDelegate? { get }

    /** The `Bool` value that determines whether only a root view controller can begin a dismissal transition. */
    var allowDismissFromChild: Bool { get }
    /** The `Bool` value that determines whether the view should dismiss when a user taps the background. */
    var allowDismissWhenTapBackground: Bool { get }

    /** The `FluidPresentationStyle`. */
    var presentationStyle: FluidPresentationStyle { get }
    /** The `FluidBackgroundStyle`. */
    var backgroundStyle: FluidBackgroundStyle { get }

    /** The `FluidAnimatorEasing` for presentation transition. */
    var presentEasing: FluidAnimatorEasing { get }
    /** The `FluidAnimatorEasing` for dismissal transition. */
    var dismissEasing: FluidAnimatorEasing { get }

    /** The transition duration for presentation transition. */
    var presentDuration: TimeInterval { get }
    /** The transition duration for dismissal transition. */
    var dismissDuration: TimeInterval { get }

    /** The initial frame dimension at the beginning of transition. */
    var initialDimension: FluidInitialFrameDimension { get }
    /** The final frame dimension at the end of transition. */
    var finalDimension: FluidFinalFrameDimension { get }

    /** The initial frame style at the beginning of transition. */
    var initialStyle: FluidInitialFrameStyle { get }
    /** The final frame style at the end of transition. */
    var finalStyle: FluidFinalFrameStyle { get }

    /** The `Bool` value that determines whether the view should perform resize interaction. */
    var shouldPerformResizing: Bool { get }
    /** The `CGFloat` value that determines the minimum vertical margin when the view is resized to maximum size. */
    var minimumMarginForResizing: CGFloat { get }
    /** The `Array` value containing `CGFloat` that determines the positions that the panning view should be snapped to after interaction end. */
    var snapPositionsForResizing: [CGFloat] { get }

    /** The margin to the screen edge when the view is resized to maximum size. */
    var expandedConstantForResizing: CGFloat { get }
    /** The margin to the screen edge when the view is resized to minimum size. */
    var baseConstantForResizing: CGFloat { get }
    /** The resizable range of margin. */
    var constantRangeForResizing: CGFloat { get }

    /** The `FluidLayout` object that manages layout constraint. */
    var layout: FluidLayout! { get }

    /** The `Bool` value that indicates whether the destination view is displayed as fullscreen. */
    var isFullScreen: Bool { get }

    /** The screen size at the beginning of transition. */
    var initialContainerSize: CGSize { get }
    /** The screen size at the end of transition. If the `animationType` is` .rotate`, the `initialContainerSize` and the `finalContainerSize` have different values. */
    var finalContainerSize: CGSize { get }

    /** The reference to the `FluidBackgroundCompatible` object. */
    var backgroundView: FluidBackgroundCompatible? { get }
    /** The reference to the `FluidShadowView` object. */
    var shadowView: FluidShadowView? { get }
    /** The `Bool` value that indicates whether the view should be cast shadow. */
    var shouldCastShadow: Bool { get }
    /** The `Bool` value that indicates whether the view should mask corners. */
    var shouldMaskCorner: Bool { get }

    /** The screen size value when the transition begins. */
    func fromContainerSize(_ isReversed: Bool) -> CGSize
    /** The screen size value when the transition ends. */
    func toContainerSize(_ isReversed: Bool) -> CGSize

    /** The frame value when the transition begins. */
    func fromViewFrame(_ isReversed: Bool, _ resizePosition: CGFloat) -> CGRect
    /** The frame value when the transition ends. */
    func toViewFrame(_ isReversed: Bool, _ resizePosition: CGFloat) -> CGRect

    /** The transform value when the transition begins. */
    func fromViewTransform(_ isReversed: Bool) -> CATransform3D
    /** The transform value when the transition ends. */
    func toViewTransform(_ isReversed: Bool) -> CATransform3D

    /** The `FluidFrameStyleCompatible` value when the transition begins. */
    func fromStyle(_ isReversed: Bool) -> FluidFrameStyleCompatible
    /** The `FluidFrameStyleCompatible` value when the transition ends. */
    func toStyle(_ isReversed: Bool) -> FluidFrameStyleCompatible

    /**
     The functions that configures parameters.

     - parameter transitionParameters: The `FluidTransitionParameters` value.
     - returns: The `FluidParametersAccessible` object.
     */
    @discardableResult
    func registerParameters<T: FluidParametersCompatible>(parameters: T) -> Self

    /** The functions that validates parameters. */
    func hasValidReference() -> Bool
}

/**
 Default implementation
 */
extension FluidParametersAccessible {
    weak var context: UIViewControllerContextTransitioning? { return self.parameters.context }

    weak var controllerDelegate: ControllerDelegate? { return self.parameters?.controllerDelegate as? ControllerDelegate }

    /** References to controllers */
    weak var rootNavigationController: FluidNavigationController? { return self.parameters.rootNavigationController }
    weak var sourceViewController: FluidSourceViewController! { return self.parameters.sourceViewController }
    weak var destinationViewController: FluidDestinationViewController! { return self.parameters.destinationViewController }

    /** References to delegates */
    var rootNavigationControllerDelegate: RootNavigationControllerDelegate? { return self.parameters.rootNavigationControllerDelegate as? RootNavigationControllerDelegate }
    var sourceViewControllerDelegate: SourceViewControllerDelegate! { return self.parameters.sourceViewControllerDelegate as? SourceViewControllerDelegate }
    var destinationViewControllerDelegate: DestinationViewControllerDelegate! { return self.parameters.destinationViewControllerDelegate as? DestinationViewControllerDelegate }

    /** The reference to `FluidResizableDelegate` */
    var destinationResizableDelegate: FluidResizableTransitionDelegate? { return self.parameters.destinationResizableDelegate }

    var driverType: FluidDriverType { return self.parameters.driverType }
    var animationType: FluidAnimationType { return self.parameters.animationType }
    var interactionType: FluidDriverInteractionType { return self.parameters.interactionType }

    weak var containerView: UIView! { return self.parameters.containerView }
    weak var sourceView: UIView! { return self.parameters.sourceView }
    weak var destinationView: UIView! { return self.parameters.destinationView }
    weak var animationView: UIView! { return self.parameters.animationView }

    var allowInteractivePresent: Bool { return self.parameters.allowInteractivePresent }
    var allowInteractiveDismiss: Bool { return self.parameters.allowInteractiveDismiss }

//    var sourceShouldNotifyUpdateState: Bool { return self.parameters.sourceShouldNotifyUpdateState }
//    var destinationShouldNotifyUpdateState: Bool { return self.parameters.destinationShouldNotifyUpdateState }

    var allowDismissFromChild: Bool { return self.parameters.allowDismissFromChild }
    var allowDismissWhenTapBackground: Bool { return self.parameters.allowDismissWhenTapBackground }

    var presentationStyle: FluidPresentationStyle { return self.parameters.presentationStyle }
    var backgroundStyle: FluidBackgroundStyle { return self.parameters.backgroundStyle }

    var presentEasing: FluidAnimatorEasing { return self.parameters.presentEasing }
    var dismissEasing: FluidAnimatorEasing { return self.parameters.dismissEasing }

    var presentDuration: TimeInterval { return self.parameters.presentDuration }
    var dismissDuration: TimeInterval { return self.parameters.dismissDuration }

    var initialDimension: FluidInitialFrameDimension { return self.parameters.initialDimension }
    var finalDimension: FluidFinalFrameDimension { return self.parameters.finalDimension }

    var initialStyle: FluidInitialFrameStyle { return self.parameters.initialStyle }
    var finalStyle: FluidFinalFrameStyle { return self.parameters.finalStyle }

    var shouldPerformResizing: Bool { return self.parameters.shouldPerformResizing }
    var minimumMarginForResizing: CGFloat { return self.parameters.minimumMarginForResizing }
    var snapPositionsForResizing: [CGFloat] { return self.parameters.snapPositionsForResizing }

    var baseConstantForResizing: CGFloat { return self.parameters.baseConstantForResizing }
    var expandedConstantForResizing: CGFloat { return self.parameters.expandedConstantForResizing }
    var constantRangeForResizing: CGFloat { return self.parameters.constantRangeForResizing }

    var layout: FluidLayout! { return self.parameters.layout }

    var isFullScreen: Bool { return self.layout.isFullScreen }

    var initialContainerSize: CGSize { return self.parameters.initialContainerSize }
    var finalContainerSize: CGSize { return self.parameters.finalContainerSize }

    var shouldCastShadow: Bool { return self.parameters.shouldCastShadow }
    var shouldMaskCorner: Bool { return self.parameters.shouldMaskCorner }

    /** The `UIView` object for the animators. */
    var interruptibleView: FluidInterruptibleView? { return self.parameters.interruptibleView }
    var progressView: FluidProgressView? { return self.parameters.progressView }
    var backgroundView: FluidBackgroundCompatible? { return self.parameters.backgroundView }
    var shadowView: FluidShadowView? { return self.parameters.shadowView }

    /* The animators. */
    var interruptibleAnimator: FluidInterruptibleAnimator? { return self.parameters.interruptibleAnimator }
    var progressAnimator: FluidCoreAnimator? { return self.parameters?.progressAnimator }
    var progressBlock: FluidAnimatorCompatible.ProgressBlock? { return self.parameters.progressBlock }
    var stateBlock: FluidAnimatorCompatible.StateBlock? { return self.parameters.stateBlock }
    var backgroundAnimator: FluidPropertyAnimator? { return self.parameters.backgroundAnimator }
    var framePropertyAnimators: [FluidPropertyAnimator]? { return self.parameters.framePropertyAnimators }
    var frameCoreAnimators: [FluidCoreAnimator]? { return self.parameters.frameCoreAnimators }
    var extraPropertyAnimators: [FluidPropertyAnimator]? { return self.parameters.extraPropertyAnimators }
    var extraCoreAnimators: [FluidCoreAnimator]? { return self.parameters.extraCoreAnimators }

    /* Dimensions */
    func fromContainerSize(_ isReversed: Bool = false) -> CGSize { return self.parameters.fromContainerSize(isReversed) }
    func toContainerSize(_ isReversed: Bool = false) -> CGSize { return self.parameters.toContainerSize(isReversed) }

    func fromViewFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat = 0) -> CGRect { return self.parameters.fromViewFrame(isReversed, resizePosition) }
    func toViewFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat = 0) -> CGRect { return self.parameters.toViewFrame(isReversed, resizePosition) }

    func fromViewTransform(_ isReversed: Bool = false) -> CATransform3D { return self.parameters.fromViewTransform(isReversed) }
    func toViewTransform(_ isReversed: Bool = false) -> CATransform3D { return self.parameters.toViewTransform(isReversed) }

    func fromStyle(_ isReversed: Bool = false) -> FluidFrameStyleCompatible { return self.parameters.fromStyle(isReversed) }
    func toStyle(_ isReversed: Bool = false) -> FluidFrameStyleCompatible { return self.parameters.toStyle(isReversed) }

    /* Registration */
    @discardableResult
    func registerParameters<T: FluidParametersCompatible>(parameters: T) -> Self {
        self.parameters = parameters as? Parameters
        return self
    }

    /* Validation */
    func hasValidReference() -> Bool { return self.parameters?.hasValidReference() ?? false }
}
