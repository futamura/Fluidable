//
//  FluidTransitionParameters+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal extension FluidTransitionParameters {
    /* swiftlint:disable:next function_body_length */
    init(driverType: FluidDriverType, animationType: FluidAnimationType,
         context: UIViewControllerContextTransitioning?,
         container: UIView, source: UIViewController?, destination: UIViewController?,
         initialContainerSize: CGSize? = nil, finalContainerSize: CGSize? = nil,
         duration: TimeInterval? = nil, easing: FluidAnimatorEasing? = nil) {
        Logger()?.log("🥈🛠", [
//            "driverType: " + String(debug: driverType),
//            "animationType: " + String(debug: animationType),
//            "context: " + String(debug: context),
//            "container: " + String(debug: container),
//            "source: " + String(debug: source),
//            "destination: " + String(debug: destination),
//            "initialContainerSize: " + String(debug: initialContainerSize),
//            "finalContainerSize: " + String(debug: finalContainerSize),
//            "duration: " + String(debug: duration),
//            "easing: " + String(debug: easing),
        ])
        /* NOTE: Predefine variables */
        var rootNavigationController: FluidNavigationController?
        var sourceViewController: FluidSourceViewController!
        var destinationViewController: FluidDestinationViewController!
        var transitioningDelegate: FluidViewControllerTransitioningDelegate?
        var rootNavigationControllerDelegate: RootNavigationControllerDelegate?
        var sourceViewControllerDelegate: SourceViewControllerDelegate!
        var destinationViewControllerDelegate: DestinationViewControllerDelegate!
        var destinationResizableDelegate: FluidResizableTransitionDelegate?
        /* NOTE: Specify source controllers and delegates */
        switch source {
        case is UINavigationController:
            sourceViewController = (source as? UINavigationController)?.viewControllers.last as? FluidSourceViewController
            sourceViewControllerDelegate = sourceViewController?.fluidDelegate as? SourceViewControllerDelegate
        case is FluidSourceViewController:
            sourceViewController = source as? FluidSourceViewController
            sourceViewControllerDelegate = sourceViewController?.fluidDelegate as? SourceViewControllerDelegate
        default:
            break
        }
        /* NOTE: Specify destination controllers and delegates */
        switch destination {
        case is FluidNavigationController:
            rootNavigationController = destination as? FluidNavigationController
            rootNavigationControllerDelegate = rootNavigationController?.fluidDelegate as? RootNavigationControllerDelegate
            destinationViewController = rootNavigationController?.viewControllers.last as? FluidDestinationViewController
            destinationViewControllerDelegate = destinationViewController?.fluidDelegate as? DestinationViewControllerDelegate
//            destinationResizableDelegate = (rootNavigationController as? FluidResizable)?.fluidResizableDelegate
        case is FluidDestinationViewController:
            rootNavigationController = destination?.navigationController as? FluidNavigationController
            rootNavigationControllerDelegate = rootNavigationController?.fluidDelegate as? RootNavigationControllerDelegate
            destinationViewController = rootNavigationController?.viewControllers.last as? FluidDestinationViewController ?? destination as? FluidDestinationViewController
            destinationViewControllerDelegate = destinationViewController?.fluidDelegate as? DestinationViewControllerDelegate
//            destinationResizableDelegate = (destinationViewController as? FluidResizable)?.fluidResizableDelegate
        default:
            break
        }
        transitioningDelegate = (rootNavigationController?.transitioningDelegate as? FluidViewControllerTransitioningDelegate)
                                ?? (destinationViewController.transitioningDelegate as? FluidViewControllerTransitioningDelegate)
        destinationResizableDelegate = (rootNavigationController as? FluidResizable)?.fluidResizableDelegate
                                       ?? (destinationViewController as? FluidResizable)?.fluidResizableDelegate

        let sourceView: UIView! = sourceViewController.view
        let destinationView: UIView! = destinationViewController.view

        let allowInteractivePresent: Bool = {
            return sourceViewControllerDelegate
                    .transitionAllowsInteractivePresent(from: sourceViewController, to: destinationViewController,
                                                        with: rootNavigationController)
        }()
        let allowInteractiveDismiss: Bool = {
            return destinationViewControllerDelegate
                    .transitionAllowsInteractiveDismiss(from: destinationViewController,
                                                        to: sourceViewController, with: rootNavigationController)
        }()
        let allowDismissFromChild: Bool = {
            return destinationViewControllerDelegate
                    .transitionAllowsDismissFromChildViewControllers(from: destinationViewController, to: sourceViewController,
                                                                     with: rootNavigationController)
        }()

        let allowDismissWhenTapBackground: Bool = destinationViewControllerDelegate.transitionAllowsDismissWhenTapBackground(from: destinationViewController, to: sourceViewController, with: rootNavigationController)
//        let sourceShouldNotifyUpdateState: Bool = sourceViewControllerDelegate.transitionShouldNotifyUpdateState()
//        let destinationShouldNotifyUpdateState: Bool = destinationViewControllerDelegate.transitionShouldNotifyUpdateState()

        let transitionStyle: FluidTransitionStyle = {
            return sourceViewControllerDelegate
                    .transitionPresentationStyle(from: sourceViewController, to: destinationViewController,
                                                 with: rootNavigationController)
        }()
        let presentationStyle: FluidPresentationStyle = .init(fromTransition: transitionStyle)
        let backgroundStyle: FluidBackgroundStyle = {
            return sourceViewControllerDelegate
                    .transitionBackgroundStyle(from: sourceViewController, to: destinationViewController,
                                               with: rootNavigationController)
        }()
        let interactionType: FluidDriverInteractionType = .init(for: presentationStyle, with: animationType)

        let initialContainerSize: CGSize = initialContainerSize ?? container.frame.size
        let finalContainerSize: CGSize = finalContainerSize ?? container.frame.size

        let finalDimension: FluidFinalFrameDimension = {
            var finalDimension: FluidFinalFrameDimension
                    = sourceViewControllerDelegate.transitionFinalDestinationFrameDimension(from: sourceViewController,
                                                                                            to: destinationViewController,
                                                                                            with: rootNavigationController) ?? FluidFinalFrameDimension()
            finalDimension = finalDimension.validate(for: presentationStyle, containerSize: finalContainerSize)
            return finalDimension
        }()
        let initialDimension: FluidInitialFrameDimension = {
            var initialDimension: FluidInitialFrameDimension
                    = sourceViewControllerDelegate.transitionInitialDestinationFrameDimension(from: sourceViewController,
                                                                                              to: destinationViewController,
                                                                                              with: rootNavigationController) ?? FluidInitialFrameDimension()
            initialDimension = initialDimension.validate(for: presentationStyle, finalDimension: finalDimension, containerSize: initialContainerSize)
            return initialDimension
        }()

        let finalStyle: FluidFinalFrameStyle = {
            var style: FluidFinalFrameStyle
                    = sourceViewControllerDelegate.transitionFinalDestinationFrameStyle(from: sourceViewController,
                                                                                        to: destinationViewController,
                                                                                        with: rootNavigationController) ?? FluidFinalFrameStyle()
            style = style.validate(for: presentationStyle)
            return style
        }()
        let initialStyle: FluidInitialFrameStyle = {
            var initialStyle: FluidInitialFrameStyle
                    = sourceViewControllerDelegate.transitionInitialDestinationFrameStyle(from: sourceViewController,
                                                                                          to: destinationViewController,
                                                                                          with: rootNavigationController) ?? FluidInitialFrameStyle()
            initialStyle = initialStyle.validate(for: presentationStyle, finalFrameStyle: finalStyle)
            return initialStyle
        }()

        let presentEasing: FluidAnimatorEasing = {
            let easing: FluidAnimatorEasing = {
                if let easing: FluidAnimatorEasing = sourceViewControllerDelegate
                        .transitionPresentEasing(from: sourceViewController, to: destinationViewController,
                                                 with: rootNavigationController) { return easing }
                return presentationStyle.defaultPresentEasing
            }()
            return easing
        }()
        let dismissEasing: FluidAnimatorEasing = {
            let easing: FluidAnimatorEasing = {
                if let easing: FluidAnimatorEasing = sourceViewControllerDelegate
                        .transitionDismissEasing(from: destinationViewController, to: sourceViewController,
                                                 with: rootNavigationController) { return easing }
                return presentationStyle.defaultDismissEasing
            }()
            return easing
        }()

        let presentDuration: TimeInterval = {
            switch presentEasing {
            case .spring:
                let initialFrame: CGRect = initialDimension.frame()
                let finalFrame: CGRect = finalDimension.frame(for: finalContainerSize)
                return presentEasing.defaultDuration(initialFrame, finalFrame, isPresenting: true)
            default:
                if let duration: TimeInterval = sourceViewControllerDelegate
                        .transitionPresentDuration(from: sourceViewController, to: destinationViewController,
                                                   with: rootNavigationController) { return duration }
                let initialFrame: CGRect = initialDimension.frame()
                let finalFrame: CGRect = finalDimension.frame(for: finalContainerSize)
                return presentEasing.defaultDuration(initialFrame, finalFrame, isPresenting: true)
            }
        }()
        let dismissDuration: TimeInterval = {
            switch dismissEasing {
            case .spring:
                let initialFrame: CGRect = initialDimension.frame()
                let finalFrame: CGRect = finalDimension.frame(for: finalContainerSize)
                return dismissEasing.defaultDuration(initialFrame, finalFrame, isPresenting: false)
            default:
                if let duration: TimeInterval = sourceViewControllerDelegate
                        .transitionDismissDuration(from: destinationViewController, to: sourceViewController,
                                                   with: rootNavigationController) { return duration }
                let initialFrame: CGRect = initialDimension.frame()
                let finalFrame: CGRect = finalDimension.frame(for: finalContainerSize)
                return dismissEasing.defaultDuration(initialFrame, finalFrame, isPresenting: false)
            }
        }()

        let activeDuration: TimeInterval = {
            switch animationType {
            case .present: return duration ?? presentDuration
            case .dismiss: return duration ?? dismissDuration
            case .rotate:  return duration ?? FluidConst.defaultDismissDuration
            }
        }()
        let activeEasing: FluidAnimatorEasing = {
            switch animationType {
            case .present: return easing ?? presentEasing
            case .dismiss: return easing ?? dismissEasing
            case .rotate:  return easing ?? .linear
            }
        }()

        var shouldPerformResizing: Bool = {
            guard let delegate: FluidResizableTransitionDelegate = destinationResizableDelegate else { return false }
            return delegate.transitionShouldPerformResizing()
        }()
        let minimumMarginForResizing: CGFloat = {
            guard shouldPerformResizing, let delegate: FluidResizableTransitionDelegate = destinationResizableDelegate else { return 0 }
            return delegate.transitionMinimumMarginForResizing()
        }()
        let snapPositionsForResizing: [CGFloat] = {
            guard shouldPerformResizing, let delegate: FluidResizableTransitionDelegate = destinationResizableDelegate else { return [0.0] }
            guard var positions: [CGFloat] = delegate.transitionSnapPositionsForResizing() else { return [0.0, 1.0] }
            positions.removeAll(where: { $0 < 0.0 || 1.0 < $0 })
            positions.sort()
            if !positions.contains(0.0) { positions.insert(0.0, at: 0) }
            if !positions.contains(1.0) { positions.append(1.0) }
            return positions
        }()

        let finalFrameSize: CGSize = finalDimension.frame(for: finalContainerSize).size
        let baseConstantForResizing: CGFloat = {
            guard let drawerPosition: FluidDrawerPosition = presentationStyle.drawerPosition else { return minimumMarginForResizing }
            switch drawerPosition {
            case .top:    return -(finalContainerSize.height - finalFrameSize.height)
            case .bottom: return finalContainerSize.height - finalFrameSize.height
            case .left:   return -(finalContainerSize.width - finalFrameSize.width)
            case .right:  return finalContainerSize.width - finalFrameSize.width
            }
        }()
        var expandedConstantForResizing: CGFloat = {
            guard let drawerPosition: FluidDrawerPosition = presentationStyle.drawerPosition else { return minimumMarginForResizing }
            switch drawerPosition {
            case .top, .left:     return -minimumMarginForResizing
            case .bottom, .right: return minimumMarginForResizing
            }
        }()
        if expandedConstantForResizing > baseConstantForResizing {
            expandedConstantForResizing = baseConstantForResizing
            shouldPerformResizing = false
        }
        let constantRangeForResizing: CGFloat = {
            guard let drawerPosition: FluidDrawerPosition = presentationStyle.drawerPosition else { return 0 }
            switch drawerPosition {
            case .top:    return baseConstantForResizing - expandedConstantForResizing
            case .bottom: return baseConstantForResizing - expandedConstantForResizing
            case .left:   return baseConstantForResizing - expandedConstantForResizing
            case .right:  return baseConstantForResizing - expandedConstantForResizing
            }
        }()
//        Logger()?.log("🥈🛠", [
//            "shouldPerformResizing: " + String(debug: shouldPerformResizing),
//            "minimumMarginForResizing: " + String(debug: minimumMarginForResizing),
//            "snapPositionsForResizing: " + String(debug: snapPositionsForResizing),
//            "finalFrameSize: " + String(debug: finalFrameSize),
//            "expandedConstantForResizing: " + String(debug: expandedConstantForResizing),
//            "baseConstantForResizing: " + String(debug: baseConstantForResizing),
//            "constantRangeForResizing: " + String(debug: constantRangeForResizing),
//        ])

        let shouldCastShadow: Bool = {
            let hasShadowColor: Bool = initialStyle.shadowColor != UIColor.clear.cgColor && finalStyle.shadowColor != UIColor.clear.cgColor
            let hasShadowOpacity: Bool = initialStyle.shadowOpacity > 0 || finalStyle.shadowOpacity > 0
            return hasShadowColor && hasShadowOpacity
        }()
        let shouldMaskCorner: Bool = {
            let hasCornerRadius: Bool = initialStyle.cornerRadius > 0 || finalStyle.cornerRadius > 0
            return hasCornerRadius
        }()

        /* NOTE: Assign variables */
        self.driverType = driverType
        self.animationType = animationType
        self.interactionType = interactionType

        self.context = context

        self.sourceViewController = sourceViewController
        self.rootNavigationController = rootNavigationController
        self.destinationViewController = destinationViewController
        self.sourceViewControllerDelegate = sourceViewControllerDelegate
        self.rootNavigationControllerDelegate = rootNavigationControllerDelegate
        self.destinationViewControllerDelegate = destinationViewControllerDelegate
        self.destinationResizableDelegate = destinationResizableDelegate

        self.controllerDelegate = transitioningDelegate

        self.containerView = container
        self.sourceView = sourceView
        self.destinationView = destinationView

        self.allowInteractivePresent = allowInteractivePresent
        self.allowInteractiveDismiss = allowInteractiveDismiss

//        self.sourceShouldNotifyUpdateState = sourceShouldNotifyUpdateState
//        self.destinationShouldNotifyUpdateState = destinationShouldNotifyUpdateState

        self.allowDismissFromChild = allowDismissFromChild
        self.allowDismissWhenTapBackground = allowDismissWhenTapBackground

        self.presentationStyle = presentationStyle
        self.backgroundStyle = backgroundStyle

        self.presentEasing = presentEasing
        self.dismissEasing = dismissEasing

        self.presentDuration = presentDuration
        self.dismissDuration = dismissDuration

        self.initialContainerSize = initialContainerSize
        self.finalContainerSize = finalContainerSize

        self.initialDimension = initialDimension
        self.finalDimension = finalDimension

        self.initialStyle = initialStyle
        self.finalStyle = finalStyle

        self.shouldPerformResizing = shouldPerformResizing
        self.minimumMarginForResizing = minimumMarginForResizing
        self.snapPositionsForResizing = snapPositionsForResizing

        self.expandedConstantForResizing = expandedConstantForResizing
        self.baseConstantForResizing = baseConstantForResizing
        self.constantRangeForResizing = constantRangeForResizing

        self.shouldCastShadow = shouldCastShadow
        self.shouldMaskCorner = shouldMaskCorner

        self.activeDuration = activeDuration
        self.activeEasing = activeEasing
    }

