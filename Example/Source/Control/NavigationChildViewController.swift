//
//  NavigationChildViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `Fluidable` protocol */
class NavigationChildViewController: NavigationBaseViewController, Fluidable {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dismissImageView: UIImageView!

    /** Dummy value to prevent UIViewPropertyAnimator from finishing immediately. */
    @objc dynamic var transitionProgress: CGFloat = 0

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🚗🛠", [])
        self.fluidDelegate = self
    }

    func configure(modelIndex: Int, imageIndex: Int? = nil) {
        super.configure(modelIndex: modelIndex)
        Logger()?.log("🚗🛠", [
            "modelIndex:".lpad() + String(describing: modelIndex),
            "modelIndex:".lpad() + String(describing: modelIndex),
        ])
        if let imageIndex = imageIndex {
            self.imageHeightConstraint.constant = 284
            self.imageView.image = UIImage(row: imageIndex, size: .medium)
        } else {
            self.imageHeightConstraint.constant = 0
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        Logger()?.log("🚗💥", [])
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Logger()?.log("🚗💥", [])
        self.navigationController?.setNavigationBarHidden(false, animated: false)
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
}

/* IMPORTANT: 🌊 Conform to `FluidNavigationDestinationConfigurationDelegate` */
extension NavigationChildViewController: FluidNavigationDestinationConfigurationDelegate {
    func navigationAllowsInteractiveDismiss(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> Bool { return true }

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

/* IMPORTANT: 🌊 Conform to `FluidNavigationActionDelegate` */
extension NavigationChildViewController: FluidNavigationDestinationActionDelegate {
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

/* IMPORTANT: 🌊 Conform to `FluidTransitionDestinationConfigurationDelegate` */
extension NavigationChildViewController: FluidTransitionDestinationConfigurationDelegate {
    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source:" + String(describing: source),
            "destination:" + String(describing: destination),
            "navigation:" + String(describing: navigation),
        ])
        return nil
    }

    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        Logger()?.log("🚗💥", [
            "source:" + String(describing: source),
            "destination:" + String(describing: destination),
            "navigation:" + String(describing: navigation),
        ])
        guard transitionStyle.isFluid else { return nil }
        guard let image: UIImage = (source as? RootViewController)?.selectedImage else { return nil }
        var animators: [FluidAnimatorCompatible] = [FluidAnimatorCompatible]()
        self.transitionProgress = 0
        self.dismissImageView.image = image
        self.dismissImageView.alpha = 0
        self.dismissImageView.isHidden = false
        let imageAnimator: FluidPropertyAnimator = .init(duration: duration, easing: easing, id: "destinationImageAnimator (Dismiss)")
        imageAnimator.add({ [weak self] in
            guard let `self`: NavigationChildViewController = self else { return }
            self.transitionProgress = 1
            self.dismissImageView.alpha = 1
        })
        animators.append(imageAnimator)
        return animators
    }
}

/* IMPORTANT: 🌊 Conform to `FluidTransitionDestinationActionDelegate` */
extension NavigationChildViewController: FluidTransitionDestinationActionDelegate {
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
        guard transitionStyle.isFluid else { return }
        switch state {
        case .begin:  self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    }
}
