//
//  FluidDriverCompatible+Animated.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidDriverCompatible {
    func configureForwardTransitionAnimation(using transitionContext: UIViewControllerContextTransitioning,
                                             driverType: FluidDriverType, animationType: FluidAnimationType,
                                             source: UIViewController?, destination: UIViewController?,
                                             duration: TimeInterval?, easing: FluidAnimatorEasing?, fromValue: CGFloat,
                                             completion: @escaping FluidInterruptibleAnimator.CompletionBlock) {
        Logger()?.log("🐮🛠", [
            "transitionContext:".lpad() + String(describing: transitionContext),
        ])
        /* NOTE: Configure parameters */
        do {
            try self.configureParameters(driverType: driverType, animationType: animationType,
                                         context: transitionContext,
                                         container: transitionContext.containerView,
                                         source: source, destination: destination,
                                         duration: duration, easing: easing)
        } catch let error as FluidError {
            switch error.level {
            case .error: transitionContext.completeTransition(false)
            case .warn, .info: break
            }
        } catch {}
        /* NOTE: Start observing gestures and scroll views */
        self.stopObservingGestures()
        self.startObservingGestures()
        /* NOTE: Propagate FluidableDelegate */
        self.propagateAnimationActionDelegate(state: .begin, progress: self.viewAnimator.animationProgress)
        /* NOTE: Run animations */
        self.viewAnimator
                .invalidate(willRemoveContainer: false)
                .registerParameters(parameters: self.parameters)
                .configureInterruptibleAnimator(completion: completion)
                .configureTransitionAnimators(isReversed: false, from: fromValue, to: 1,
                                              progress: { [weak self] (progress: CGFloat) in
                                                  guard let `self`: Self = self else { return }
                                                  /* NOTE: Propagate FluidableDelegate */
                                                  self.propagateAnimationActionDelegate(state: .update, progress: self.viewAnimator.animationProgress)
                                              },
                                              state: { [weak self] (state: FluidAnimatorState, progress: CGFloat) in
                                                  guard let `self`: Self = self else { return }
                                                  switch state {
                                                  case .ready:   break
                                                  case .running: break
                                                  case .paused:  break
                                                  case .cancelled, .failed, .finished: self.viewAnimatorDidFinish(using: transitionContext)
                                                  }
                                              })
    }

    func configureAndRunReverseTransitionAnimation() {
        Logger()?.log("🐮🎬", [
        ])
        /* NOTE: Resume animation */
        self.viewAnimator
                .invalidate(willRemoveContainer: false)
                .registerParameters(parameters: self.parameters)
                .configureTransitionAnimators(isReversed: true, from: self.clampedInteractionProgress, to: 0,
                                              progress: { [weak self] (progress: CGFloat) in
                                                  guard let `self`: Self = self else { return }
                                                  /* NOTE: Propagate FluidableDelegate */
                                                  self.propagateAnimationActionDelegate(state: .update, progress: self.viewAnimator.animationProgress)
                                              },
                                              state: { [weak self] (state: FluidAnimatorState, progress: CGFloat) in
                                                  guard let `self`: Self = self else { return }
                                                  switch state {
                                                  case .ready:   break
                                                  case .running: break
                                                  case .paused:  break
                                                  case .cancelled, .failed, .finished: self.animationDidEnd(false)
                                                  }
                                              })
                .run()
    }

    func viewAnimatorDidFinish(using transitionContext: UIViewControllerContextTransitioning) {
        Logger()?.log("🐮💥", [
            "transitionContext:".lpad() + String(describing: transitionContext),
            "transitionWasCancelled:".lpad() + String(describing: transitionContext.transitionWasCancelled),
            "interruptibleAnimator.isNotRunning:".lpad() + String(describing: self.interruptibleAnimator.isNotRunning),
            "transitionAnimator.isNotRunning:".lpad() + String(describing: self.viewAnimator.isNotRunning),
        ])
        /* NOTE: Complete transition if both animations are completed */
        if self.interruptibleAnimator.isNotRunning && self.viewAnimator.isNotRunning {
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

extension FluidDriverCompatible {
    func configureAndRunRotateAnimation(from fromContainerSize: CGSize, to toContainerSize: CGSize, duration: TimeInterval) {
        Logger()?.log("🐮🎬", [
            "fromContainerSize:".lpad() + String(describing: fromContainerSize),
            "toContainerSize:".lpad() + String(describing: toContainerSize),
            "duration:".lpad() + String(describing: duration),
        ])
        /* NOTE: Configure parameters */
        try? self.configureParameters(driverType: self.parameters.driverType, animationType: .rotate,
                                      context: self.context,
                                      container: self.containerView,
                                      source: self.sourceViewController,
                                      destination: self.parameters.rootNavigationController ?? self.parameters.destinationViewController,
                                      initialContainerSize: fromContainerSize,
                                      finalContainerSize: toContainerSize,
                                      duration: duration, easing: .linear,
                                      shouldInsertSubview: false)
        /* NOTE: Stop observing */
        self.stopObservingGestures()
        /* NOTE: Run animations */
        self.viewAnimator
                .invalidate(willRemoveContainer: false)
                .registerParameters(parameters: self.parameters)
                .configureTransitionAnimators(isReversed: false, from: 0, to: 1,
                                              state: { [weak self] (state: FluidAnimatorState, progress: CGFloat) in
                                                  switch state {
                                                  case .ready:   break
                                                  case .running: break
                                                  case .paused:  break
                                                  case .cancelled, .failed, .finished: self?.rotateAnimationDidEnd()
                                                  }
                                              })
                .run()
    }

    private func rotateAnimationDidEnd() {
        Logger()?.log("🐮💥", [
        ])
        /* NOTE: Configure animation */
        try? self.configureParameters(driverType: .dismiss, animationType: .dismiss,
                                      context: self.parameters.context,
                                      container: self.parameters.containerView,
                                      source: self.parameters.sourceViewController,
                                      destination: self.parameters.destinationViewController,
                                      initialContainerSize: self.parameters.finalContainerSize,
                                      finalContainerSize: self.parameters.finalContainerSize,
                                      shouldInsertSubview: false)
        /* NOTE: Start observing */
        self.startObservingGestures()
        /* NOTE: Invalidate animations */
        self.viewAnimator
                .invalidate(willRemoveContainer: false)
                .registerParameters(parameters: self.parameters)
    }
}
