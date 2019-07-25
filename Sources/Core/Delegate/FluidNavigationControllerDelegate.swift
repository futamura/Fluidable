//
//  FluidNavigationControllerDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit

/**
  A class that conforms to `UINavigationControllerDelegate` protocol.
 */
open class FluidNavigationControllerDelegate: NSObject, FluidControllerDelegateCompatible {
    internal typealias ViewAnimator = FluidNavigationViewAnimator
    internal typealias PresentDriver = FluidNavigationPresentDriver
    internal typealias DismissDriver = FluidNavigationDismissDriver

    internal var viewAnimator: ViewAnimator
    internal var presentDriver: PresentDriver
    internal var dismissDriver: DismissDriver

    public override init() {
        Logger()?.log("🌕🛠", [])
        self.viewAnimator = FluidNavigationViewAnimator()
        self.presentDriver = .init(self.viewAnimator)
        self.dismissDriver = .init(self.viewAnimator)
        super.init()
    }

    /* TODO: Support custom animator */
//    public init<T: FluidViewAnimatorCompatible>(viewAnimator: T?) {
//        Logger()?.log("🌕🛠", [])
//        self.viewAnimator = viewAnimator ?? DefaultFluidNavigationViewAnimator()
//        self.presentDriver = .init(self.presenter)
//        self.dismissDriver = .init(self.presenter)
//        super.init()
//    }

    deinit { Logger()?.log("🌕🧹🧹🧹", []) }
}

extension FluidNavigationControllerDelegate: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     willShow viewController: UIViewController,
                                     animated: Bool) {
        Logger()?.log("🌕🎬", [
            "navigationController:".lpad() + String(describing: navigationController),
            "viewControllers:".lpad() + String(describing: navigationController.viewControllers),
            "viewController:".lpad() + String(describing: viewController),
            "animated:".lpad() + String(describing: animated),
        ])
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        Logger()?.log("🌕🎬", [
            "navigationController:".lpad() + String(describing: navigationController),
            "viewControllers:".lpad() + String(describing: navigationController.viewControllers),
            "viewController:".lpad() + String(describing: viewController),
            "animated:".lpad() + String(describing: animated),
        ])
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        Logger()?.log("🌕🎬", [
            "navigationController:".lpad() + String(describing: navigationController),
            "operation:".lpad() + String(describing: operation),
            "fromVC:".lpad() + String(describing: fromVC),
            "toVC:".lpad() + String(describing: toVC),
            "fromVC isSource:".lpad() + String(describing: fromVC.fluid.isFluidNavigationSourceViewController),
            "fromVC isDestination:".lpad() + String(describing: fromVC.fluid.isFluidNavigationDestinationViewController),
            "toVC isSource:".lpad() + String(describing: toVC.fluid.isFluidNavigationSourceViewController),
            "toVC isDestination:".lpad() + String(describing: toVC.fluid.isFluidNavigationDestinationViewController),
            "present:".lpad() + String(describing: fromVC.fluid.isFluidNavigationSourceViewController && toVC.fluid.isFluidNavigationDestinationViewController),
            "dismiss:".lpad() + String(describing: fromVC.fluid.isFluidNavigationDestinationViewController && toVC.fluid.isFluidNavigationSourceViewController),
        ])
        switch operation {
        case .push where fromVC.fluid.isFluidNavigationSourceViewController && toVC.fluid.isFluidNavigationDestinationViewController:
            return self.presentDriver
        case .pop where fromVC.fluid.isFluidNavigationDestinationViewController && toVC.fluid.isFluidNavigationSourceViewController:
            return self.dismissDriver
        case .none:
            return nil
        default:
            return nil
        }
    }

    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        Logger()?.log("🌕🎬", [
            "navigationController:".lpad() + String(describing: navigationController),
            "animationController:".lpad() + String(describing: animationController),
        ])
        switch animationController {
        case is FluidNavigationPresentDriver: return self.presentDriver
        case is FluidNavigationDismissDriver: return self.dismissDriver.asOptional()
        default: return nil
        }
    }
}

public extension FluidNavigationControllerDelegate {
    /** A function that disposes all objects belonging to navigations. */
    internal func dispose() {
        Logger()?.log("🌕🗑🗑🗑", [])
        self.presentDriver.stopObservingGestures()
        self.presentDriver.dispose()
        self.dismissDriver.stopObservingGestures()
        self.dismissDriver.dispose()
        self.viewAnimator.invalidate(willRemoveContainer: true)
    }
}
