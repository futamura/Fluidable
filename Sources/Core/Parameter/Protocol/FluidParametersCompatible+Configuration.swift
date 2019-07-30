//
//  FluidParametersCompatible+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/*
 * NOTE: Configuration
 */
extension FluidParametersCompatible {
    mutating func configureInterruptibleAnimator(interruptibleAnimator: FluidInterruptibleAnimator, interruptibleView: FluidInterruptibleView) {
        self.interruptibleAnimator = interruptibleAnimator
        self.interruptibleView = interruptibleView
    }

    mutating func configureProgressAnimator(progressView: FluidProgressView?, progressAnimator: FluidCoreAnimator?,
                                            progressBlock: FluidAnimatorCompatible.ProgressBlock?, stateBlock: FluidAnimatorCompatible.StateBlock?) {
        self.progressView = progressView
        self.progressAnimator = progressAnimator
        self.progressBlock = progressBlock
        self.stateBlock = stateBlock
    }

    mutating func configureBackgroundAnimator(backgroundAnimator: FluidPropertyAnimator?) {
        self.backgroundAnimator = backgroundAnimator
    }

    mutating func configureFrameAnimator(frameAnimators: [FluidAnimatorCompatible]) {
        let framePropertyAnimator: [FluidPropertyAnimator] = frameAnimators.lazy.filter { $0 is FluidPropertyAnimator }.map { ($0 as! FluidPropertyAnimator ) }
        let frameCoreAnimator: [FluidCoreAnimator] = frameAnimators.lazy.filter { $0 is FluidCoreAnimator }.map { $0 as! FluidCoreAnimator }
        self.framePropertyAnimators = framePropertyAnimator
        self.frameCoreAnimators = frameCoreAnimator
    }

    mutating func configureExtraAnimators(sourceAnimators: [FluidAnimatorCompatible]?, destinationAnimators: [FluidAnimatorCompatible]?) {
        let sourcePropertyAnimators: [FluidPropertyAnimator] = (sourceAnimators ?? []).lazy.filter { $0 is FluidPropertyAnimator }.map { $0 as! FluidPropertyAnimator }
        let sourceCoreAnimators: [FluidCoreAnimator] = (sourceAnimators ?? []).lazy.filter { $0 is FluidCoreAnimator }.map { $0 as! FluidCoreAnimator }
        let destinationPropertyAnimators: [FluidPropertyAnimator] = (destinationAnimators ?? []).lazy.filter { $0 is FluidPropertyAnimator }.map { $0 as! FluidPropertyAnimator }
        let destinationCoreAnimators: [FluidCoreAnimator] = (destinationAnimators ?? []).lazy.filter { $0 is FluidCoreAnimator }.map { $0 as! FluidCoreAnimator }
        self.extraPropertyAnimators = sourcePropertyAnimators + destinationPropertyAnimators
        self.extraCoreAnimators = sourceCoreAnimators + destinationCoreAnimators
    }

    func invalidateAllAnimations() {
        self.interruptibleAnimator?.invalidate()
        self.progressAnimator?.invalidate()
        self.backgroundAnimator?.invalidate()
        self.framePropertyAnimators?.forEach { $0.invalidate() }
        self.frameCoreAnimators?.forEach { $0.invalidate() }
        self.extraPropertyAnimators?.forEach { $0.invalidate() }
        self.extraCoreAnimators?.forEach { $0.invalidate() }
    }
}

/*
 * NOTE: Validation
 */
extension FluidParametersCompatible {
    func validatePresentEasing() throws {
        let easing: FluidAnimatorEasing = self.presentEasing
        if !easing.isAvailable { throw FluidError.unsupportedPresentationEasing(easing: easing) }
    }

    func validateDismissEasing() throws {
        let easing: FluidAnimatorEasing = self.dismissEasing
        if !easing.isAvailable { throw FluidError.unsupportedDismissalEasing(easing: easing) }
    }

    func validatePresentDuration() throws {
        let easing: FluidAnimatorEasing = self.presentEasing
        switch easing {
        case .spring:
            let userDefinedDuration: TimeInterval = self.presentDuration
            let initialDimension: FluidInitialFrameDimension = self.initialDimension
            let finalDimension: FluidFinalFrameDimension = self.finalDimension
            let initialFrame: CGRect = initialDimension.frame()
            let finalFrame: CGRect = finalDimension.frame(for: self.transitionContainerView.frame.size)
            let defaultDuration: TimeInterval = easing.defaultDuration(initialFrame, finalFrame, isPresenting: true)
            throw FluidError.ignoredPresentationDuration(easing: easing, defaultDuration: defaultDuration,
                                                         userDefinedDuration: userDefinedDuration)

        default:
            break
        }
    }

    func validateDismissDuration() throws {
        let easing: FluidAnimatorEasing = self.dismissEasing
        switch easing {
        case .spring:
            let userDefinedDuration: TimeInterval = self.dismissDuration
            let initialDimension: FluidInitialFrameDimension = self.initialDimension
            let finalDimension: FluidFinalFrameDimension = self.finalDimension
            let initialFrame: CGRect = initialDimension.frame()
            let finalFrame: CGRect = finalDimension.frame(for: self.transitionContainerView.frame.size)
            let defaultDuration: TimeInterval = easing.defaultDuration(initialFrame, finalFrame, isPresenting: false)
            throw FluidError.ignoredPresentationDuration(easing: easing, defaultDuration: defaultDuration,
                                                         userDefinedDuration: userDefinedDuration)
        default:
            break
        }
    }

    func validateResizing() throws {
        /* IMPORTANT: The resizing interaction is available for only the bottom drawer on the current version */
        guard let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition else { return }
        if self.shouldPerformResizing && !drawerPosition.isBottom { throw FluidError.invalidResizeConfiguration }
    }

    func validateParameters() throws {
        if !self.hasValidReference() { throw FluidError.invalidReference }
        try? self.validateResizing()
    }

    func hasValidReference() -> Bool {
        return self.sourceViewControllerDelegate != nil && self.destinationViewControllerDelegate != nil &&
               self.sourceViewController != nil && self.destinationViewController != nil
    }
}
