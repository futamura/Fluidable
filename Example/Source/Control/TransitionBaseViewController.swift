//
//  TransitionBaseViewController.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/08.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

class TransitionBaseViewController: UIViewController, RootModelReceivable {
    /** The value received from RootViewController */
    var modelIndex: Int = 0

    @IBOutlet weak var closeButton: CloseButton!

    func configure(modelIndex: Int) {
        self.modelIndex = modelIndex
        Logger()?.log("🚗💥", [
            "modelIndex:".lpad(64) + String(describing: modelIndex),
            "model:".lpad(64) + String(describing: self.model),
            "visibleControllerViewAccessibilityIdentifier:".lpad(64) + String(describing: self.model.visibleControllerViewAccessibilityIdentifier),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /* NOTE: Set accessibility */
        self.closeButton.accessibilityIdentifier = self.model.overlayCloseButtonAccessibilityIdentifier
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

extension TransitionBaseViewController {
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

extension TransitionBaseViewController {
    @IBAction func closeButtonDidTap(_ sender: Any) {
        Logger()?.log("🚗👆", [])
        self.dismiss(animated: true)
    }
}
