//
//  FluidParametersCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal protocol FluidParametersCompatible: CustomStringConvertible {
    associatedtype ControllerDelegate: FluidControllerDelegateCompatible

    associatedtype RootNavigationControllerDelegate
    associatedtype SourceViewControllerDelegate
    associatedtype DestinationViewControllerDelegate

    /** An `UIViewControllerContextTransitioning` object. */
    var context: UIViewControllerContextTransitioning? { get set }

    /** The `FluidTransitionType` value. */
    var driverType: FluidDriverType { get set }
    /** The `FluidTransitionAnimationType` value. */
    var animationType: FluidAnimationType { get set }
    /** The `FluidTransitionInteractionType` value. */
    var interactionType: FluidDriverInteractionType { get set }

    /** References for `FluidControllerDelegateCompatible` */
    var controllerDelegate: ControllerDelegate? { get set }

    /** References for navigation controllers */
    var rootNavigationController: FluidNavigationController? { get set }
    var sourceViewController: FluidSourceViewController! { get set }
    var destinationViewController: FluidDestinationViewController! { get set }

    /** References for delegates */
    var rootNavigationControllerDelegate: RootNavigationControllerDelegate? { get set }
    var sourceViewControllerDelegate: SourceViewControllerDelegate! { get set }
    var destinationViewControllerDelegate: DestinationViewControllerDelegate! { get set }
    var destinationResizableDelegate: FluidResizableTransitionDelegate? { get set }

    /** Container views */
    var transitionContainerView: UIView! { get set }
    var layoutContainerView: UIView! { get set }
    var sourceView: UIView! { get set }
    var destinationView: UIView! { get set }

    /** Shortcut for `FluidConfigurationDelegate` */
    var allowInteractivePresent: Bool { get set }
    var allowInteractiveDismiss: Bool { get set }

