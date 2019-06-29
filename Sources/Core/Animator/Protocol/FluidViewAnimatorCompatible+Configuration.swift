//
//  FluidViewAnimatorCompatible+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 Configuring animations
 */
extension FluidViewAnimatorCompatible {
    @discardableResult
    func registerParameters<T: FluidParametersCompatible>(parameters: T) -> Self {
        self.parameters = parameters as? Parameters
        return self
    }
}

extension FluidViewAnimatorCompatible {
    /**
     The function that configures the interruptible animation.

     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    internal func configureInterruptibleAnimator(completion: @escaping FluidInterruptibleAnimator.CompletionBlock) -> Self {
        Logger()?.log("🕊🛠", [
        ])
        let interruptibleView: FluidInterruptibleView = {
            let view: FluidInterruptibleView = self.createInterruptibleViewIfNeeded()
            view.alpha = 0
            return view
        }()
        let interruptibleAnimator: FluidInterruptibleAnimator = .init(duration: self.activeDuration, timingParameters: self.activeEasing.timingParameters, id: "interruptibleAnimator")
//        let interruptibleAnimator: FluidInterruptibleAnimator = .init(duration: self.activeDuration, timingParameters: FluidAnimatorEasing.linear.timingParameters, id: "interruptibleAnimator")
        interruptibleAnimator.addAnimations({ [weak self] in
            self?.interruptibleView?.alpha = 1
        })
        interruptibleAnimator.addCompletion(completion)
        self.parameters.configureInterruptibleAnimator(interruptibleAnimator: interruptibleAnimator, interruptibleView: interruptibleView)
        return self
    }

    /**
     The function that configures the frame animation.

     - parameter isReversed: The `Bool` value that indicates whether the animation should be reversed.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    internal func configureTransitionAnimators(isReversed: Bool, from: CGFloat, to: CGFloat,
                                               progress progressBlock: FluidAnimatorCompatible.ProgressBlock? = nil,
                                               state stateBlock: FluidAnimatorCompatible.StateBlock? = nil) -> Self {
        Logger()?.log("🕊🛠", [
        ])
        return self.configureFrameAnimators(isReversed: isReversed)
                   .configureBackgroundAnimator(isReversed: isReversed)
                   .configureExtraAnimators(isReversed: isReversed)
                   .configureProgressAnimator(isReversed: isReversed, from: from, to: to, progress: progressBlock, state: stateBlock)
    }
}

extension FluidViewAnimatorCompatible {
    /**
     The function that configures the frame animation.

     - parameter isReversed: The `Bool` value that indicates whether the animation should be reversed.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    private func configureFrameAnimators(isReversed: Bool) -> Self {
        Logger()?.log("🕊🛠", [
        ])
        let frameAnimators: [FluidAnimatorCompatible] = self.animationWillStart(isReversed: isReversed) ?? []
        self.parameters.configureFrameAnimator(frameAnimators: frameAnimators)
        return self
    }

    /**
     The function that configures the extra animation.

     - parameter isReversed: The `Bool` value that indicates whether the animation should be reversed.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    private func configureExtraAnimators(isReversed: Bool) -> Self {
        Logger()?.log("🕊🛠", [
        ])
        let sourceAnimators: [FluidAnimatorCompatible]? = isReversed ? nil : self.parameters.extraSourceAnimators(isReversed)
        let destinationAnimators: [FluidAnimatorCompatible]? = isReversed ? nil : self.parameters.extraDestinationAnimators(isReversed)
        self.parameters.configureExtraAnimators(sourceAnimators: sourceAnimators, destinationAnimators: destinationAnimators)
        return self
    }

    /**
     The function that configures the progress animation.

     - parameter progress: The progress block to be invoked when the animation progress.
     - parameter state: The state block to be invoked when the animation state changes.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    private func configureProgressAnimator(isReversed: Bool, from: CGFloat, to: CGFloat,
                                           progress progressBlock: FluidAnimatorCompatible.ProgressBlock? = nil,
                                           state stateBlock: FluidAnimatorCompatible.StateBlock? = nil) -> Self {
        Logger()?.log("🕊🛠", [])
        /* NOTE: Progress */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let progressView: FluidProgressView = self.createProgressViewIfNeeded()
        progressView.alpha = 0
        let progressAnimator: FluidCoreAnimator? = FluidCoreAnimator(for: progressView, id: "progressAnimator (\(String(describing: self.animationType).capitalized))",
                                                                     duration: transitionDuration, easing: .linear,
                                                                     isRemovedOnCompletion: true, fillMode: .removed)
        progressAnimator?
                .add(key: .opacity, from: from, to: to, isRemovedOnCompletion: true, fillMode: .removed)
                .on({ [weak self] (progress: CGFloat) in
                    self?.progressAnimatorDidUpdate(progress: progress)
                })
                .on({ [weak self] (state: FluidAnimatorState, progress: CGFloat) in
                    self?.progressAnimatorStateDidChange(state: state, progress: progress)
                })
        /* NOTE: Configure animators */
        self.parameters.configureProgressAnimator(progressView: progressView, progressAnimator: progressAnimator,
                                                  progressBlock: progressBlock, stateBlock: stateBlock)
        return self
    }

    /**
     The function that configures the background animation.

     - parameter progress: The progress block to be invoked when the animation progress.
     - parameter state: The state block to be invoked when the animation state changes.
     - returns: The `FluidViewAnimatorCompatible` object.
     */
    @discardableResult
    private func configureBackgroundAnimator(isReversed: Bool) -> Self {
        Logger()?.log("🕊🛠", [])
        /* NOTE: Background */
        let backgroundAnimator: FluidPropertyAnimator? = {
            guard !self.animationType.isRotate, self.backgroundView != nil else { return nil }
            if #available(iOS 11, *) {
                let transitionDuration: TimeInterval = !isReversed ? self.activeDuration * 0.5 : FluidConst.fluidInteractionReverseDuration
                let targetVisibility: CGFloat = !isReversed && self.animationType.isDismiss ? 0 : 1
                let animator: FluidPropertyAnimator = .init(duration: transitionDuration, easing: .easeInOutQuad, id: "backgroundAnimator (\(String(describing: self.animationType).capitalized))")
                animator.add({ [weak self] in
                            self?.backgroundView?.visibility = targetVisibility
                        })
                        /* IMPORTANT: Keep the background animator active until the all animators are finished */
                        .pausesOnCompletion(true)
                return animator
            } else {
                let backgroundDuration: TimeInterval = self.activeDuration
                /* FIXME: iOS 10 does not support the `pausesOnCompletion` property, so use illegal values as the workaround */
                let targetVisibility: CGFloat = self.animationType.isDismiss ? -1 : 2
                let animator: FluidPropertyAnimator = .init(duration: backgroundDuration, easing: .easeInOutQuad, id: "backgroundAnimator (\(String(describing: self.animationType).capitalized))")
                animator.add({ [weak self] in
                    self?.backgroundView?.visibility = targetVisibility
                })
                return animator
            }
        }()
        /* NOTE: Configure animators */
        self.parameters.configureBackgroundAnimator(backgroundAnimator: backgroundAnimator)
        return self
    }
}

