//
//  NavigationMultiCollectionViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class NavigationMultiCollectionViewController: NavigationBaseViewController, Fluidable {
    /** Views */
    var headerView: HeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var firstCollectionView: HorizontalCollectionView!
    @IBOutlet weak var secondCollectionView: HorizontalCollectionView!
    @IBOutlet weak var thirdCollectionView: HorizontalCollectionView!
    @IBOutlet weak var forthCollectionView: HorizontalCollectionView!
    @IBOutlet weak var fifthCollectionView: HorizontalCollectionView!
    @IBOutlet weak var closeButton: CloseButton!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.fluidDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        Logger()?.log("🚗🛠", ["modelIndex:".lpad() + String(describing: modelIndex)])
        /* NOTE: Set accessibility */
        self.closeButton.accessibilityIdentifier = self.model.overlayCloseButtonAccessibilityIdentifier
        /* NOTE: Setup views */
        self.headerView = .instantiate(model: model)
        self.stackView.insertArrangedSubview(self.headerView, at: 0)
        self.headerView.heightAnchor.constraint(equalToConstant: self.headerView.estimatedHeight).activate()
        self.headerView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).activate()
        /* NOTE: Configure collection */
        self.firstCollectionView.configure(scrollToRight: false, handler: { [weak self] (indexPath: IndexPath) in self?.nextDidTap(indexPath) })
        self.secondCollectionView.configure(scrollToRight: true, handler: { [weak self] (indexPath: IndexPath) in self?.nextDidTap(indexPath) })
        self.thirdCollectionView.configure(scrollToRight: false, handler: { [weak self] (indexPath: IndexPath) in self?.nextDidTap(indexPath) })
        self.forthCollectionView.configure(scrollToRight: true, handler: { [weak self] (indexPath: IndexPath) in self?.nextDidTap(indexPath) })
        self.fifthCollectionView.configure(scrollToRight: false, handler: { [weak self] (indexPath: IndexPath) in self?.nextDidTap(indexPath) })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚗💥", [])
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.secondCollectionView.layoutIfNeeded()
        self.forthCollectionView.layoutIfNeeded()
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

/* IMPORTANT: 🌊 Conform to `FluidNavigationSourceConfigurationDelegate` */
extension NavigationMultiCollectionViewController: FluidNavigationSourceConfigurationDelegate {
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
extension NavigationMultiCollectionViewController: FluidNavigationSourceActionDelegate {
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
extension NavigationMultiCollectionViewController: FluidTransitionDestinationConfigurationDelegate {
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]? {
        return [self.scrollView,
                self.firstCollectionView,
                self.secondCollectionView,
                self.thirdCollectionView,
                self.forthCollectionView,
                self.fifthCollectionView]
    }

    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        self.closeButton.alpha = 0
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration, easing: .linear, id: "buttonAnimator (Present)")
        buttonAnimator.add({ [weak self] in
                               self?.closeButton.alpha = 1
                           }, delayFactor: 0.7) /* NOTE: 70% delay */
        animators.append(buttonAnimator)
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
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        /* NOTE: Hide button in 30% of duration without delay (UIViewPropertyAnimator) */
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration * 0.3, /* NOTE: 30% of transition duration */
                                                          easing: .linear, id: "buttonAnimator (Dismiss)")
        buttonAnimator.add({ [weak self] in
            self?.closeButton.alpha = 0
        })
        animators.append(buttonAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension NavigationMultiCollectionViewController: FluidTransitionDestinationActionDelegate {
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
