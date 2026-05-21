//
//  AutoMate+Ext.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/09.
//  Copyright © 2019 Gumob. All rights reserved.
//

import XCTest

enum SwipeDirection {
    case up
    case down
    case left
    case right

    func inverted() -> SwipeDirection {
        switch self {
        case .up:    return .down
        case .down:  return .up
        case .left:  return .right
        case .right: return .left
        }
    }
}

extension XCUIElement {
    var isVisible: Bool {
        return exists && isHittable && !frame.isEmpty
    }

    func swipe(from startVector: CGVector, to stopVector: CGVector) {
        let start = coordinate(withNormalizedOffset: startVector)
        let stop = coordinate(withNormalizedOffset: stopVector)
        start.press(forDuration: 0.05, thenDragTo: stop)
    }
}