extension FluidViewAnimatorCompatible {
    /**
     Configuring shadow animation
     */
    @available(iOS 11.0, *)
    func createShadowPropertyAnimation(_ isReversed: Bool = false) -> [FluidAnimatorCompatible] {
        guard self.shouldCastShadow, let shadowView: FluidShadowView = self.shadowView else { return [] }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: 👌 Configure properties to animate */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let transitionEasing: FluidAnimatorEasing = !isReversed ? self.activeEasing : .easeInOutQuad
        let fromShadowFrame: CGRect = self.fromShadowFrame(isReversed, self.resizePosition)
        let toShadowFrame: CGRect = self.toShadowFrame(isReversed, self.resizePosition)
//        let fromShadowTransform: CATransform3D = self.fromShadowTransform(isReversed)
//        let toShadowTransform: CATransform3D = self.toShadowTransform(isReversed)
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        guard let fromShadowPath: CGPath = self.fromShadowPath(isReversed) else { return [] }
        guard let toShadowPath: CGPath = self.toShadowPath(isReversed) else { return [] }
//        guard let fromShadowMask: CAShapeLayer = self.fromShadowMask(isReversed) else { return [] }
//        guard let toShadowMask: CAShapeLayer = self.toShadowMask(isReversed) else { return [] }
        let opt: FluidCoreAnimatorOption = .init(self.animationType, isReversed)
        Logger()?.log("🕊🛠", [
            "animationType:".lpad() + String(describing: self.animationType),
            "isReversed:".lpad() + String(describing: isReversed),
            "animationView.layer.frame:".lpad() + String(describing: animationView.layer.frame),
            "animationView.layer.presentation()?.frame:".lpad() + String(describing: animationView.layer.presentation()?.frame),
            "shadowView.layer.frame:".lpad() + String(describing: shadowView.layer.frame),
            "shadowView.layer.presentation()?.frame:".lpad() + String(describing: shadowView.layer.presentation()?.frame),
            "fromShadowFrame:".lpad() + String(describing: fromShadowFrame),
            "toShadowFrame:".lpad() + String(describing: toShadowFrame),
//            "fromShadowTransform:".lpad() + String(describing: fromShadowTransform),
//            "toShadowTransform:".lpad() + String(describing: toShadowTransform),
            "fromStyle:".lpad() + String(describing: fromStyle),
            "toStyle:".lpad() + String(describing: toStyle),
        ])
        /* NOTE: 👍 Set properties before run animation */
        shadowView.frame = toShadowFrame
//        shadowView.transform = fromTransform
//        shadowView.layer.frame = toShadowFrame
        shadowView.layer.cornerRadius = toStyle.cornerRadius
        shadowView.layer.maskedCorners = toStyle.maskedCorners
        shadowView.layer.shadowColor = toStyle.shadowColor
        shadowView.layer.shadowOpacity = Float(toStyle.shadowOpacity)
        shadowView.layer.shadowRadius = toStyle.shadowRadius
        shadowView.layer.shadowOffset = toStyle.shadowOffset
        shadowView.layer.shadowPath = toShadowPath
        /* NOTE: 🐅 Configure animator for shadow frame */
//        let shadowFrameAnimator: FluidPropertyAnimator = .init(duration: transitionDuration, easing: transitionEasing, id: "shadowFrameAnimator")
//        shadowFrameAnimator.add({ [weak self] in
//            guard let `self`: DefaultFluidViewAnimatorCompatible = self else { return }
//            self.shadowView?.frame = toFrame
////            self.shadowView?.transform = toTransform
//        })
//        animators.append(shadowFrameAnimator)
        /* NOTE: 🐅 Configure animator for shadow style */
        if let shadowFrameAnimator: FluidCoreAnimator = FluidCoreAnimator(for: shadowView.layer, id: "shadowFrameAnimator (\(String(describing: self.animationType).capitalized))",
                                                                          duration: transitionDuration, easing: .linear,
                                                                          isRemovedOnCompletion: opt.isRemovedGroup, fillMode: opt.fillModeGroup) {
            /* NOTE: Frame */
            shadowFrameAnimator
                    .add(key: .bounds, from: fromShadowFrame.bounds, to: toShadowFrame.bounds,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .position, from: fromShadowFrame.position, to: toShadowFrame.position,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
            /* NOTE: Transform */
//            if self.transitionStyle.isFluid {
//                shadowFrameAnimator
//                        .add(key: .transform, from: fromShadowTransform, to: toShadowTransform,
//                             easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
//            }
            /* NOTE: Style */
            shadowFrameAnimator
                    .add(key: .cornerRadius, from: fromStyle.cornerRadius, to: toStyle.cornerRadius,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowColor, from: fromStyle.shadowColor, to: toStyle.shadowColor,
                         easing: .easeOutSine, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowOpacity, from: Float(fromStyle.shadowOpacity), to: Float(toStyle.shadowOpacity),
                         easing: .easeOutSine, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowRadius, from: fromStyle.shadowRadius, to: toStyle.shadowRadius,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowOffset, from: fromStyle.shadowOffset, to: toStyle.shadowOffset,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowPath, from: fromShadowPath, to: toShadowPath,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
            animators.append(shadowFrameAnimator)
        }
        /* NOTE: Return animators */
        return animators
    }

    @available(iOS 10.0, *)
    func createShadowCoreAnimation(_ isReversed: Bool = false) -> [FluidAnimatorCompatible] {
        guard self.shouldCastShadow, let shadowView: FluidShadowView = self.shadowView else { return [] }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: 👌 Configure properties to animate */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let transitionEasing: FluidAnimatorEasing = !isReversed ? self.activeEasing : .easeInOutQuad
        let fromShadowFrame: CGRect = self.fromShadowFrame(isReversed, self.resizePosition)
        let toShadowFrame: CGRect = self.toShadowFrame(isReversed, self.resizePosition)
//        let fromShadowTransform: CATransform3D = self.fromShadowTransform(isReversed)
//        let toShadowTransform: CATransform3D = self.toShadowTransform(isReversed)
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        guard let fromShadowPath: CGPath = self.fromShadowPath(isReversed) else { return [] }
        guard let toShadowPath: CGPath = self.toShadowPath(isReversed) else { return [] }
        guard let fromShadowMask: CAShapeLayer = self.fromShadowMask(isReversed) else { return [] }
        guard let toShadowMask: CAShapeLayer = self.toShadowMask(isReversed) else { return [] }
        let opt: FluidCoreAnimatorOption = .init(self.animationType, isReversed)
        /* NOTE: 👍 Set properties before run animation */
        shadowView.layer.frame = toShadowFrame
//        shadowView.layer.transform = toTransform
        shadowView.layer.cornerRadius = toStyle.cornerRadius
//        shadowView.layer.maskedCorners = toStyle.maskedCorners
        shadowView.layer.shadowColor = toStyle.shadowColor
        shadowView.layer.shadowOpacity = Float(toStyle.shadowOpacity)
        shadowView.layer.shadowRadius = toStyle.shadowRadius
        shadowView.layer.shadowOffset = toStyle.shadowOffset
        shadowView.layer.shadowPath = toShadowPath
//        shadowView.layer.mask = toShadowMask
//        shadowView.castShadow(frame: toViewFrame,
//                              shadowCornerRadius: toStyle.cornerRadius,
//                              shadowRoundingCorners: toStyle.roundingCorners,
//                              shadowColor: toStyle.shadowColor,
//                              shadowOpacity: toStyle.shadowOpacity,
//                              shadowRadius: toStyle.shadowRadius,
//                              shadowOffset: toStyle.shadowOffset,
//                              isTransparentBackground: toStyle.isTransparentBackground)
        /* NOTE: 🐅 Configure animator for shadow style */
        if let shadowFrameAnimator: FluidCoreAnimator = FluidCoreAnimator(for: shadowView.layer, id: "shadowFrameAnimator (\(String(describing: self.animationType).capitalized))",
                                                                          duration: transitionDuration, easing: .linear,
                                                                          isRemovedOnCompletion: opt.isRemovedGroup, fillMode: opt.fillModeGroup) {
            /* NOTE: Frame */
            shadowFrameAnimator
                    .add(key: .bounds, from: fromShadowFrame.bounds, to: toShadowFrame.bounds,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .position, from: fromShadowFrame.position, to: toShadowFrame.position,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
            /* NOTE: Style */
            shadowFrameAnimator
                    .add(key: .cornerRadius, from: fromStyle.cornerRadius, to: toStyle.cornerRadius,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowColor, from: fromStyle.shadowColor, to: toStyle.shadowColor,
                         easing: .easeOutSine, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowOpacity, from: Float(fromStyle.shadowOpacity), to: Float(toStyle.shadowOpacity),
                         easing: .easeOutSine, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowRadius, from: fromStyle.shadowRadius, to: toStyle.shadowRadius,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowOffset, from: fromStyle.shadowOffset, to: toStyle.shadowOffset,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
                    .add(key: .shadowPath, from: fromShadowPath, to: toShadowPath,
                         easing: transitionEasing, isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
            animators.append(shadowFrameAnimator)
        }
        /* NOTE: 🐅 Configure animator for shadow mask */
        if let shadowMaskAnimator: FluidCoreAnimator = FluidCoreAnimator(for: shadowView.layer.mask, id: "shadowMaskAnimator (\(String(describing: self.animationType).capitalized))",
                                                                         duration: transitionDuration, easing: .linear,
                                                                         isRemovedOnCompletion: opt.isRemovedGroup, fillMode: opt.fillModeGroup) {
            shadowMaskAnimator.add(key: .path, from: fromShadowMask.path, to: toShadowMask.path,
                                   easing: transitionEasing,
                                   isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
            animators.append(shadowMaskAnimator)
        }
        /* NOTE: Return animators */
        return animators
    }
}

/**
 Configuring corner radius animation
 */
extension FluidViewAnimatorCompatible {
    @available(iOS 11.0, *)
    func createCornerRadiusPropertyAnimation(_ isReversed: Bool = false) -> [FluidAnimatorCompatible] {
        guard self.shouldMaskCorner else { return [] }
        /* NOTE: 👌 Configure properties to animate */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let transitionEasing: FluidAnimatorEasing = !isReversed ? self.activeEasing : .easeInOutQuad
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        /* NOTE: 👍 Set properties before run animation */
        if self.animationType.isPresent {
            self.animationView.layer.masksToBounds = true
            self.animationView.layer.cornerRadius = fromStyle.cornerRadius
            self.animationView.layer.maskedCorners = fromStyle.maskedCorners
        }
        /* NOTE: 🐅 Configure animator */
        let cornerRadiusAnimator: FluidPropertyAnimator = .init(duration: transitionDuration, easing: transitionEasing, id: "cornerRadiusAnimator (\(String(describing: self.animationType).capitalized))")
        cornerRadiusAnimator.add({ [weak self] in
                                guard let `self`: Self = self else { return }
                                self.animationView.layer.cornerRadius = toStyle.cornerRadius
                            })
        /* NOTE: Return animators */
        return [cornerRadiusAnimator]
    }

    @available(iOS 10.0, *)
    func createCornerRadiusCoreAnimation(_ isReversed: Bool = false) -> [FluidAnimatorCompatible] {
        guard self.shouldMaskCorner else { return [] }
        /* NOTE: 👌 Configure properties to animate */
        let transitionDuration: TimeInterval = !isReversed ? self.activeDuration : FluidConst.fluidInteractionReverseDuration
        let transitionEasing: FluidAnimatorEasing = !isReversed ? self.activeEasing : .easeInOutQuad
        let fromMaskLayer: FluidCornerMaskLayer = self.fromCornerMaskLayer(isReversed)
        let toMaskLayer: FluidCornerMaskLayer = self.toCornerMaskLayer(isReversed)
        let opt: FluidCoreAnimatorOption = .init(self.animationType, isReversed)
        /* NOTE: 👍 Set properties before run animation */
        self.animationView.layer.masksToBounds = true
        self.animationView.layer.mask = toMaskLayer
        /* NOTE: 🐅 Configure animator */
        let cornerRadiusAnimator: FluidCoreAnimator? = FluidCoreAnimator(for: self.animationView.layer.mask, id: "cornerRadiusAnimator (\(String(describing: self.animationType).capitalized))",
                                                                         duration: transitionDuration, easing: .linear,
                                                                         isRemovedOnCompletion: opt.isRemovedGroup, fillMode: opt.fillModeGroup)
        cornerRadiusAnimator?.add(key: .path, from: fromMaskLayer.path, to: toMaskLayer.path,
                                  easing: transitionEasing,
                                  isRemovedOnCompletion: opt.isRemovedChild, fillMode: opt.fillModeChild)
        /* NOTE: Return animators */
        if let cornerRadiusAnimator: FluidCoreAnimator = cornerRadiusAnimator {
            return [cornerRadiusAnimator]
        } else {
            return []
        }
    }
}

extension FluidViewAnimatorCompatible {
    /**
     The function that gets called when the animation progresses.

     - parameter progress: The progress value of the animation.
     */
    internal func progressAnimatorDidUpdate(progress: CGFloat) {
//        Logger()?.log("🕊💥", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "progress:".lpad() + String(describing: progress.decimal()),
//        ])
        /* NOTE: Propagate delegate */
        self.animationDidUpdate(progress: progress)
        self.progressBlock?(progress)
    }

    /**
     The function that gets called when the animation state changes.

     - parameter progress: The progress value of the animation.
     - parameter state: The `FluidAnimatorState` value.
     */
    internal func progressAnimatorStateDidChange(state: FluidAnimatorState, progress: CGFloat) {
//        Logger()?.log("🕊💥", [
//            "animationType:".lpad() + String(describing: self.animationType),
//            "interactionType:".lpad() + String(debug: interactionType),
//            "state:".lpad() + String(describing: state),
//            "progress:".lpad() + String(describing: progress.decimal()),
//        ])
        switch state {
        case .ready:   break
        case .running: break
        case .paused:  break
        case .cancelled, .failed, .finished:
            let isCancelled: Bool = self.context?.transitionWasCancelled ?? false
            /* NOTE: Restore the background visibility to the beginning if the animation is cancelled */
            if isCancelled { self.backgroundView?.visibility = self.animationType.isPresent ? 0 : 1 }
            /* NOTE: Propagate delegate */
            self.animationDidFinish(isCancelled: isCancelled)
        }
        self.stateBlock?(state, progress)
    }
}

/**
 Create views
 */
extension FluidViewAnimatorCompatible {
    func createInterruptibleViewIfNeeded() -> FluidInterruptibleView {
        if let interruptibleView: FluidInterruptibleView = containerView.viewWithTag(FluidConst.interruptibleViewTag) as? FluidInterruptibleView {
            return interruptibleView
        } else {
            let interruptibleView: FluidInterruptibleView = FluidInterruptibleView()
            containerView.insertSubview(interruptibleView, at: 1)
            return interruptibleView
        }
    }

    func createProgressViewIfNeeded() -> FluidProgressView {
        if let progressView: FluidProgressView = containerView.viewWithTag(FluidConst.progressViewTag) as? FluidProgressView {
            return progressView
        } else {
            let progressView: FluidProgressView = FluidProgressView()
            containerView.insertSubview(progressView, at: 0)
            return progressView
        }
    }
}

/**
 Configuring reverse animation for fluid interaction
 */
extension FluidViewAnimatorCompatible {
    func fromShadowFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat) -> CGRect {
        switch self.presentationStyle {
        case .slide, .drawer:
            if !isReversed {
                return self.fromViewFrame(isReversed, resizePosition)
            } else {
                return self.shadowView?.layer.frame ?? .zero
            }
        case .fluid, .scale:
            if self.driverType.isPresent {
                return self.fromViewFrame(isReversed, resizePosition)
            } else {
                return self.shadowView?.layer.frame ?? .zero
            }
        }
    }

    func toShadowFrame(_ isReversed: Bool = false, _ resizePosition: CGFloat) -> CGRect {
        return self.toViewFrame(isReversed, resizePosition)
    }

    func fromShadowTransform(_ isReversed: Bool = false) -> CATransform3D {
        switch self.presentationStyle {
        case .slide, .drawer: return .identity
        case .fluid where self.driverType.isPresent, .scale where self.driverType.isPresent:
            return .identity
        case .fluid, .scale:
            if !isReversed {
                return .identity
//                return self.fromViewTransform(isReversed)
            } else {
                return self.shadowView?.layer.transform ?? self.fromViewTransform(isReversed)
            }
        }
    }

    func toShadowTransform(_ isReversed: Bool = false) -> CATransform3D {
        return self.toViewTransform(isReversed)
    }

    func fromShadowPath(_ isReversed: Bool = false) -> CGPath? {
        let fromFrame: CGRect = self.fromViewFrame(isReversed, self.resizePosition)
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        switch self.animationType {
        case .dismiss where self.shadowView?.layer.shadowPath != nil:
            return self.shadowView?.layer.shadowPath
        case .present, .dismiss, .rotate:
            return FluidShadowLayer.createShadowPath(frame: fromFrame.bounds,
                                                     cornerRadius: fromStyle.cornerRadius,
                                                     roundingCorners: fromStyle.roundingCorners,
                                                     shadowRadius: fromStyle.shadowRadius,
                                                     shadowOffset: fromStyle.shadowOffset)
        }
    }

    func toShadowPath(_ isReversed: Bool = false) -> CGPath? {
        let toFrame: CGRect = self.toViewFrame(isReversed, self.resizePosition)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        return FluidShadowLayer.createShadowPath(frame: toFrame.bounds,
                                                 cornerRadius: toStyle.cornerRadius,
                                                 roundingCorners: toStyle.roundingCorners,
                                                 shadowRadius: toStyle.shadowRadius,
                                                 shadowOffset: toStyle.shadowOffset)
    }

    func fromShadowMask(_ isReversed: Bool = false) -> CAShapeLayer? {
        let fromFrame: CGRect = self.fromViewFrame(isReversed, self.resizePosition)
        let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
        switch self.animationType {
        case .dismiss where self.shadowView?.layer.mask as? CAShapeLayer != nil:
            return self.shadowView?.layer.mask as? CAShapeLayer
        case .present, .dismiss, .rotate:
            return FluidShadowLayer.createShadowMask(bounds: fromFrame.bounds,
                                                     cornerRadius: fromStyle.cornerRadius,
                                                     roundingCorners: fromStyle.roundingCorners,
                                                     shadowRadius: fromStyle.shadowRadius,
                                                     shadowOffset: fromStyle.shadowOffset,
                                                     isTransparentBackground: fromStyle.isTransparentBackground)
        }
    }

    func toShadowMask(_ isReversed: Bool = false) -> CAShapeLayer? {
        let toFrame: CGRect = self.toViewFrame(isReversed, self.resizePosition)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        return FluidShadowLayer.createShadowMask(bounds: toFrame.bounds,
                                                 cornerRadius: toStyle.cornerRadius,
                                                 roundingCorners: toStyle.roundingCorners,
                                                 shadowRadius: toStyle.shadowRadius,
                                                 shadowOffset: toStyle.shadowOffset,
                                                 isTransparentBackground: toStyle.isTransparentBackground)
    }

    func fromCornerMaskLayer(_ isReversed: Bool = false) -> FluidCornerMaskLayer {
        switch self.animationType {
        case .dismiss where self.animationView.layer.mask as? FluidCornerMaskLayer != nil:
            return self.animationView.layer.mask as! FluidCornerMaskLayer
        case .present, .dismiss, .rotate:
            let fromFrame: CGRect = self.fromViewFrame(isReversed, self.resizePosition)
            let fromStyle: FluidFrameStyleCompatible = self.fromStyle(isReversed)
            return .init(bounds: fromFrame.bounds, cornerRadius: fromStyle.cornerRadius, roundingCorners: fromStyle.roundingCorners)
        }
    }

    func toCornerMaskLayer(_ isReversed: Bool = false) -> FluidCornerMaskLayer {
        let toFrame: CGRect = self.toViewFrame(isReversed, self.resizePosition)
        let toStyle: FluidFrameStyleCompatible = self.toStyle(isReversed)
        return .init(bounds: toFrame.bounds, cornerRadius: toStyle.cornerRadius, roundingCorners: toStyle.roundingCorners)
    }
}
