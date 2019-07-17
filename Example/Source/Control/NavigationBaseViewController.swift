//
//  NavigationBaseViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class NavigationBaseViewController: UIViewController, RootModelReceivable {
    /** The value received from RootViewController */
    var modelIndex: Int = 0

    @IBOutlet weak var closeButton: CloseButton!

    func configure(modelIndex: Int) {
        self.modelIndex = modelIndex
        /* NOTE: Set accessibility */
        self.closeButton?.accessibilityIdentifier = self.model.overlayCloseButtonAccessibilityIdentifier
        Logger()?.log("🚗💥", [
            "modelIndex:".lpad() + String(describing: modelIndex),
            "model:".lpad() + String(describing: self.model),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonItem: UIBarButtonItem = .init(title: "Close", style: .plain, target: self, action: #selector(closeButtonDidTap))
        self.navigationItem.rightBarButtonItem = buttonItem
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /* NOTE: Set accessibility */
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = self.model.navigationCloseButtonAccessibilityIdentifier
        self.view.accessibilityIdentifier = self.model.visibleControllerViewAccessibilityIdentifier
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        /* NOTE: Set accessibility */
        self.navigationItem.rightBarButtonItem?.accessibilityIdentifier = nil
        self.view.accessibilityIdentifier = nil
    }
}

extension NavigationBaseViewController {
    func configureConstraints(for subview: UIView) {
        Logger()?.log("🚗🛠", [
            "model: " + String(describing: self.model),
            "model.transitionStyle: " + String(describing: self.model.transitionStyle),
        ])
        switch self.model! {
        case .navigationFluidModal, .transitionFluidModal:
            subview.topAnchor.constraint(equalTo: self.view.topAnchor).activate()
            subview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).activate()
            subview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).activate()
            subview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).activate()
            self.closeButton?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).activate()
            self.closeButton?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).activate()
        default:
            if #available(iOS 11.0, *) {
                subview.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).activate()
                subview.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).activate()
                subview.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).activate()
                subview.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).activate()
                self.closeButton?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16).activate()
                self.closeButton?.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).activate()
            } else {
                subview.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).activate()
                subview.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).activate()
                subview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).activate()
                subview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).activate()
                let topMargin: CGFloat = {
                    switch self.model! {
                    case .navigationFluidFullScreen,
                         .transitionFluidFullScreen,
                         .navigationDrawerTop, .navigationDrawerLeft, .navigationDrawerRight,
                         .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
                         .transitionDrawerTop, .transitionDrawerLeft, .transitionDrawerRight,
                         .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
                        return UIApplication.shared.statusBarFrame.height + 16
                    case .navigationFluidModal,
                         .transitionFluidModal,
                         .navigationDrawerBottom, .transitionDrawerBottom:
                        return 16
                    }
                }()
                self.closeButton?.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor, constant: topMargin).activate()
                self.closeButton?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).activate()
            }
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
}

extension NavigationBaseViewController {
    @IBAction func closeButtonDidTap(_ sender: Any) {
        Logger()?.log("🚗👆", [])
        self.navigationController?.dismiss(animated: true)
    }

    @IBAction func nextDidTap(_ sender: Any) {
        Logger()?.log("🚗👆", ["sender:".lpad() + String(describing: sender)])
        let imageIndex: Int? = {
            if let index: Int = (sender as? IndexPath)?.row {
                return index
            } else if let index: Int = sender as? Int {
                return index
            } else {
                return nil
            }
        }()
        let vc: NavigationChildViewController = UINib.instantiate(nibName: NavigationChildViewController.className)
        vc.configure(modelIndex: self.modelIndex, imageIndex: imageIndex)
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