//    var sourceShouldNotifyUpdateState: Bool { get set }
//    var destinationShouldNotifyUpdateState: Bool { get set }

    var allowDismissFromChild: Bool { get set }
    var allowDismissWhenTapBackground: Bool { get set }

    /** The `FluidPresentationStyle` value. */
    var presentationStyle: FluidPresentationStyle { get set }
    /** The `FluidBackgroundStyle` value. */
    var backgroundStyle: FluidBackgroundStyle { get set }

    /** The easing for the presentation. */
    var presentEasing: FluidAnimatorEasing { get set }
    /** The easing for the dismissal. */
    var dismissEasing: FluidAnimatorEasing { get set }

    /** The duration for the presentation. */
    var presentDuration: TimeInterval { get set }
    /** The duration for the dismissal. */
    var dismissDuration: TimeInterval { get set }

    /** Initial frame dimension */
    var initialDimension: FluidInitialFrameDimension { get set }
    /** Final frame dimension */
    var finalDimension: FluidFinalFrameDimension { get set }

    /** Initial frame style */
    var initialStyle: FluidInitialFrameStyle { get set }
    /** Final frame style */
    var finalStyle: FluidFinalFrameStyle { get set }

    /** The screen size value when the transition begins. */
    var initialContainerSize: CGSize { get set }
    /** The screen size value when the transition ends. If the `mode` is` .rotate`, the `initialContainerSize` and the `finalContainerSize` will have different values. */
    var finalContainerSize: CGSize { get set }

    /** The duration of the transition. */
    var activeDuration: TimeInterval { get set }
    /** The `FluidAnimatorEasing` value of the transition. */
    var activeEasing: FluidAnimatorEasing { get set }

    /** Layout constraint */
    var layout: FluidLayout! { get set }

    /** The `Bool` value that indicates whether the shadow should be casted. */
    var shouldCastShadow: Bool { get set }
    /** The `Bool` value that indicates whether the corners should be masked. */
    var shouldMaskCorner: Bool { get set }

    /** The `Bool` value that determines whether the view should perform resize interaction. */
    var shouldPerformResizing: Bool { get set }
    /** The `CGFloat` value that determines minimum vertical margin for resizing. */
    var minimumMarginForResizing: CGFloat { get set }
    /** The `Array` value containing `CGFloat` that determines the positions that the panning view should be snapped to after interaction end. */
    var snapPositionsForResizing: [CGFloat] { get set }

    var expandedConstantForResizing: CGFloat { get set }
    var baseConstantForResizing: CGFloat { get set }
    var constantRangeForResizing: CGFloat { get set }

    /** The `UIView` object for the animators. */
    var interruptibleView: FluidInterruptibleView? { get set }
    var progressView: FluidProgressView? { get set }
    var backgroundView: FluidBackgroundCompatible? { get set }
    var shadowView: FluidShadowView? { get set }

    /** The animators */
    var interruptibleAnimator: FluidInterruptibleAnimator? { get set }
    var progressAnimator: FluidCoreAnimator? { get set }
    var progressBlock: FluidAnimatorCompatible.ProgressBlock? { get set }
    var stateBlock: FluidAnimatorCompatible.StateBlock? { get set }
    var backgroundAnimator: FluidPropertyAnimator? { get set }
    var framePropertyAnimators: [FluidPropertyAnimator]? { get set }
    var frameCoreAnimators: [FluidCoreAnimator]? { get set }
    var extraPropertyAnimators: [FluidPropertyAnimator]? { get set }
    var extraCoreAnimators: [FluidCoreAnimator]? { get set }

    func extraSourceAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible]
    func extraDestinationAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible]

    func fromContainerSize(_ isReversed: Bool) -> CGSize
    func toContainerSize(_ isReversed: Bool) -> CGSize

    func fromViewFrame(_ isReversed: Bool, _ resizePosition: CGFloat) -> CGRect
    func toViewFrame(_ isReversed: Bool, _ resizePosition: CGFloat) -> CGRect

    func fromViewTransform(_ isReversed: Bool) -> CATransform3D
    func toViewTransform(_ isReversed: Bool) -> CATransform3D

    func fromStyle(_ isReversed: Bool) -> FluidFrameStyleCompatible
    func toStyle(_ isReversed: Bool) -> FluidFrameStyleCompatible

    func hasValidReference() -> Bool

    init(driverType: FluidDriverType, animationType: FluidAnimationType,
         context: UIViewControllerContextTransitioning?,
         container: UIView, source: UIViewController?, destination: UIViewController?,
         initialContainerSize: CGSize?, finalContainerSize: CGSize?,
         duration: TimeInterval?, easing: FluidAnimatorEasing?)

    mutating func configureInterruptibleAnimator(interruptibleAnimator: FluidInterruptibleAnimator, interruptibleView: FluidInterruptibleView)
    mutating func configureViews(shouldInsertSubview: Bool)
    mutating func configureProgressAnimator(progressView: FluidProgressView?, progressAnimator: FluidCoreAnimator?, progressBlock: FluidAnimatorCompatible.ProgressBlock?, stateBlock: FluidAnimatorCompatible.StateBlock?)
    mutating func configureBackgroundAnimator(backgroundAnimator: FluidPropertyAnimator?)
    mutating func configureFrameAnimator(frameAnimators: [FluidAnimatorCompatible])
    mutating func configureExtraAnimators(sourceAnimators: [FluidAnimatorCompatible]?, destinationAnimators: [FluidAnimatorCompatible]?)
}

/*
 * NOTE: Dimension
 */
