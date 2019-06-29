//
//  NavigationScrollViewController.swift
//  FluidableUITests
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class NavigationScrollViewController: NavigationBaseViewController, Fluidable {
    /** Views */
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textContainerView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var closeButton: CloseButton!
    @IBOutlet weak var nextButton: RoundButton!
    var headerView: HeaderView!

    /** Constraints */
    @IBOutlet weak var imageContainerHeightConstraint: NSLayoutConstraint!
    var headerPositionConstraint: NSLayoutConstraint!

    /** Dummy value to prevent UIViewPropertyAnimator from finishing immediately. */
    @objc dynamic var transitionProgress: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.fluidDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        Logger()?.log("🚗🛠", ["modelIndex:".lpad() + String(describing: modelIndex)])
        /* NOTE: Header */
        self.headerView = .instantiate(model: self.model)
        self.imageContainerView.addSubview(self.headerView)
        self.headerPositionConstraint = self.headerView.topAnchor.constraint(equalTo: self.imageContainerView.topAnchor).activate()
        self.headerView.leftAnchor.constraint(equalTo: self.imageContainerView.leftAnchor).activate()
        self.headerView.rightAnchor.constraint(equalTo: self.imageContainerView.rightAnchor).activate()
        self.headerView.heightAnchor.constraint(equalToConstant: self.headerView.estimatedHeight).activate()
        self.imageView.image = UIImage(row: self.modelIndex, size: .medium)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚗💥", [])
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
        Logger()?.log("🚗💥", [])
        switch self.model! {
        case .navigationFluidModal, .transitionFluidModal:
            self.scrollView.topAnchor.constraint(equalTo: self.view.topAnchor).activate()
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).activate()
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).activate()
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).activate()
//            self.scrollView.heightAnchor.constraint(equalTo: self.view.heightAnchor).activate()
        default:
            if #available(iOS 11.0, *) {
                self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).activate()
                self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).activate()
                self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).activate()
                self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).activate()
            } else {
                self.scrollView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).activate()
                self.scrollView.bottomAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).activate()
                self.scrollView.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor).activate()
                self.scrollView.trailingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.trailingAnchor).activate()
            }
        }
        self.scrollView.contentInset.bottom = 40
        super.updateViewConstraints()
    }

    override func viewWillLayoutSubviews() {
        Logger()?.log("🚗💥", [])
        super.viewWillLayoutSubviews()
    }

    override func viewDidLayoutSubviews() {
        Logger()?.log("🚗💥", [])
        super.viewDidLayoutSubviews()
    }

    deinit { Logger()?.log("🚗🧹🧹🧹", []) }
}

/* IMPORTANT: 🌊 Conform to `FluidNavigationSourceConfigurationDelegate` */
extension NavigationScrollViewController: FluidNavigationSourceConfigurationDelegate {
    func navigationAllowsInteractivePresent(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> Bool { return true }

    func navigationPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidNavigationStyle { return .slide(direction: .fromBottom) }
    func navigationBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle { return .none }

    func navigationPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }
    func navigationDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? { return nil }

    func navigationPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }
    func navigationDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval? { return nil }

    func navigationInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension? { return nil }
    func navigationFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameDimension? { return nil }

    func navigationInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameStyle? { return nil }
    func navigationFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidFinalFrameStyle? { return nil }

    func navigationAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
    func navigationAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? { return nil }
}

/* IMPORTANT: 🌊 Conform to `FluidNavigationSourceActionDelegate` */
extension NavigationScrollViewController: FluidNavigationSourceActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "progress:".lpad() + String(describing: progress),
        ])
    }
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚗💥", [
            "progress:".lpad() + String(describing: progress),
        ])
    }
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚗💥", [
            "progress:".lpad() + String(describing: progress),
        ])
    }
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚗💥", [
            "progress:".lpad() + String(describing: progress),
        ])
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension NavigationScrollViewController: FluidTransitionDestinationConfigurationDelegate {
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
            "transitionStyle: " + String(describing: transitionStyle),
        ])
        guard transitionStyle.isFluid else { return nil }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        self.transitionProgress = 0
        /* NOTE: Show button with 70% delay (UIViewPropertyAnimator) */
        self.closeButton.alpha = 0
        self.nextButton.alpha = 0
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration, easing: .linear, id: "buttonAnimator (Present)")
        buttonAnimator.add({ [weak self] in
                               self?.closeButton.alpha = 1
                               self?.nextButton.alpha = 1
                           }, delayFactor: 0.7) /* NOTE: 70% delay */
        animators.append(buttonAnimator)
        /* NOTE: Set initial value */
        let initialFrame: CGRect = initialDimension.frame()
        let finalFrame: CGRect = finalDimension.frame()
        let initialImageHeight: CGFloat = initialFrame.size.height
        let finalImageHeight: CGFloat = (9 / 16) * finalFrame.size.height
        self.imageContainerHeightConstraint.constant = initialImageHeight
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        /* NOTE: Configure animation */
        self.headerPositionConstraint.constant = 10
        self.imageContainerHeightConstraint.constant = finalImageHeight
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Present)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: NavigationScrollViewController = self else { return }
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
            "transitionStyle: " + String(describing: transitionStyle),
        ])
        guard transitionStyle.isFluid else { return nil }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        self.transitionProgress = 0
        /* NOTE: Hide button in 30% of duration without delay (UIViewPropertyAnimator) */
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, /* NOTE: 30% of transition duration */
                                                          easing: .linear, id: "buttonAnimator (Dismiss)")
        buttonAnimator.add({ [weak self] in
            self?.closeButton.alpha = 0
            self?.nextButton.alpha = 0
        })
        animators.append(buttonAnimator)
        /* NOTE: Content offset (UIViewPropertyAnimator) */
        if self.scrollView.contentOffset.y > self.imageContainerView.frame.height {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: self.imageContainerView.frame.height), animated: false)
        }
        self.scrollView.clipsToBounds = false
        let scrollAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "scrollAnimator (Dismiss)")
        scrollAnimator.add({ [weak self] in
            guard let `self`: NavigationScrollViewController = self else { return }
            self.scrollView.contentOffset.y = 0
        })
        animators.append(scrollAnimator)
        /* NOTE: Constraint (UIViewPropertyAnimator) */
        let initialFrame: CGRect = initialDimension.frame()
        let initialImageHeight: CGFloat = initialFrame.size.height
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
        /* NOTE: Configure animation */
        self.headerPositionConstraint.constant = 0
        self.imageContainerHeightConstraint.constant = initialImageHeight
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Dismiss)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: NavigationScrollViewController = self else { return }
            self.transitionProgress = 1
            self.view.layoutIfNeeded()
        })
        animators.append(constraintAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension NavigationScrollViewController: FluidTransitionDestinationActionDelegate {
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
        switch state {
        case .begin: break
        case .update: break
        case .cancel: break
        case .end: break
        }
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
        case .begin: break
        case .update:
            if transitionStyle.isFluid {
                self.closeButton.alpha = 1 - progress
                self.nextButton.alpha = 1 - progress
            } else {
                self.closeButton.alpha = (1 - progress * 3).clamped(0, 1)
                self.nextButton.alpha = (1 - progress * 3).clamped(0, 1)
            }
        case .cancel:
            let animator: UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 0.1, easing: .linear)
            animator.addAnimations({ [weak self] in
                self?.closeButton.alpha = 1
                self?.nextButton.alpha = 1
            })
            animator.startAnimation()
        case .end: break
        }
    }
}
