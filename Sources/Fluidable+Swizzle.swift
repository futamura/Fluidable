//
//  Fluidable+Swizzle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The `UIApplicationDelegate` extension.
 */
extension UIApplicationDelegate {
    /**
     The function that initializes `Fluidable`. This must be called with `AppDelegate.application(_ application:,launchOptions:)`.
     */
    public func FluidableInit() {
        Logger()?.log("🌊🛠", [])
        /* NOTE: UIViewController */
        Swizzle.instanceMethod(UIViewController.self,
                               from: #selector(UIViewController.viewWillTransition(to:with:)),
                               to: #selector(UIViewController.swizzle_viewWillTransition(to:with:)))
        if #available(iOS 11.0, *) {
            Swizzle.instanceMethod(UIViewController.self,
                                   from: #selector(UIViewController.viewSafeAreaInsetsDidChange),
                                   to: #selector(UIViewController.swizzle_viewSafeAreaInsetsDidChange))
        }
        Swizzle.instanceMethod(UIViewController.self,
                               from: #selector(UIViewController.updateViewConstraints),
                               to: #selector(UIViewController.swizzle_updateViewConstraints))
        Swizzle.instanceMethod(UIViewController.self,
                               from: #selector(UIViewController.traitCollectionDidChange(_:)),
                               to: #selector(UIViewController.swizzle_traitCollectionDidChange(_:)))
        Swizzle.instanceMethod(UIViewController.self,
                               from: #selector(UIViewController.viewWillLayoutSubviews),
                               to: #selector(UIViewController.swizzle_viewWillLayoutSubviews))
        Swizzle.instanceMethod(UIViewController.self,
                               from: #selector(UIViewController.viewDidLayoutSubviews),
                               to: #selector(UIViewController.swizzle_viewDidLayoutSubviews))
        /* NOTE: UINavigationController */
        Swizzle.instanceMethod(UINavigationController.self,
                               from: #selector(UINavigationController.viewDidDisappear),
                               to: #selector(UINavigationController.swizzle_navigation_viewDidDisappear))
        Swizzle.instanceMethod(UINavigationController.self,
                               from: #selector(UINavigationController.viewWillLayoutSubviews),
                               to: #selector(UINavigationController.swizzle_navigation_viewWillLayoutSubviews))
        Swizzle.instanceMethod(UINavigationController.self,
                               from: #selector(UINavigationController.viewDidLayoutSubviews),
                               to: #selector(UINavigationController.swizzle_navigation_viewDidLayoutSubviews))
        if #available(iOS 11.0, *) {
            Swizzle.instanceMethod(UINavigationBar.self,
                                   from: #selector(UINavigationBar.safeAreaInsetsDidChange),
                                   to: #selector(UINavigationBar.swizzle_navBar_safeAreaInsetsDidChange))
        }
        Swizzle.instanceMethod(UINavigationBar.self,
                               from: #selector(UINavigationBar.sizeThatFits),
                               to: #selector(UINavigationBar.swizzle_navBar_sizeThatFits))
        Swizzle.instanceMethod(UINavigationBar.self,
                               from: #selector(UINavigationBar.layoutSubviews),
                               to: #selector(UINavigationBar.swizzle_navBar_layoutSubviews))
    }
}

/**
 Swizzle method
 */
internal extension UIViewController {
    @objc func swizzle_viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        swizzle_viewWillTransition(to: size, with: coordinator)
        guard self is Fluidable else { return }
        guard let delegate: FluidViewControllerTransitioningDelegate = self.transitioningDelegate as? FluidViewControllerTransitioningDelegate else { return }
        Logger()?.log("🌊💥", [
            "coordinator: \(String(describing: coordinator))",
            "from: \(String(describing: coordinator.containerView.frame.size))",
            "to: \(String(describing: size))",
        ])
        delegate.dismissDriver.configureAndRunRotateAnimation(from: coordinator.containerView.frame.size,
                                                              to: size,
                                                              duration: coordinator.transitionDuration)
//        coordinator.animate(alongsideTransition: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
//        }, completion: { [weak self] (context: UIViewControllerTransitionCoordinatorContext) in
//        })
    }

    @available(iOS 11.0, *)
    @objc func swizzle_viewSafeAreaInsetsDidChange() {
        swizzle_viewSafeAreaInsetsDidChange()
    }

    @objc func swizzle_updateViewConstraints() {
        swizzle_updateViewConstraints()
    }

    @objc func swizzle_traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        swizzle_traitCollectionDidChange(previousTraitCollection)
    }

    @objc func swizzle_viewWillLayoutSubviews() {
        swizzle_viewWillLayoutSubviews()
        guard #available(iOS 11, *) else { return }
        if let nc: FluidNavigationController = self as? FluidNavigationController {
            nc.updateSafeAreaForcibly()
        } else if let vc: FluidDestinationViewController = self as? FluidDestinationViewController {
            vc.updateSafeAreaForcibly()
        }
    }

    @objc func swizzle_viewDidLayoutSubviews() {
        swizzle_viewDidLayoutSubviews()
    }
}

internal extension UINavigationController {
    @objc func swizzle_navigation_viewDidDisappear() {
        swizzle_navigation_viewDidDisappear()
//        AssociatedObject.remove(self)
    }

    @objc func swizzle_navigation_viewWillLayoutSubviews() {
        swizzle_navigation_viewWillLayoutSubviews()
    }

    @objc func swizzle_navigation_viewDidLayoutSubviews() {
        swizzle_navigation_viewDidLayoutSubviews()
    }
}

internal extension UINavigationBar {
    @objc func swizzle_navBar_safeAreaInsetsDidChange() {
        swizzle_navBar_safeAreaInsetsDidChange()
    }

    @objc func swizzle_navBar_sizeThatFits(_ size: CGSize) -> CGSize {
        guard let navBar: FluidNavigationBar = self as? FluidNavigationBar,
              self.navigationController is FluidNavigationController else { return swizzle_navBar_sizeThatFits(size) }
        return navBar.preferredSize
    }

    @objc func swizzle_navBar_layoutSubviews() {
        swizzle_navBar_layoutSubviews()
        (self as? FluidNavigationBar)?.updateNavigationBarFrame()
    }
}