extension FluidParametersCompatible {
    /** The transform value when the transition begins. */
    func fromViewFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat = 0) -> CGRect {
        Logger()?.log("🔑🛠", [
            "isReversed: " + String(debug: isReversed),
            "animationType: " + String(debug: self.animationType),
            "presentationStyle: " + String(debug: self.presentationStyle),
        ])
        switch self.animationType {
        case .present where !isReversed:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.initialDimension.frame(for: self.initialContainerSize)
            case .fluid, .scale:
                return self.initialDimension.frame(for: self.initialContainerSize)
            }
        case .present:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.layoutContainerView.layer.presentation()?.frame ?? self.layoutContainerView.frame
            case .fluid, .scale:
                return self.finalDimension.frame(for: self.finalContainerSize)
            }
        case .dismiss where !isReversed:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.layoutContainerView.layer.presentation()?.frame ?? self.layoutContainerView.frame
            case .fluid, .scale:
                return self.finalDimension.frame(for: self.finalContainerSize)
            }
        case .dismiss:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.layoutContainerView.layer.presentation()?.frame ?? self.layoutContainerView.frame
            case .fluid, .scale:
                return self.finalDimension.frame(for: self.finalContainerSize)
            }
        case .rotate:
            var fromFrame: CGRect = self.finalDimension.frame(for: self.initialContainerSize)
            guard let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition else { return fromFrame }
            let resizeAmount: CGFloat = self.constantRangeForResizing * resizePosition
            switch drawerPosition {
            case .top:
                fromFrame.size.height += abs(resizeAmount)
            case .bottom:
                fromFrame.origin.y -= resizeAmount
                fromFrame.size.height += resizeAmount
            case .left:
                fromFrame.size.width += abs(resizeAmount)
            case .right:
                fromFrame.origin.x -= resizeAmount
                fromFrame.size.width += resizeAmount
            }
            return fromFrame
        }
    }

    /** The transform value when the transition ends. */
    func toViewFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat = 0) -> CGRect {
        switch self.animationType {
        case .present:
            return self.finalDimension.frame(for: self.finalContainerSize)
        case .dismiss where !isReversed:
            return self.initialDimension.frame(for: self.initialContainerSize)
//        case .dismiss:
//            return self.finalDimension.frame(for: self.finalContainerSize)
//        case .rotate:
        case .dismiss, .rotate:
            var toFrame: CGRect = self.finalDimension.frame(for: self.finalContainerSize)
            guard let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition else { return toFrame }
            let resizeAmount: CGFloat = self.constantRangeForResizing * resizePosition
            switch drawerPosition {
            case .top:
                toFrame.size.height += abs(resizeAmount)
            case .bottom:
                toFrame.origin.y -= resizeAmount
                toFrame.size.height += resizeAmount
            case .left:
                toFrame.size.width += abs(resizeAmount)
            case .right:
                toFrame.origin.x -= resizeAmount
                toFrame.size.width += resizeAmount
            }
            return toFrame
        }
    }

    /** The `FluidFrameDimensionCompatible` value when the transition begins. */
    func fromViewTransform(_ isReversed: Bool = false) -> CATransform3D {
        switch self.animationType {
        case .present where !isReversed:
            return self.initialDimension.transform(for: self.initialContainerSize)
        case .present:
            return self.layoutContainerView.layer.presentation()?.transform ?? CATransform3D.identity
        case .dismiss where !isReversed:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.layoutContainerView.layer.presentation()?.transform ?? CATransform3D.identity
            case .fluid, .scale:
                return self.layoutContainerView.layer.presentation()?.transform ?? CATransform3D.identity
            }
        case .dismiss:
            switch self.presentationStyle {
            case .drawer, .slide:
                return self.layoutContainerView.layer.presentation()?.transform ?? CATransform3D.identity
            case .fluid, .scale:
                return self.layoutContainerView.layer.presentation()?.transform ?? CATransform3D.identity
            }
        case .rotate:
            return self.finalDimension.transform(for: self.finalContainerSize)
        }
    }

    /** The `FluidFrameDimensionCompatible` value when the transition ends. */
    func toViewTransform(_ isReversed: Bool = false) -> CATransform3D {
        switch self.animationType {
        case .present where !isReversed:
            return self.finalDimension.transform(for: self.finalContainerSize)
        case .present:
            return self.finalDimension.transform(for: self.finalContainerSize)
        case .dismiss where !isReversed:
            return self.initialDimension.transform(for: self.initialContainerSize)
        case .dismiss:
            return self.finalDimension.transform(for: self.finalContainerSize)
        case .rotate:
            return self.finalDimension.transform(for: self.finalContainerSize)
        }
    }

    /** The `FluidFrameStyleCompatible` value when the transition begins. */
    func fromStyle(_ isReversed: Bool = false) -> FluidFrameStyleCompatible {
        switch self.animationType {
        case .present:
            return self.initialStyle
        case .dismiss where !isReversed:
            var style: FluidFinalFrameStyle = .init(cornerRadius: self.layoutContainerView.layer.cornerRadius,
                                                    cornerStyle: self.finalStyle.cornerStyle,
                                                    shadowColor: self.shadowView?.layer.presentation()?.shadowColor ?? self.finalStyle.shadowColor,
                                                    shadowOpacity: CGFloat(self.shadowView?.layer.presentation()?.shadowOpacity ?? Float(self.finalStyle.shadowOpacity)),
                                                    shadowRadius: self.shadowView?.layer.presentation()?.shadowRadius ?? self.finalStyle.shadowRadius,
                                                    shadowOffset: self.shadowView?.layer.presentation()?.shadowOffset ?? self.finalStyle.shadowOffset)
            return style.validate(for: self.presentationStyle)
        case .dismiss:
            var style: FluidFinalFrameStyle = .init(cornerRadius: self.layoutContainerView.layer.cornerRadius,
                                                    cornerStyle: self.finalStyle.cornerStyle,
                                                    shadowColor: self.shadowView?.layer.presentation()?.shadowColor ?? self.finalStyle.shadowColor,
                                                    shadowOpacity: CGFloat(self.shadowView?.layer.presentation()?.shadowOpacity ?? Float(self.finalStyle.shadowOpacity)),
                                                    shadowRadius: self.shadowView?.layer.presentation()?.shadowRadius ?? self.finalStyle.shadowRadius,
                                                    shadowOffset: self.shadowView?.layer.presentation()?.shadowOffset ?? self.finalStyle.shadowOffset)
            return style.validate(for: self.presentationStyle)

        case .rotate:
            return self.finalStyle
        }
    }

    /** The `FluidFrameStyleCompatible` value when the transition ends. */
    func toStyle(_ isReversed: Bool = false) -> FluidFrameStyleCompatible {
        switch self.animationType {
        case .present: return self.finalStyle
        case .dismiss where !isReversed: return self.initialStyle
        case .dismiss: return self.finalStyle
        case .rotate:  return self.finalStyle
        }
    }

    /** The screen size value when the transition begins. */
    func fromContainerSize(_ isReversed: Bool = false) -> CGSize {
        switch self.animationType {
        case .present: return self.initialContainerSize
        case .dismiss: return self.finalContainerSize
        case .rotate:  return self.initialContainerSize
        }
    }

    /** The screen size value when the transition ends. If the `mode` is` .rotate`, the `initialContainerSize` and the `finalContainerSize` will have different values. */
    func toContainerSize(_ isReversed: Bool = false) -> CGSize {
        switch self.animationType {
        case .present: return self.finalContainerSize
        case .dismiss where !isReversed: return self.initialContainerSize
        case .dismiss: return self.finalContainerSize
        case .rotate:  return self.finalContainerSize
        }
    }
}

