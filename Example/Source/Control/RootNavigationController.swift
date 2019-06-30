//
//  RootNavigationController.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import UIKit
import Fluidable

class RootNavigationController: UINavigationController {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        Logger()?.log("🤴🛠", [])
        /* IMPORTANT: 🌊 Enable Fluidable */
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
}
