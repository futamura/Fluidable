//
//  BaseTableViewController.swift
//  Example
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class TransitionTableViewController: TransitionBaseViewController, Fluidable {
    /* IMPORTANT: 🌊 Define the delegate to receive messages from `FluidDestinationConfigurationDelegate` and `FluidDestinationActionDelegate` */
    var fluidableTransitionDelegate: FluidViewControllerTransitioningDelegate = .init()

    /** Dummy value to prevent UIViewPropertyAnimator from finishing immediately. */
    @objc dynamic var transitionProgress: CGFloat = 0

    /** Views */
    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var footerOverlayView: UIView!

    @IBOutlet weak var tableTopConstraint: NSLayoutConstraint!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Set modal style */
        self.modalPresentationStyle = .custom
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.transitioningDelegate = self.fluidableTransitionDelegate
        self.fluidDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        Logger()?.log("🚗🛠", ["modelIndex:".lpad() + String(describing: modelIndex)])
        /* NOTE: Setup table view */
        self.tableView.configure(model: self.model)
        self.tableView.contentOffset = .zero
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚗💥", [])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger()?.log("🚗💥", [])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger()?.log("🚗💥", [])
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger()?.log("🚗💥", [])
    }

    deinit { Logger()?.log("🚗🧹🧹🧹", []) }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension TransitionTableViewController: FluidTransitionDestinationConfigurationDelegate {
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]? {
        return [self.tableView]
    }

    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        guard transitionStyle.isFluid else { return nil }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: Show button after 70% delay (Core Animation) */
//        self.closeButton.alpha = 1 /* NOTE: Set alpha to the end value. Otherwise button will disappear after animation completion. */
//        if let buttonAnimator: FluidCoreAnimator = FluidCoreAnimator(for: self.closeButton.layer, id: "buttonAnimator (Present)",
//                                                                     duration: duration, /* NOTE: The duration must be same as the transition duration */
//                                                                     easing: .linear,
//                                                                     isRemovedOnCompletion: true, fillMode: .forwards) {
//            buttonAnimator
//                    /* NOTE: Hide button for 70% of transition duration */
//                    .add(key: .opacity, from: 0.0, to: 0.0,
//                         duration: duration * 0.7, /* NOTE: 70% of transition duration */
//                         beginTime: duration * 0.0, /* NOTE: No delay */
//                         isRemovedOnCompletion: true, fillMode: .forwards)
//                    /* NOTE: Show button after 70% delay */
//                    .add(key: .opacity, from: 0.0, to: 1.0,
//                         duration: duration * 0.3, /* NOTE: 30% of transition duration */
//                         beginTime: duration * 0.7, /* NOTE: 70% delay */
//                         isRemovedOnCompletion: true, fillMode: .forwards)
//            animators.append(buttonAnimator)
//        }
        /* WARN: Since CoreAnimation complicates animation logic, we recommend using UIViewPropertyAnimator. */
        /* NOTE: Show button with 70% delay (UIViewPropertyAnimator) */
        self.closeButton.alpha = 0
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration, easing: .linear, id: "buttonAnimator (Present)")
        buttonAnimator.add({ [weak self] in
                               self?.closeButton.alpha = 1
                           }, delayFactor: 0.7) /* NOTE: 70% delay */
        animators.append(buttonAnimator)
        /* NOTE: Footer overlay (UIViewPropertyAnimator) */
        let footerOverlayAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "footerOverlayAnimator (Present)")
        footerOverlayAnimator.add({ [weak self] in
            guard let `self`: TransitionTableViewController = self else { return }
            self.footerOverlayView.alpha = 0
        })
        animators.append(footerOverlayAnimator)
        /* NOTE: TableView (UIViewPropertyAnimator) */
        self.transitionProgress = 0
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Present)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: TransitionTableViewController = self else { return }
            self.transitionProgress = 1
            self.tableView.contentInset.top = 0
            self.tableView.contentOffset.y = 0
            self.footerOverlayView.alpha = 0
            self.view.layoutIfNeeded()
        })
        animators.append(constraintAnimator)
        return animators
    }

    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        guard transitionStyle.isFluid else { return nil }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: Hide button in 30% of duration without delay (Core Animation) */
//        if let buttonAnimator: FluidCoreAnimator = FluidCoreAnimator(for: self.closeButton.layer, id: "buttonAnimator (Dismiss)",
//                                                                     duration: duration, /* NOTE: The duration must be same as the transition duration */
//                                                                     easing: .linear,
//                                                                     isRemovedOnCompletion: false, fillMode: .both) {
//            buttonAnimator.add(key: .opacity, from: self.closeButton.alpha, to: 0.0,
//                               duration: duration * 0.3, /* NOTE: 30% of transition duration */
//                               beginTime: duration * 0.0, /* NOTE: No delay */
//                               isRemovedOnCompletion: false, fillMode: .both)
//            animators.append(buttonAnimator)
//        }
        /* WARN: Since CoreAnimation complicates animation logic, we recommend using UIViewPropertyAnimator. */
        /* NOTE: Hide button in 30% of duration without delay (UIViewPropertyAnimator) */
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, /* NOTE: 30% of transition duration */
                                                          easing: .linear, id: "buttonAnimator (Dismiss)")
        buttonAnimator.add({ [weak self] in
            self?.closeButton.alpha = 0
        })
        animators.append(buttonAnimator)
        /* NOTE: Footer overlay (UIViewPropertyAnimator) */
        let footerOverlayAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "footerOverlayAnimator (Dismiss)")
        footerOverlayAnimator.add({ [weak self] in
            guard let `self`: TransitionTableViewController = self else { return }
            self.footerOverlayView.alpha = 1
        })
        animators.append(footerOverlayAnimator)
        /* NOTE: Content offset (UIViewPropertyAnimator) */
        if self.tableView.contentOffset.y > 200 {
            self.tableView.setContentOffset(CGPoint(x: 0, y: 200), animated: false)
        }
        let contentOffsetAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "scrollAnimator (Dismiss)")
        contentOffsetAnimator.add({ [weak self] in
            guard let `self`: TransitionTableViewController = self else { return }
            self.tableView.contentOffset.y = 0
        })
        animators.append(contentOffsetAnimator)
        /* NOTE: TableView (UIViewPropertyAnimator) */
        self.transitionProgress = 0
        self.view.setNeedsLayout()
        self.tableView.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Dismiss)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: TransitionTableViewController = self else { return }
            self.transitionProgress = 1
            if #available(iOS 11.0, *) {
                self.tableView.contentInset.top -= self.view.safeAreaInsets.top
            }
            self.view.layoutIfNeeded()
        })
        animators.append(constraintAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension TransitionTableViewController: FluidTransitionDestinationActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }

    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }

    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }

    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
        switch state {
        case .begin:
            break
        case .update:
            if transitionStyle.isFluid {
                self.closeButton.alpha = 1 - progress
            } else {
                self.closeButton.alpha = (1 - progress * 3).clamped(0, 1)
            }
        case .cancel:
            let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.1, easing: .linear)
            animator.addAnimations({ [weak self] in
                self?.closeButton.alpha = 1
            })
            animator.startAnimation()
        case .end:
            break
        }
    }
}