//    mutating func configureViews(animationView: UIView, shadowView: FluidShadowView?, backgroundView: FluidBackgroundCompatible?, layout: FluidLayout) {
    mutating func configureViews(shouldInsertSubview: Bool) {
        Logger()?.log("🥈🛠", [
//            "shouldInsertSubview: " + String(describing: shouldInsertSubview),
//            "rootNavigationController?.visibleViewController: " + String(describing: rootNavigationController?.visibleViewController),
//            "rootNavigationController: " + String(describing: rootNavigationController),
//            "rootNavigationController?.view: " + String(describing: rootNavigationController?.view),
//            "destinationViewController: " + String(describing: destinationViewController),
//            "destinationViewController.view: " + String(describing: destinationViewController.view),
        ])
        let animationView: UIView = rootNavigationController?.view ?? destinationViewController.view
        if shouldInsertSubview && animationView.superview == nil {
            animationView.translatesAutoresizingMaskIntoConstraints = false /* NOTE: Prevent 'UIView-Encapsulated-Layout' from being generated automatically */
            animationView.alpha = 0
            self.containerView.insertSubview(animationView, aboveSubview: sourceView)
        }
        let backgroundView: FluidBackgroundCompatible? = {
            if let backgroundView: FluidBackgroundCompatible = self.containerView.viewWithTag(FluidConst.backgroundViewTag) as? FluidBackgroundCompatible {
                return backgroundView
            } else {
                switch backgroundStyle {
                case .blur(let radius, let color, let alpha):
                    let backgroundView: FluidBlurredBackgroundView = .init(radius: radius, color: color, alpha: alpha)
                    if shouldInsertSubview { self.containerView.insertSubview(backgroundView, belowSubview: animationView) }
                    return backgroundView
                case .dim(let color):
                    let backgroundView: FluidDimmedBackgroundView = .init(color: color)
                    if shouldInsertSubview { self.containerView.insertSubview(backgroundView, belowSubview: animationView) }
                    return backgroundView
                case .none:
                    return nil
                }
            }
        }()
        let shadowView: FluidShadowView? = {
            guard shouldCastShadow else { return nil }
            if let shadowView: FluidShadowView = self.containerView.viewWithTag(FluidConst.shadowViewTag) as? FluidShadowView {
                return shadowView
            } else {
                let shadowView: FluidShadowView = .init(shadowCornerRadius: finalStyle.cornerRadius, shadowRoundingCorners: finalStyle.roundingCorners,
                                                        shadowOpacity: finalStyle.shadowOpacity, shadowColor: finalStyle.shadowColor,
                                                        shadowRadius: finalStyle.shadowRadius, shadowOffset: finalStyle.shadowOffset,
                                                        isTransparentBackground: finalStyle.isTransparentBackground)
                if shouldInsertSubview { self.containerView.insertSubview(shadowView, belowSubview: animationView) }
                return shadowView
            }
        }()
        var layout: FluidLayout = .init(for: presentationStyle, presentationType: .transition,
                                        container: self.containerView, content: animationView,
                                        containerSize: finalContainerSize, contentSize: finalDimension.frame(for: finalContainerSize).size)
        layout.activate(type: .transition)
        self.animationView = animationView
        self.backgroundView = backgroundView
        self.shadowView = shadowView
        self.layout = layout
    }
}

