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

    func configure(modelIndex: Int) {
        self.modelIndex = modelIndex
        Logger()?.log("🚗💥", [
            "modelIndex:".lpad() + String(describing: modelIndex),
            "model:".lpad() + String(describing: self.model),
            "visibleControllerViewAccessibilityIdentifier:".lpad() + String(describing: self.model.visibleControllerViewAccessibilityIdentifier),
        ])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let buttonItem: UIBarButtonItem = .init(title: "Close", style: .plain, target: self, action: #selector(closeButtonDidTap))
        self.navigationItem.rightBarButtonItem = buttonItem
        /* NOTE: Set accessibility */
        buttonItem.accessibilityIdentifier = self.model.navigationCloseButtonAccessibilityIdentifier
        self.view.accessibilityIdentifier = self.model.visibleControllerViewAccessibilityIdentifier
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

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
