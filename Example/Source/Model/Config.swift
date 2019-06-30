//
//  Config.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import Fluidable

class Config: CustomStringConvertible {
    var isShadowEnabled: Bool = true
    var transitionStyle: FluidTransitionStyle = .slide(direction: .fromRight)
    var backgroundStyle: FluidBackgroundStyle = .blur(radius: 8.0, color: .clear, alpha: 1.0)
    static let shared = Config()
    private init() {}

    var description: String {
        return "isShadowEnabled: \(isShadowEnabled) transitionStyle: \(transitionStyle) backgroundStyle: \(backgroundStyle)"
    }
}
