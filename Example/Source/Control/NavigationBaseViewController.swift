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
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = .init(title: "Close", style: .plain, target: self, action: #selector(closeButtonDidTap))
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
