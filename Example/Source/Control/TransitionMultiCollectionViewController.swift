//
//  SingleMultiCollectionViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` and `FluidResizable` protocol */
class TransitionMultiCollectionViewController: TransitionBaseViewController, Fluidable, FluidResizable {
    /* IMPORTANT: 🌊 Define the delegate to receive messages from `FluidDestinationConfigurationDelegate` and `FluidDestinationActionDelegate` */
    var fluidableTransitionDelegate: FluidViewControllerTransitioningDelegate = .init()

    /** Views */
    var headerView: HeaderView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var stackView: UIStackView!

    @IBOutlet weak var firstCollectionView: HorizontalCollectionView!
    @IBOutlet weak var secondCollectionView: HorizontalCollectionView!
    @IBOutlet weak var thirdCollectionView: HorizontalCollectionView!
    @IBOutlet weak var forthCollectionView: HorizontalCollectionView!
    @IBOutlet weak var fifthCollectionView: HorizontalCollectionView!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        /* IMPORTANT: 🌊 Set modal style */
        self.modalPresentationStyle = .custom
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.transitioningDelegate = self.fluidableTransitionDelegate
        self.fluidDelegate = self
        self.fluidResizableDelegate = self
    }

    override func configure(modelIndex: Int) {
        super.configure(modelIndex: modelIndex)
        /* NOTE: Set accessibility */
        self.scrollView.accessibilityIdentifier = self.model.parentScrollViewAccessibilityIdentifier
        self.firstCollectionView.accessibilityIdentifier = self.model.childFirstCollectionViewAccessibilityIdentifier
        self.secondCollectionView.accessibilityIdentifier = self.model.childSecondCollectionViewAccessibilityIdentifier
        self.thirdCollectionView.accessibilityIdentifier = self.model.childThirdCollectionViewAccessibilityIdentifier
        self.forthCollectionView.accessibilityIdentifier = self.model.childForthCollectionViewAccessibilityIdentifier
        /* NOTE: Header */
        if let model: RootModel = self.model {
            self.headerView = .instantiate(model: model)
            self.stackView.insertArrangedSubview(self.headerView, at: 0)
            self.headerView.heightAnchor.constraint(equalToConstant: self.headerView.estimatedHeight).activate()
            self.headerView.widthAnchor.constraint(equalTo: self.stackView.widthAnchor).activate()
        }
        self.secondCollectionView.initiallyScrollToRight = true
        self.forthCollectionView.initiallyScrollToRight = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚗💥", [])
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

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension TransitionMultiCollectionViewController: FluidTransitionDestinationConfigurationDelegate {
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
        /* Button */
        self.closeButton.alpha = 0
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration, easing: .linear, id: "buttonAnimator (Present)")
        buttonAnimator.add({ [weak self] in
                               self?.closeButton.alpha = 1
                           }, delayFactor: 0.7)
        return [buttonAnimator]
    }

    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        /* Button */
        let buttonAnimator: FluidPropertyAnimator = .init(duration: duration * 0.2, easing: .easeInOutSine, id: "buttonAnimator (Dismiss)")
        buttonAnimator.add({ [weak self] in
            self?.closeButton.alpha = 0
        })
        return [buttonAnimator]
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension TransitionMultiCollectionViewController: FluidTransitionDestinationActionDelegate {
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

/* IMPORTANT: 🌊 Conform to `FluidResizableDelegate` */
extension TransitionMultiCollectionViewController: FluidResizableTransitionDelegate {
    func transitionShouldPerformResizing() -> Bool { return true }
    func transitionMinimumMarginForResizing() -> CGFloat { return 64 }
    func transitionSnapPositionsForResizing() -> [CGFloat]? { return [0.0, 0.5, 1.0] }
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚗💥", [
            "state: " + String(describing: state),
            "position: " + String(describing: position),
        ])
    }
}
