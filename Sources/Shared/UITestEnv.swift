//
//  UITestEnv.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/10.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

struct UITestEnv: Codable {
    var isTesting: Bool = false
//    var orientation: Int = 0
//    var loadWhileDragging: Bool = true
//    var shouldFailLoad: Bool = false
//    var refreshDuration: TimeInterval = 4.0
//    var initialCellCount: Int = 24
//    var canPrepend: Bool = true
//    var canAppend: Bool = true
//    var showNavBar: Bool = true
//    var showToolBar: Bool = true

    static func getEnv() -> UITestEnv {
        let env: [String: String] = ProcessInfo.processInfo.environment
        let decoder = JSONDecoder()
        guard let json: Data = env["com.gumob.Fluidable.test.config"]?.data(using: .utf8),
              let info: UITestEnv = try? decoder.decode(UITestEnv.self, from: json) else { return UITestEnv() }
        return info
    }
}
