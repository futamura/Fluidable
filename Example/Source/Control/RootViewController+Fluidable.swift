//
//  RootViewController+Fluidable.swift
//  Example
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

/* IMPORTANT: 🌊 Conform to `FluidDestinationConfigurationDelegate` */
extension RootViewController: FluidTransitionSourceConfigurationDelegate {
    func transitionPresentationStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                     with navigation: FluidNavigationController?) -> FluidTransitionStyle {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return .fluid(behavior: .all)
        }
        return dest.model.transitionStyle
    }

    func transitionBackgroundStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidBackgroundStyle {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return .none
        }
        return dest.model.backgroundStyle
    }

    func transitionPresentEasing(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return .none
        }
        return dest.model.presentEasing
    }

    func transitionDismissEasing(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> FluidAnimatorEasing? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return .none
        }
        return dest.model.dismissEasing
    }

    func transitionPresentDuration(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> TimeInterval? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return nil
        }
        return dest.model.presentDuration
    }

    public func transitionDismissDuration(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?) -> TimeInterval? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController else {
            return nil
        }
        return dest.model.dismissDuration
    }

    func transitionInitialDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?) -> FluidInitialFrameDimension? {
        Logger()?.log("👑💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return nil
        }
        switch model {
        case .transitionFluidModal, .navigationFluidModal:
            guard let info: (frame: CGRect, transform: CATransform3D) = self.selectedFrame else { return nil }
            return FluidInitialFrameDimension(for: self.transitionPresentationStyle(from: source, to: destination, with: navigation),
                                              contentOrigin: info.frame.origin, contentSize: info.frame.size, contentTransform: info.transform)
        case .transitionFluidFullScreen, .navigationFluidFullScreen:
            guard let info: (frame: CGRect, transform: CATransform3D) = self.selectedFrame else { return nil }
            return FluidInitialFrameDimension(for: self.transitionPresentationStyle(from: source, to: destination, with: navigation),
                                              contentOrigin: info.frame.origin, contentSize: info.frame.size, contentTransform: info.transform)
        case .transitionDrawerTop, .navigationDrawerTop, .transitionDrawerBottom, .navigationDrawerBottom,
             .transitionDrawerLeft, .navigationDrawerLeft, .transitionDrawerRight, .navigationDrawerRight:
            return nil
        case .transitionSlideTop, .navigationSlideTop, .transitionSlideBottom, .navigationSlideBottom,
             .transitionSlideLeft, .navigationSlideLeft, .transitionSlideRight, .navigationSlideRight:
            return nil
        }
    }

    func transitionFinalDestinationFrameDimension(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                                  with navigation: FluidNavigationController?) -> FluidFinalFrameDimension? {
        Logger()?.log("👑💥", [
            "source: " + String(describing: source),
            "destination: " + String(describing: destination),
            "navigation: " + String(describing: navigation),
        ])
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return nil
        }
        let minLength: CGFloat = min(self.view.frame.width, self.view.frame.height)
        let maxLength: CGFloat = max(self.view.frame.width, self.view.frame.height)
        switch model {
        case .transitionFluidModal, .navigationFluidModal:
            switch UIDevice.current.isPhone {
            case true:
                let width: CGFloat = minLength * 0.9
                return FluidFinalFrameDimension(for: self.transitionPresentationStyle(from: source, to: destination, with: navigation),
                                                portraitContentSize: CGSize(width: width, height: maxLength * 0.75),
                                                landscapeContentSize: CGSize(width: width, height: minLength * 0.95),
                                                portraitContentTransform: CATransform3D.identity, landscapeContentTransform: CATransform3D.identity)
            case false:
                let width: CGFloat = minLength * 0.6
                return FluidFinalFrameDimension(for: self.transitionPresentationStyle(from: source, to: destination, with: navigation),
                                                portraitContentSize: CGSize(width: width, height: maxLength * 0.8),
                                                landscapeContentSize: CGSize(width: width, height: minLength * 0.8),
                                                portraitContentTransform: CATransform3D.identity, landscapeContentTransform: CATransform3D.identity)
            }
        case .transitionFluidFullScreen, .navigationFluidFullScreen:
            return nil
        case .transitionDrawerTop, .navigationDrawerTop, .transitionDrawerBottom, .navigationDrawerBottom,
             .transitionDrawerLeft, .navigationDrawerLeft, .transitionDrawerRight, .navigationDrawerRight:
            switch UIDevice.current.isPhone {
            case true:  return nil
            case false: return FluidFinalFrameDimension(for: self.transitionPresentationStyle(from: source, to: destination, with: navigation),
                                                        portraitContentSize: CGSize(width: minLength * 0.6, height: maxLength * 0.5),
                                                        landscapeContentSize: CGSize(width: minLength * 0.6, height: minLength * 0.7),
                                                        portraitContentTransform: CATransform3D.identity, landscapeContentTransform: CATransform3D.identity)
            }
        case .transitionSlideTop, .navigationSlideTop, .transitionSlideBottom, .navigationSlideBottom,
             .transitionSlideLeft, .navigationSlideLeft, .transitionSlideRight, .navigationSlideRight:
            return nil
        }
    }

    func transitionInitialDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                                with navigation: FluidNavigationController?) -> FluidInitialFrameStyle? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return nil
        }
        return model.initialFrameStyle
    }

    func transitionFinalDestinationFrameStyle(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                              with navigation: FluidNavigationController?) -> FluidFinalFrameStyle? {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return nil
        }
        return model.finalFrameStyle
    }

    func transitionAdditionalPresentAnimations(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        return nil
    }

    func transitionAdditionalDismissAnimations(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?,
                                               initialDimension: FluidInitialFrameDimension, finalDimension: FluidFinalFrameDimension, initialStyle: FluidInitialFrameStyle, finalStyle: FluidFinalFrameStyle,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing) -> [FluidAnimatorCompatible]? {
        return nil
    }
}

