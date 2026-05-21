//
//  Extensions.swift
//  FluidableUITests
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import XCTest

/**
 Extension
 */
extension XCUIApplication {
    func setEnv(_ config: String) {
        self.launchEnvironment["com.gumob.Fluidable.test.config"] = config
    }
}