extension FluidParametersCompatible {
    public var description: String {
        return """
               \(type(of: self))(
               - \("driverType".lpad(36)): \(String(debug: driverType))
               - \("animationType".lpad(36)): \(String(debug: animationType))
               - \("interactionType".lpad(36)): \(String(debug: interactionType))
               - \("context".lpad(36)): \(String(debug: context))
               - \("rootNavigationController".lpad(36)): \(String(debug: rootNavigationController))
               - \("rootNavigationController.view".lpad(36)): \(String(debug: rootNavigationController?.view))
               - \("sourceViewController".lpad(36)): \(String(debug: sourceViewController))
               - \("sourceViewController.view".lpad(36)): \(String(debug: sourceViewController.view))
               - \("destinationViewController".lpad(36)): \(String(debug: destinationViewController))
               - \("destinationViewController.view".lpad(36)): \(String(debug: destinationViewController.view))
               - \("rootNavigationControllerDelegate".lpad(36)): \(String(debug: rootNavigationControllerDelegate))
               - \("sourceViewControllerDelegate".lpad(36)): \(String(debug: sourceViewControllerDelegate))
               - \("destinationViewControllerDelegate".lpad(36)): \(String(debug: destinationViewControllerDelegate))
               - \("destinationResizableDelegate".lpad(36)): \(String(debug: destinationResizableDelegate))
               - \("controllerDelegate".lpad(36)): \(String(debug: controllerDelegate))
               - \("transitionContainerView".lpad(36)): \(String(debug: transitionContainerView))
               - \("layoutContainerView".lpad(36)): \(String(debug: layoutContainerView))
               - \("sourceView".lpad(36)): \(String(debug: sourceView))
               - \("destinationView".lpad(36)): \(String(debug: destinationView))
               - \("allowInteractivePresent".lpad(36)): \(String(debug: allowInteractivePresent))
               - \("allowInteractiveDismiss".lpad(36)): \(String(debug: allowInteractiveDismiss))
               - \("shouldPerformResizing".lpad(36)): \(String(debug: shouldPerformResizing))
               - \("minimumMarginForResizing".lpad(36)): \(String(debug: minimumMarginForResizing))
               - \("snapPositionsForResizing".lpad(36)): \(String(debug: snapPositionsForResizing))
               - \("baseConstantForResizing".lpad(36)): \(String(debug: baseConstantForResizing))
               - \("expandedConstantForResizing".lpad(36)): \(String(debug: expandedConstantForResizing))
               - \("constantRangeForResizing".lpad(36)): \(String(debug: constantRangeForResizing))
               - \("presentationStyle".lpad(36)): \(String(debug: presentationStyle))
               - \("backgroundStyle".lpad(36)): \(String(debug: backgroundStyle))
               - \("presentEasing".lpad(36)): \(String(debug: presentEasing))
               - \("dismissEasing".lpad(36)): \(String(debug: dismissEasing))
               - \("presentDuration".lpad(36)): \(String(debug: presentDuration))
               - \("dismissDuration".lpad(36)): \(String(debug: dismissDuration))
               - \("initialDimension".lpad(36)): \(String(debug: initialDimension))
               - \("finalDimension".lpad(36)): \(String(debug: finalDimension))
               - \("initialStyle".lpad(36)): \(String(debug: initialStyle))
               - \("finalStyle".lpad(36)): \(String(debug: finalStyle))
               - \("initialContainerSize".lpad(36)): \(String(debug: initialContainerSize))
               - \("finalContainerSize".lpad(36)): \(String(debug: finalContainerSize))
               - \("activeDuration".lpad(36)): \(String(debug: activeDuration))
               - \("activeEasing".lpad(36)): \(String(debug: activeEasing))
               - \("layoutTop".lpad(36)): \(String(debug: self.layout.top))
               - \("layoutBottom".lpad(36)): \(String(debug: self.layout.bottom))
               - \("layoutLeft".lpad(36)): \(String(debug: self.layout.left))
               - \("layoutRight".lpad(36)): \(String(debug: self.layout.right))
               - \("shouldCastShadow".lpad(36)): \(String(debug: shouldCastShadow))
               - \("shouldMaskCorner".lpad(36)): \(String(debug: shouldMaskCorner))
               - \("interruptibleView".lpad(36)): \(String(debug: interruptibleView))
               - \("progressView".lpad(36)): \(String(debug: progressView))
               - \("shadowView".lpad(36)): \(String(debug: shadowView))
               - \("backgroundView".lpad(36)): \(String(debug: backgroundView))
               - \("interruptibleAnimator".lpad(36)): \(String(debug: interruptibleAnimator))
               - \("progressAnimator".lpad(36)): \(String(debug: progressAnimator))
               - \("progressBlock".lpad(36)): \(String(debug: progressBlock))
               - \("stateBlock".lpad(36)): \(String(debug: stateBlock))
               - \("backgroundAnimator".lpad(36)): \(String(debug: backgroundAnimator))
               - \("framePropertyAnimators".lpad(36)): \(String(debug: framePropertyAnimators))
               - \("frameCoreAnimators".lpad(36)): \(String(debug: frameCoreAnimators))
               - \("extraPropertyAnimators".lpad(36)): \(String(debug: extraPropertyAnimators))
               - \("extraCoreAnimators".lpad(36)): \(String(debug: extraCoreAnimators))
               )
               """
    }
}
