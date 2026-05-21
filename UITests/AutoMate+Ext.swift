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
        guard exists && !frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.intersects(frame)
    }

    func tapVisibleCenter() {
        let windowFrame = XCUIApplication().windows.element(boundBy: 0).frame
        let visibleFrame = frame.intersection(windowFrame)
        guard !visibleFrame.isNull && !visibleFrame.isEmpty else {
            tap()
            return
        }

        let offset = CGVector(
            dx: (visibleFrame.midX - frame.minX) / frame.width,
            dy: (visibleFrame.midY - frame.minY) / frame.height
        )
        coordinate(withNormalizedOffset: offset).tap()
    }

    func swipe(from startVector: CGVector, to stopVector: CGVector) {
        let start = coordinate(withNormalizedOffset: startVector)
        let stop = coordinate(withNormalizedOffset: stopVector)
        start.press(forDuration: 0.05, thenDragTo: stop)
    }
}
