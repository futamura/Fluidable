//
//  Fluidable+UIViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension Fluidable where Self: UINavigationController {
    @available(iOS 11, *)
    internal func updateSafeAreaForcibly() {
        guard !self.isBeingPresented && !self.isBeingDismissed,
              self.fluidDelegate is FluidTransitionRootNavigationControllerDelegate,
              let delegate: FluidViewControllerTransitioningDelegate = self.transitioningDelegate as? FluidViewControllerTransitioningDelegate,
              let param: FluidTransitionParameters = delegate.dismissDriver.parameters else { return }
//        Logger()?.log("🌊💥", [])
        switch param.presentationStyle {
        case .fluid, .scale:
            break
        case .slide(let direction):
            switch direction {
            case .fromTop:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .fromBottom:
                if self.view.frame.origin.y > 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .fromLeft, .fromRight: break
            }
        case .drawer(let drawerPosition):
            switch drawerPosition {
            case .top:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .bottom:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .left, .right: break
            }
        }
    }
}

extension Fluidable where Self: UIViewController {
    @available(iOS 11, *)
    internal func updateSafeAreaForcibly() {
        guard !self.isBeingPresented && !self.isBeingDismissed,
              self is UINavigationController == false,
              self.fluidDelegate is FluidTransitionDestinationViewControllerDelegate,
              let delegate: FluidViewControllerTransitioningDelegate = self.transitioningDelegate as? FluidViewControllerTransitioningDelegate,
              let param: FluidTransitionParameters = delegate.dismissDriver.parameters else { return }
//        Logger()?.log("🌊💥", [])
        switch param.presentationStyle {
        case .fluid, .scale:
            break
        case .slide(let direction):
            switch direction {
            case .fromTop:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .fromBottom:
                if self.view.frame.origin.y > 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .fromLeft, .fromRight: break
            }
        case .drawer(let drawerPosition):
            switch drawerPosition {
            case .top:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .bottom:
                if self.view.frame.origin.y < 0 {
                    let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
                    self.additionalSafeAreaInsets.top = statusBarHeight
                } else {
                    self.additionalSafeAreaInsets.top = 0
                }
            case .left, .right: break
            }
        }
    }
}

public protocol FluidNavigationBarCompatible: NSObjectProtocol {
    var preferredSize: CGSize { get }
}

public extension FluidNavigationBarCompatible where Self: UINavigationBar {
    func updateNavigationBarFrame() {
        guard #available(iOS 11.0, *),
              let nc: FluidNavigationController = self.navigationController as? FluidNavigationController,
              !nc.isNavigationBarHidden,
              let delegate: FluidViewControllerTransitioningDelegate = nc.transitioningDelegate as? FluidViewControllerTransitioningDelegate,
              let param: FluidTransitionParameters = delegate.dismissDriver.parameters,
              param.presentationStyle.isBottomDrawer || param.presentationStyle.isBottomSlide else { return }
        let statusBarHeight: CGFloat = UIApplication.shared.isStatusBarHidden ? 0 : UIApplication.shared.statusBarFrame.height
        let frameY: CGFloat = nc.view.frame.origin.y
        if param.presentationStyle.isBottomSlide {
            switch frameY {
            case 0:
                break
            default:
                self.frame = CGRect(x: 0, y: statusBarHeight, width: self.frame.width, height: self.frame.height)
                for subview: UIView in self.subviews {
                    let className: String = subview.className
                    if className.contains("UIBarBackground") {
                        subview.frame = CGRect(x: 0, y: -statusBarHeight, width: self.frame.width, height: self.frame.height + statusBarHeight)
                    } else if className.contains("UINavigationBarContentView") {
                        subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: subview.frame.height)
                        subview.sizeToFit()
                    }
                }
            }
        } else if param.presentationStyle.isBottomDrawer {
            switch frameY {
            case 0..<statusBarHeight:
                let diff: CGFloat = statusBarHeight - frameY
                self.frame = CGRect(x: 0, y: diff, width: self.frame.width, height: self.frame.height)
                for subview: UIView in self.subviews {
                    let className: String = subview.className
                    if className.contains("UIBarBackground") {
                        subview.frame = CGRect(x: 0, y: -diff, width: self.frame.width, height: self.frame.height + diff)
                    } else if className.contains("UINavigationBarContentView") {
                        subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: subview.frame.height)
                        subview.sizeToFit()
                    }
                }
            default:
                break
            }
        }
    }
}
