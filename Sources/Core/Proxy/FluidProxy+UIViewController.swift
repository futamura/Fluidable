//
//  FluidProxy+UIViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The proxy methods for `Fluidable`.
 */
extension FluidProxy where Base: UIViewController {
    internal var isFluidNavigationSourceNavigationController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidNavigationRootNavigationControllerDelegate
    }

    internal var isFluidNavigationSourceViewController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidNavigationSourceViewControllerDelegate
    }

    internal var isFluidNavigationDestinationViewController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidNavigationDestinationViewControllerDelegate
    }

    internal var isFluidTransitionDestinationNavigationController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidTransitionRootNavigationControllerDelegate
    }

    internal var isFluidTransitionSourceViewController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidTransitionSourceViewControllerDelegate
    }

    internal var isFluidTransitionDestinationViewController: Bool {
        guard let fluidable: Fluidable = self.base as? Fluidable else { return false }
        return fluidable.fluidDelegate is FluidTransitionDestinationViewControllerDelegate
    }
}

extension FluidProxy where Base: UIViewController {
    internal var navigationControllerDelegate: FluidNavigationControllerDelegate? {
        if let nc: Fluidable & UINavigationController = self.base as? Fluidable & UINavigationController {
            return nc.delegate as? FluidNavigationControllerDelegate
        } else if let vc: Fluidable & UIViewController = self.base as? Fluidable & UIViewController {
            return vc.navigationController?.delegate as? Fluidable & FluidNavigationControllerDelegate
        } else {
            return nil
        }
    }

    internal var viewControllerTransitionDelegate: FluidViewControllerTransitioningDelegate? {
        if let nc: Fluidable & UINavigationController = self.base as? Fluidable & UINavigationController {
            return nc.transitioningDelegate as? FluidViewControllerTransitioningDelegate
        } else if let vc: Fluidable & UIViewController = self.base as? Fluidable & UIViewController {
            return vc.transitioningDelegate as? FluidViewControllerTransitioningDelegate
        } else {
            return nil
        }
    }

    internal var navigationPresentDriver: FluidNavigationPresentDriver? {
        return self.navigationControllerDelegate?.presentDriver
    }

    internal var navigationDismissDriver: FluidNavigationDismissDriver? {
        return self.navigationControllerDelegate?.dismissDriver
    }

    internal var transitionPresentDriver: FluidTransitionPresentDriver? {
        return self.viewControllerTransitionDelegate?.presentDriver
    }

    internal var transitionDismissDriver: FluidTransitionDismissDriver? {
        return self.viewControllerTransitionDelegate?.dismissDriver
    }
}

//extension FluidProxy where Base: UIViewController {
//    /** The `FluidPresentationStyle` value that indicates the presentation style. */
//    public var presentationStyle: FluidPresentationStyle {
//        if let delegate: FluidNavigationControllerDelegate = self.navigationControllerDelegate {
//            return delegate.presentDriver.presentationStyle
//        } else if let delegate: FluidViewControllerTransitioningDelegate = self.viewControllerTransitionDelegate {
//            return delegate.presentDriver.presentationStyle
//        } else {
//            return .fluid(behavior: .all)
//        }
//    }
//
//    /** The `TimeInterval` value that indicates the duration of the presentation transition. */
//    public var presentDuration: TimeInterval {
//        if let driver: FluidNavigationPresentDriver = self.navigationPresentDriver {
//            return driver.presentDuration
//        } else if let driver: FluidTransitionPresentDriver = self.transitionPresentDriver {
//            return driver.presentDuration
//        } else {
//            return FluidConst.defaultPresentDuration
//        }
//    }
//
//    /** The `TimeInterval` value that indicates the duration of the dismissal transition. */
//    public var dismissDuration: TimeInterval {
//        if let driver: FluidNavigationDismissDriver = self.navigationDismissDriver {
//            return driver.dismissDuration
//        } else if let driver: FluidTransitionDismissDriver = self.transitionDismissDriver {
//            return driver.dismissDuration
//        } else {
//            return FluidConst.defaultDismissDuration
//        }
//    }
//
//    /** The `FluidAnimatorEasing` value that indicates the easing type of the presentation transition. */
//    public var presentEasing: FluidAnimatorEasing {
//        if let driver: FluidNavigationPresentDriver = self.navigationPresentDriver {
//            return driver.presentEasing
//        } else if let driver: FluidTransitionPresentDriver = self.transitionPresentDriver {
//            return driver.presentEasing
//        } else {
//            return .linear
//        }
//    }
//
//    /** The `FluidAnimatorEasing` value that indicates the easing type of the dismissal transition. */
//    public var dismissEasing: FluidAnimatorEasing {
//        if let driver: FluidNavigationDismissDriver = self.navigationDismissDriver {
//            return driver.dismissEasing
//        } else if let driver: FluidTransitionDismissDriver = self.transitionDismissDriver {
//            return driver.dismissEasing
//        } else {
//            return .linear
//        }
//    }
//}

extension FluidProxy where Base: UIViewController {
    /** The `FluidInitialFrameDimension` value that indicates the initial dimension. */
    public var navigationInitialDimension: FluidInitialFrameDimension? {
        if let driver: FluidNavigationPresentDriver = self.navigationPresentDriver {
            return driver.initialDimension
        } else {
            return nil
        }
    }

    /** The `FluidFinalFrameDimension` value that indicates the final dimension. */
    public var navigationFinalDimension: FluidFinalFrameDimension? {
        if let driver: FluidNavigationPresentDriver = self.navigationPresentDriver {
            return driver.finalDimension
        } else {
            return nil
        }
    }

    /** The `CGRect` value that indicates the initial frame. */
    public func navigationInitialFrame() -> CGRect? {
        return self.navigationInitialDimension?.frame()
    }

    /** The `CGRect` value that indicates the final frame. */
    public func navigationFinalFrame(for containerSize: CGSize? = nil) -> CGRect? {
        return self.navigationFinalDimension?.frame(for: containerSize)
    }
}

extension FluidProxy where Base: UIViewController {
    /** The `FluidInitialFrameDimension` value that indicates the initial dimension. */
    public var transitionInitialDimension: FluidInitialFrameDimension? {
        if let driver: FluidTransitionPresentDriver = self.transitionPresentDriver {
            return driver.initialDimension
        } else {
            return nil
        }
    }

    /** The `FluidFinalFrameDimension` value that indicates the final dimension. */
    public var transitionFinalDimension: FluidFinalFrameDimension? {
        if let driver: FluidTransitionPresentDriver = self.transitionPresentDriver {
            return driver.finalDimension
        } else {
            return nil
        }
    }

    /** The `CGRect` value that indicates the initial frame. */
    public func transitionInitialFrame() -> CGRect? {
        return self.transitionInitialDimension?.frame()
    }

    /** The `CGRect` value that indicates the final frame. */
    public func transitionFinalFrame(for containerSize: CGSize? = nil) -> CGRect? {
        return self.transitionFinalDimension?.frame(for: containerSize)
    }
}