extension FluidTransitionParameters {
    func extraSourceAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible] {
        switch self.animationType {
        case .present:
            return self.sourceViewControllerDelegate.transitionAdditionalPresentAnimations(from: sourceViewController, to: destinationViewController,
                                                                                           with: rootNavigationController, on: self.containerView,
                                                                                           initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                           initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                           transitionStyle: self.presentationStyle.toTransitionStyle(),
                                                                                           duration: presentDuration, easing: presentEasing) ?? []
        case .dismiss:
            return self.sourceViewControllerDelegate.transitionAdditionalDismissAnimations(from: destinationViewController, to: sourceViewController,
                                                                                           with: rootNavigationController, on: self.containerView,
                                                                                           initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                           initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                           transitionStyle: self.presentationStyle.toTransitionStyle(),
                                                                                           duration: dismissDuration, easing: dismissEasing) ?? []
        case .rotate:
            return []
        }
    }

    func extraDestinationAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible] {
        switch self.animationType {
        case .present:
            return self.destinationViewControllerDelegate.transitionAdditionalPresentAnimations(from: sourceViewController, to: destinationViewController,
                                                                                                with: rootNavigationController, on: self.containerView,
                                                                                                initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                                initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                                transitionStyle: self.presentationStyle.toTransitionStyle(),
                                                                                                duration: presentDuration, easing: presentEasing) ?? []
        case .dismiss:
            return self.destinationViewControllerDelegate.transitionAdditionalDismissAnimations(from: destinationViewController, to: sourceViewController,
                                                                                                with: rootNavigationController, on: self.containerView,
                                                                                                initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                                initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                                transitionStyle: self.presentationStyle.toTransitionStyle(),
                                                                                                duration: dismissDuration, easing: dismissEasing) ?? []
        case .rotate:
            return []
        }
    }
}
