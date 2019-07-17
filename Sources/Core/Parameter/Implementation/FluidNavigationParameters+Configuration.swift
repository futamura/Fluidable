//
//  FluidNavigationParameters+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal extension FluidNavigationParameters {
    init(driverType: FluidDriverType, animationType: FluidAnimationType,
         context: UIViewControllerContextTransitioning?,
         container: UIView, source: UIViewController?, destination: UIViewController?,
         initialContainerSize: CGSize? = nil, finalContainerSize: CGSize? = nil,
         duration: TimeInterval? = nil, easing: FluidAnimatorEasing? = nil) {
        Logger()?.log("🥇🛠", [
//            "driverType:" + String(debug: driverType),
//            "animationType:" + String(debug: animationType),
//            "context:" + String(debug: context),
//            "container:" + String(debug: container),
//            "source:" + String(debug: source),
//            "destination:" + String(debug: destination),
//            "initialContainerSize:" + String(debug: initialContainerSize),
//            "finalContainerSize:" + String(debug: finalContainerSize),
//            "duration:" + String(debug: duration),
//            "easing:" + String(debug: easing),
        ])
        /* NOTE: Predefine variables */
        var navigationDelegate: ControllerDelegate?
        var rootNavigationController: FluidNavigationController?
        var sourceViewController: FluidSourceViewController!
        var destinationViewController: FluidDestinationViewController!
        var rootNavigationControllerDelegate: RootNavigationControllerDelegate?
        var sourceViewControllerDelegate: SourceViewControllerDelegate!
        var destinationViewControllerDelegate: DestinationViewControllerDelegate!
        let destinationResizableDelegate: FluidResizableTransitionDelegate? = nil

        /* NOTE: Controllers and delegates */
        switch source {
        case is FluidSourceViewController:
            sourceViewController = source as? FluidSourceViewController
            sourceViewControllerDelegate = sourceViewController?.fluidDelegate as? SourceViewControllerDelegate
            rootNavigationController = sourceViewController?.navigationController as? FluidNavigationController
            rootNavigationControllerDelegate = rootNavigationController?.fluidDelegate as? RootNavigationControllerDelegate
            navigationDelegate = rootNavigationController?.delegate as? ControllerDelegate
        default:
            break
        }
        switch destination {
        case is FluidSourceViewController:
            destinationViewController = destination as? FluidSourceViewController
            destinationViewControllerDelegate = destinationViewController?.fluidDelegate as? DestinationViewControllerDelegate
        default:
            break
        }

        /* NOTE: Views */
        let sourceView: UIView! = sourceViewController.view
        let destinationView: UIView! = destinationViewController.view

        /* NOTE: Conditions */
        let allowInteractivePresent: Bool = {
            return sourceViewControllerDelegate
                    .navigationAllowsInteractivePresent(from: sourceViewController, to: destinationViewController,
                                                        with: rootNavigationController)
        }()
        let allowInteractiveDismiss: Bool = {
            return destinationViewControllerDelegate
                    .navigationAllowsInteractiveDismiss(from: destinationViewController,
                                                        to: sourceViewController, with: rootNavigationController)
        }()
        let allowDismissFromChild: Bool = false
        let allowDismissWhenTapBackground: Bool = false
//        let sourceShouldNotifyUpdateState: Bool = sourceViewControllerDelegate.navigationShouldNotifyUpdateState()
//        let destinationShouldNotifyUpdateState: Bool = destinationViewControllerDelegate.navigationShouldNotifyUpdateState()

        /* NOTE: Styles */
        let navigationStyle: FluidNavigationStyle = {
            return sourceViewControllerDelegate
                    .navigationPresentationStyle(from: sourceViewController, to: destinationViewController,
                                                 with: rootNavigationController)
        }()
        let presentationStyle: FluidPresentationStyle = .init(fromNavigation: navigationStyle)
        let backgroundStyle: FluidBackgroundStyle = {
            return sourceViewControllerDelegate
                    .navigationBackgroundStyle(from: sourceViewController, to: destinationViewController,
                                               with: rootNavigationController)
        }()
        let interactionType: FluidDriverInteractionType = .init(for: presentationStyle, with: animationType)

        /* NOTE: Dimensions */
        let initialContainerSize: CGSize = initialContainerSize ?? container.frame.size
        let finalContainerSize: CGSize = finalContainerSize ?? container.frame.size

        let finalDimension: FluidFinalFrameDimension = {
            var finalDimension: FluidFinalFrameDimension
                    = sourceViewControllerDelegate.navigationFinalDestinationFrameDimension(from: sourceViewController,
                                                                                            to: destinationViewController,
                                                                                            with: rootNavigationController) ?? FluidFinalFrameDimension()
            finalDimension = finalDimension.validate(for: presentationStyle, containerSize: finalContainerSize)
            return finalDimension
        }()
        let initialDimension: FluidInitialFrameDimension = {
            var initialDimension: FluidInitialFrameDimension
                    = sourceViewControllerDelegate.navigationInitialDestinationFrameDimension(from: sourceViewController,
                                                                                              to: destinationViewController,
                                                                                              with: rootNavigationController) ?? FluidInitialFrameDimension()
            initialDimension = initialDimension.validate(for: presentationStyle, finalDimension: finalDimension, containerSize: finalContainerSize)
            return initialDimension
        }()

        let finalStyle: FluidFinalFrameStyle = {
            var style: FluidFinalFrameStyle
                    = sourceViewControllerDelegate.navigationFinalDestinationFrameStyle(from: sourceViewController,
                                                                                        to: destinationViewController,
                                                                                        with: rootNavigationController) ?? FluidFinalFrameStyle()
            style = style.validate(for: presentationStyle)
            return style
        }()
        let initialStyle: FluidInitialFrameStyle = {
            var initialStyle: FluidInitialFrameStyle
                    = sourceViewControllerDelegate.navigationInitialDestinationFrameStyle(from: sourceViewController,
                                                                                          to: destinationViewController,
                                                                                          with: rootNavigationController) ?? FluidInitialFrameStyle()
            initialStyle = initialStyle.validate(for: presentationStyle, finalFrameStyle: finalStyle)
            return initialStyle
        }()

        /* NOTE: Animations */
        let presentEasing: FluidAnimatorEasing = {
            let easing: FluidAnimatorEasing = {
                if let easing: FluidAnimatorEasing = sourceViewControllerDelegate
                        .navigationPresentEasing(from: sourceViewController, to: destinationViewController,
                                                 with: rootNavigationController) { return easing }
                return presentationStyle.defaultPresentEasing
            }()
            return easing
        }()
        let dismissEasing: FluidAnimatorEasing = {
            let easing: FluidAnimatorEasing = {
                if let easing: FluidAnimatorEasing = sourceViewControllerDelegate
                        .navigationDismissEasing(from: destinationViewController, to: sourceViewController,
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
                        .navigationPresentDuration(from: sourceViewController, to: destinationViewController,
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
                        .navigationDismissDuration(from: destinationViewController, to: sourceViewController,
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

        let shouldPerformResizing: Bool = false
        let minimumMarginForResizing: CGFloat = 0
        let snapPositionsForResizing: [CGFloat] = []

        let expandedConstantForResizing: CGFloat = 0
        let baseConstantForResizing: CGFloat = 0
        let constantRangeForResizing: CGFloat = 0

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

        self.rootNavigationController = rootNavigationController
        self.sourceViewController = sourceViewController
        self.destinationViewController = destinationViewController

        self.rootNavigationControllerDelegate = rootNavigationControllerDelegate
        self.sourceViewControllerDelegate = sourceViewControllerDelegate
        self.destinationViewControllerDelegate = destinationViewControllerDelegate

        self.destinationResizableDelegate = destinationResizableDelegate

        self.controllerDelegate = navigationDelegate

        self.transitionContainerView = container
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

    mutating func configureViews(shouldInsertSubview: Bool) {
        Logger()?.log("🥇🛠", [
        ])
        let layoutContainerView: UIView! = destinationViewController.view
        if shouldInsertSubview, sourceView.superview == nil {
            self.transitionContainerView.insertSubview(sourceView, belowSubview: layoutContainerView)
        }
        if shouldInsertSubview, layoutContainerView.superview == nil {
            layoutContainerView.alpha = 0
            self.transitionContainerView.insertSubview(layoutContainerView, aboveSubview: sourceView)
        }
        let backgroundView: FluidBackgroundCompatible? = {
            if let backgroundView: FluidBackgroundCompatible = self.transitionContainerView.viewWithTag(FluidConst.backgroundViewTag) as? FluidBackgroundCompatible {
                return backgroundView
            } else {
                switch backgroundStyle {
                case .blur(let radius, let color, let alpha):
                    let backgroundView: FluidBlurredBackgroundView = .init(radius: radius, color: color, alpha: alpha)
                    if shouldInsertSubview { self.transitionContainerView.insertSubview(backgroundView, belowSubview: layoutContainerView) }
                    return backgroundView
                case .dim(let color):
                    let backgroundView: FluidDimmedBackgroundView = .init(color: color)
                    if shouldInsertSubview { self.transitionContainerView.insertSubview(backgroundView, belowSubview: layoutContainerView) }
                    return backgroundView
                case .none:
                    return nil
                }
            }
        }()
        let shadowView: FluidShadowView? = {
            guard shouldCastShadow else { return nil }
            if let shadowView: FluidShadowView = self.transitionContainerView.viewWithTag(FluidConst.shadowViewTag) as? FluidShadowView {
                return shadowView
            } else {
                let shadowView: FluidShadowView = .init(shadowCornerRadius: finalStyle.cornerRadius, shadowRoundingCorners: finalStyle.roundingCorners,
                                                        shadowOpacity: finalStyle.shadowOpacity, shadowColor: finalStyle.shadowColor,
                                                        shadowRadius: finalStyle.shadowRadius, shadowOffset: finalStyle.shadowOffset,
                                                        isTransparentBackground: finalStyle.isTransparentBackground)
                if shouldInsertSubview { self.transitionContainerView.insertSubview(shadowView, belowSubview: layoutContainerView) }
                return shadowView
            }
        }()
        var layout: FluidLayout = .init(for: presentationStyle, presentationType: .navigation,
                                        container: self.transitionContainerView, content: layoutContainerView,
                                        containerSize: finalContainerSize, contentSize: finalDimension.frame(for: finalContainerSize).size)
        layout.activate(type: .navigation)
        self.layoutContainerView = layoutContainerView
        self.backgroundView = backgroundView
        self.shadowView = shadowView
        self.layout = layout
    }
}

extension FluidNavigationParameters {
    func extraSourceAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible] {
        switch self.animationType {
        case .present:
            return self.sourceViewControllerDelegate.navigationAdditionalPresentAnimations(from: sourceViewController, to: destinationViewController,
                                                                                           with: rootNavigationController, on: self.transitionContainerView,
                                                                                           initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                           initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                           navigationStyle: self.presentationStyle.toNavigationStyle(),
                                                                                           duration: presentDuration, easing: presentEasing) ?? []
        case .dismiss:
            return self.sourceViewControllerDelegate.navigationAdditionalDismissAnimations(from: destinationViewController, to: sourceViewController,
                                                                                           with: rootNavigationController, on: self.transitionContainerView,
                                                                                           initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                           initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                           navigationStyle: self.presentationStyle.toNavigationStyle(),
                                                                                           duration: dismissDuration, easing: dismissEasing) ?? []
        case .rotate:
            return []
        }
    }

    func extraDestinationAnimators(_ isReversed: Bool) -> [FluidAnimatorCompatible] {
        switch self.animationType {
        case .present:
            return self.destinationViewControllerDelegate.navigationAdditionalPresentAnimations(from: sourceViewController, to: destinationViewController,
                                                                                                with: rootNavigationController, on: self.transitionContainerView,
                                                                                                initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                                initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                                navigationStyle: self.presentationStyle.toNavigationStyle(),
                                                                                                duration: presentDuration, easing: presentEasing) ?? []
        case .dismiss:
            return self.destinationViewControllerDelegate.navigationAdditionalDismissAnimations(from: destinationViewController, to: sourceViewController,
                                                                                                with: rootNavigationController, on: self.transitionContainerView,
                                                                                                initialDimension: initialDimension, finalDimension: finalDimension,
                                                                                                initialStyle: initialStyle, finalStyle: finalStyle,
                                                                                                navigationStyle: self.presentationStyle.toNavigationStyle(),
                                                                                                duration: dismissDuration, easing: dismissEasing) ?? []
        case .rotate:  return []
        }
    }
}
