//
//  SingleScrollViewController.swift
//  FluidableUITests
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class TransitionScrollViewController: TransitionBaseViewController, Fluidable {
    /* IMPORTANT: 🌊 Define the delegate to receive messages from `FluidTransitionDestinationConfigurationDelegate` and `FluidTransitionDestinationActionDelegate` */
    var fluidableTransitionDelegate: FluidViewControllerTransitioningDelegate = FluidViewControllerTransitioningDelegate()

    /** Dummy value to prevent UIViewPropertyAnimator from finishing immediately. */
    @objc dynamic var transitionProgress: CGFloat = 0

    /** Views */
    var headerView: HeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var textLabel: UILabel!

    /** Constraints */
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    var headerPositionConstraint: NSLayoutConstraint!

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
        /* NOTE: Set accessibility */
        self.scrollView.accessibilityIdentifier = self.model.parentScrollViewAccessibilityIdentifier
        /* NOTE: Header */
        self.headerView = .instantiate(model: self.model)
        self.imageContainerView.addSubview(self.headerView)
        self.headerPositionConstraint = self.headerView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor).activate()
        self.headerView.leftAnchor.constraint(equalTo: self.imageContainerView.leftAnchor).activate()
        self.headerView.rightAnchor.constraint(equalTo: self.imageContainerView.rightAnchor).activate()
        self.headerView.heightAnchor.constraint(equalToConstant: self.headerView.estimatedHeight).activate()
        self.imageView.image = UIImage(row: self.modelIndex, size: .medium)
        self.scrollView.contentInset.bottom = 40
        self.configureConstraints(for: self.scrollView)
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

    override func updateViewConstraints() {
        super.updateViewConstraints()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillLayoutSubviews() {
        /* NOTE: Set width to 1 to avoid horizontal scroll */
        self.scrollView.contentSize.width = 1
        super.viewWillLayoutSubviews()
    }

    deinit {
        Logger()?.log("🚗🧹🧹🧹", [])
        self.transitioningDelegate = nil
    }
}

/* IMPORTANT: 🌊 Conform to `FluidTransitionDestinationConfigurationDelegate` */
extension TransitionScrollViewController: FluidTransitionDestinationConfigurationDelegate {
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]? {
        return [self.scrollView]
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
        self.transitionProgress = 0
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
                               guard let `self`: TransitionScrollViewController = self else { return }
                               self.closeButton.alpha = 1
                           }, delayFactor: 0.7) /* NOTE: 70% delay */
        animators.append(buttonAnimator)
        /* NOTE: TableView (UIViewPropertyAnimator) */
        /* NOTE: Set initial value */
        let initialFrame: CGRect = initialDimension.frame()
        let finalFrame: CGRect = finalDimension.frame()
        let initialImageHeight: CGFloat = initialFrame.size.height
        let finalImageHeight: CGFloat = (9 / 16) * finalFrame.size.height
        self.imageHeightConstraint.constant = initialImageHeight
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        /* NOTE: Configure animation */
        self.headerPositionConstraint.constant = 10
        self.imageHeightConstraint.constant = finalImageHeight
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Present)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: TransitionScrollViewController = self else { return }
            self.transitionProgress = 1
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
        self.transitionProgress = 0
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
        /* WARN: Since Core Animation complicates animation logic, we recommend using UIViewPropertyAnimator. */
        /* NOTE: Hide button in 30% of duration without delay (UIViewPropertyAnimator) */
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, /* NOTE: 30% of transition duration */
                                                          easing: .linear, id: "buttonAnimator (Dismiss)")
        buttonAnimator.add({ [weak self] in
            self?.closeButton.alpha = 0
        })
        animators.append(buttonAnimator)
        /* NOTE: UILabel (UIViewPropertyAnimator) */
        let labelAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: .easeInOutQuad, id: "labelAnimator (Present)")
        labelAnimator.add({ [weak self] in
            guard let `self`: TransitionScrollViewController = self else { return }
            self.textLabel.alpha = 0
        })
        animators.append(labelAnimator)
        /* NOTE: Content offset (UIViewPropertyAnimator) */
        if self.scrollView.contentOffset.y > self.imageContainerView.frame.height {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: self.imageContainerView.frame.height), animated: false)
        }
        let contentOffsetAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "scrollAnimator (Dismiss)")
        contentOffsetAnimator.add({ [weak self] in
            guard let `self`: TransitionScrollViewController = self else { return }
            self.scrollView.contentOffset.y = 0
        })
        animators.append(contentOffsetAnimator)
        /* NOTE: Constraint (UIViewPropertyAnimator) */
        let initialFrame: CGRect = initialDimension.frame()
        let initialImageHeight: CGFloat = initialFrame.size.height
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        /* NOTE: Configure animation */
        self.headerPositionConstraint.constant = 0
        self.imageHeightConstraint.constant = initialImageHeight
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Dismiss)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: TransitionScrollViewController = self else { return }
            self.transitionProgress = 1
            self.scrollView.contentOffset.y = 0
            self.view.layoutIfNeeded()
        })
        animators.append(constraintAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidTransitionDestinationActionDelegate` */
extension TransitionScrollViewController: FluidTransitionDestinationActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
        switch state {
        case .begin: container?.accessibilityIdentifier = "TransitionContainerView"
        case .update: break
        case .cancel: break
        case .end: break
        }
    }

    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
        switch state {
        case .begin:  break
        case .update: break
        case .cancel: break
        case .end:    break
        }
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
