//
//  FluidProgressView.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

internal class FluidProgressView: UIProgressLayerView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
        self.tag = FluidConst.progressViewTag
        self.isUserInteractionEnabled = false
    }

    deinit { Logger()?.log("😡🧹🧹🧹", []) }
}
