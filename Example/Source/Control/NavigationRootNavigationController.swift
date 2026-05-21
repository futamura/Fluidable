//
//  NavigationRootNavigationController.swift
//  FluidableUITests
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `FluidNavigationBarCompatible` protocol */
class NavigationRootNavigationBar: UINavigationBar, FluidNavigationBarCompatible {
    var preferredSize: CGSize {
        return CGSize(width: self.superview?.frame.width ?? UIScreen.main.bounds.width, height: 44)
    }
}

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class NavigationRootNavigationController: UINavigationController, Fluidable, FluidResizable, RootModelReceivable {
    /* IMPORTANT: 🌊 Define the delegate to receive messages from `FluidTransitionDestinationConfigurationDelegate` and `FluidTransitionDestinationActionDelegate` */
    let fluidNavigationDelegate: FluidNavigationControllerDelegate = .init()
    let fluidTransitionDelegate: FluidViewControllerTransitioningDelegate = .init()

    /** The value received from RootViewController */
    var modelIndex: Int = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚙🛠", [])
        /* IMPORTANT: 🌊 Set modal style */
        self.modalPresentationStyle = .custom
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.delegate = self.fluidNavigationDelegate
        self.transitioningDelegate = self.fluidTransitionDelegate
        self.fluidDelegate = self
        self.fluidResizableDelegate = self
    }

    func configure(modelIndex: Int) {
        Logger()?.log("🚙🛠", ["modelIndex:".lpad() + String(describing: modelIndex)])
        self.modelIndex = modelIndex
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚙💥", [])
        self.setNavigationBarHidden(true, animated: false)
        /* NOTE: Set accessibility identifier */
        self.navigationBar.accessibilityIdentifier = self.model.navigationBarAccessibilityIdentifier
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚙💥", [])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Logger()?.log("🚙💥", [])
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Logger()?.log("🚙💥", [])
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        Logger()?.log("🚙💥", [])
        self.transitioningDelegate = nil
        self.fluidDelegate = nil
    }

    deinit { Logger()?.log("🚙🧹🧹🧹", []) }
}

extension NavigationRootNavigationController {
    @IBAction func closeButtonDidTap(_ sender: Any) {
        self.dismiss(animated: true)
    }
}

/* IMPORTANT: 🌊 Conform to `FluidNavigationSourceActionDelegate` */
extension NavigationRootNavigationController: FluidNavigationSourceActionDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
        switch state {
        case .begin: container?.accessibilityIdentifier = "NavigationContainerView"
        case .update: break
        case .cancel: break
        case .end: break
        }
    }
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }
}

/* IMPORTANT: 🌊 Conform to `FluidTransitionDestinationActionDelegate` */
extension NavigationRootNavigationController: FluidTransitionDestinationActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        Logger()?.log("🚙💥", [
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
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }

    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }

    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚙💥", [
            "state:".lpad() + String(describing: state),
            "progress:".lpad() + String(describing: progress),
        ])
    }
}

/* IMPORTANT: 🌊 Conform to `FluidResizableDelegate` */
extension NavigationRootNavigationController: FluidResizableTransitionDelegate {
    func transitionShouldPerformResizing() -> Bool { return true }
    func transitionMinimumMarginForResizing() -> CGFloat { return 64 }
    func transitionSnapPositionsForResizing() -> [CGFloat]? { return [0.0, 0.5, 1.0] }
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
        Logger()?.log("🚙💥", [
            "state: " + String(describing: state),
            "position: " + String(describing: position),
        ])
    }
}
