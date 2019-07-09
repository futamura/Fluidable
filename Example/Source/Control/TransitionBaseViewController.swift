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
        /* NOTE: Set accessibility */
        self.view.accessibilityIdentifier = self.model.visibleControllerViewAccessibilityIdentifier
        self.closeButton?.accessibilityIdentifier = self.model.overlayCloseButtonAccessibilityIdentifier
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}

extension TransitionBaseViewController {
    @IBAction func closeButtonDidTap(_ sender: Any) {
        Logger()?.log("🚗👆", [])
        self.dismiss(animated: true)
    }
}
