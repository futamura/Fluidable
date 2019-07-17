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
class NavigationTableViewController: NavigationBaseViewController, Fluidable {
    /** Dummy value to prevent UIViewPropertyAnimator from finishing immediately. */
    @objc dynamic var transitionProgress: CGFloat = 0

    @IBOutlet weak var tableView: TableView!
    @IBOutlet weak var footerOverlayView: UIView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.fluidDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        /* NOTE: Set accessibility */
        self.tableView.accessibilityIdentifier = self.model.parentTableViewAccessibilityIdentifier
        /* NOTE: Configure table view */
        self.tableView.configure(model: self.model, headerPosition: .top) { [weak self] (indexPath: IndexPath) in
            self?.nextDidTap(indexPath)
        }
        self.tableView.contentOffset = .zero
        self.configureConstraints(for: self.tableView)
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

    deinit { Logger()?.log("🚗🧹🧹🧹", []) }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension NavigationTableViewController: FluidTransitionDestinationConfigurationDelegate {
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
            guard let `self`: NavigationTableViewController = self else { return }
            self.footerOverlayView.alpha = 0
        })
        animators.append(footerOverlayAnimator)
        /* NOTE: TableView (UIViewPropertyAnimator) */
        self.transitionProgress = 0
        self.view.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Present)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: NavigationTableViewController = self else { return }
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
            guard let `self`: NavigationTableViewController = self else { return }
            self.footerOverlayView.alpha = 1
        })
        animators.append(footerOverlayAnimator)
        /* NOTE: Content offset (UIViewPropertyAnimator) */
        if self.tableView.contentOffset.y > 200 {
            self.tableView.setContentOffset(CGPoint(x: 0, y: 200), animated: false)
        }
        self.tableView.clipsToBounds = false
        let scrollAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, easing: easing, id: "scrollAnimator (Dismiss)")
        scrollAnimator.add({ [weak self] in
            guard let `self`: NavigationTableViewController = self else { return }
            self.tableView.contentOffset.y = 0
        })
        animators.append(scrollAnimator)
        /* NOTE: TableView (UIViewPropertyAnimator) */
        self.transitionProgress = 0
        self.view.setNeedsLayout()
        self.tableView.setNeedsLayout()
        let constraintAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "constraintAnimator (Dismiss)")
        constraintAnimator.add({ [weak self] in
            guard let `self`: NavigationTableViewController = self else { return }
            self.transitionProgress = 1
            if #available(iOS 11.0, *) { self.tableView.contentInset.top -= self.view.safeAreaInsets.top }
            self.view.layoutIfNeeded()
        })
        animators.append(constraintAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension NavigationTableViewController: FluidTransitionDestinationActionDelegate {
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
