//
//  Config.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import Fluidable

@MainActor
class Config: CustomStringConvertible {
    var isShadowEnabled: Bool = true
    var transitionStyle: FluidTransitionStyle = .slide(direction: .fromRight)
    var backgroundStyle: FluidBackgroundStyle = .blur(radius: 8.0, color: .clear, alpha: 1.0)
    static let shared = Config()
    private init() {}

    /* `CustomStringConvertible` の要件は nonisolated なため、main thread のときだけ isolated な状態を読む */
    nonisolated var description: String {
        guard Thread.isMainThread else { return "Config" }
        return MainActor.assumeIsolated {
            "isShadowEnabled: \(isShadowEnabled) transitionStyle: \(transitionStyle) backgroundStyle: \(backgroundStyle)"
        }
    }
}