/* IMPORTANT: 🌊 Conform to `FluidDestinationActionDelegate` */
extension RootViewController: FluidTransitionSourceActionDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return
        }
        switch model {
        case .transitionFluidModal, .navigationFluidModal,
             .transitionFluidFullScreen, .navigationFluidFullScreen:
            switch state {
            case .begin:
                guard let cell: RootBaseCollectionCell = self.selectedCell,
                      let navBar: UINavigationBar = self.navigationController?.navigationBar else { return }
                self.selectedCell?.isHidden = true
                /* NOTE: If the navigation bar overlaps the cell, hide the navigation bar to avoid that the dismissal animation jumps */
                let cellFrame: CGRect = cell.convert(cell.frame, to: navBar)
                if navBar.frame.intersects(cellFrame) { self.navigationController?.setNavigationBarHidden(true, animated: true) }
            case .cancel:
                self.selectedCell?.isHidden = false
            case .update, .end:
                break
            }
        case .transitionDrawerTop, .navigationDrawerTop, .transitionDrawerBottom, .navigationDrawerBottom,
             .transitionDrawerLeft, .navigationDrawerLeft, .transitionDrawerRight, .navigationDrawerRight:
            return
        case .transitionSlideTop, .navigationSlideTop, .transitionSlideBottom, .navigationSlideBottom,
             .transitionSlideLeft, .navigationSlideLeft, .transitionSlideRight, .navigationSlideRight:
            return
        }
    }

    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                               with navigation: FluidNavigationController?, on container: UIView?,
                                               transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                               state: FluidProgressState, progress: CGFloat) {
        guard let dest: RootModelReceivable & UIViewController = (navigation?.viewControllers.first ?? destination) as? RootModelReceivable & UIViewController,
              let model: RootModel = dest.model else {
            return
        }
        switch model {
        case .transitionFluidModal, .navigationFluidModal,
             .transitionFluidFullScreen, .navigationFluidFullScreen:
            switch state {
            case .begin, .cancel, .update:
                break
            case .end:
                self.selectedCell?.isHidden = false
                self.navigationController?.setNavigationBarHidden(false, animated: true)
            }
        case .transitionDrawerTop, .navigationDrawerTop, .transitionDrawerBottom, .navigationDrawerBottom,
             .transitionDrawerLeft, .navigationDrawerLeft, .transitionDrawerRight, .navigationDrawerRight:
            return
        case .transitionSlideTop, .navigationSlideTop, .transitionSlideBottom, .navigationSlideBottom,
             .transitionSlideLeft, .navigationSlideLeft, .transitionSlideRight, .navigationSlideRight:
            return
        }
    }

    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
    }

    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController,
                                                 with navigation: FluidNavigationController?, on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing,
                                                 state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {
    }
}

