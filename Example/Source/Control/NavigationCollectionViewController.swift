//
//  SingleCollectionViewController.swift
//  FluidableUITests
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class NavigationCollectionViewController: NavigationBaseViewController, Fluidable {
    @IBOutlet weak var collectionView: AlignedCollectionView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.fluidDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        /* NOTE: Set accessibility */
        self.closeButton.accessibilityIdentifier = self.model.overlayCloseButtonAccessibilityIdentifier
        self.collectionView.accessibilityIdentifier = self.model.parentCollectionViewAccessibilityIdentifier
        /* NOTE: Configure collection view */
        self.collectionView.configure(model: self.model, headerPosition: .top, handler: { [weak self] (indexPath: IndexPath) in
            self?.nextDidTap(indexPath)
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
        self.configureConstraints(for: self.collectionView)
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

extension NavigationCollectionViewController {
    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
            /* NOTE: Reset layout */
            if let layout: AlignedCollectionLayout = self?.collectionView.collectionViewLayout as? AlignedCollectionLayout {
                layout.reset()
            }
        }, completion: { (context: UIViewControllerTransitionCoordinatorContext) in
        })
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension NavigationCollectionViewController: FluidTransitionDestinationConfigurationDelegate {
    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissFromChildViewControllers(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionAllowsDismissWhenTapBackground(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }
    func transitionObservesScrollViews(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> [UIScrollView]? {
        return [self.collectionView]
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
        /* NOTE: Show button with 70% delay (UIViewPropertyAnimator) */
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
extension NavigationCollectionViewController: FluidTransitionDestinationActionDelegate {
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
