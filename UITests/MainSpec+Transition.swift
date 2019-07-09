//
//  MainSpec+Transition.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/09.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
import AutoMate

@testable import Fluidable

extension MainSpec {
    func presentWithAnimation(app: XCUIApplication, model: RootModel) {
        /* NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        /* NOTE: Scroll until the collection targetView is found */
        var collectionCell: XCUIElement!
        while (true) {
            collectionCell = collectionView.cells.element(matching: .cell, identifier: model.rootCellAccessibilityIdentifier)
            if collectionCell.isVisible {
                collectionCell.tap()
                break
            } else {
                collectionView.swipeUp()
            }
        }
        usleep(sec: 1.2)
    }

    func dismissWithAnimation(app: XCUIApplication, model: RootModel) {
        let button: XCUIElement = app.buttons.element(matching: .button, identifier: model.overlayCloseButtonAccessibilityIdentifier)
        expect(button.isVisible).toEventually(beTrue(), timeout: 10)
        button.tap()
        usleep(sec: 1.2)
    }

    func dismissWithInteraction(app: XCUIApplication, model: RootModel) {
        let option: InteractiveDismissOption = self.getInteractiveDismissOption(app: app, model: model)
        Logger()?.log("🧪", [
            "interact".lpad() + String(describing: option.interact?.exists),
            "direction".lpad() + String(describing: option.direction),
        ])
        if let interactView: XCUIElement = option.interact {
            /* NOTE: Check whether the view exists */
            expect(interactView.exists).toEventually(beTrue(), timeout: 10)
            /* NOTE: Scroll until scroll view reaches to bottom */
            if let targetView: XCUIElement = option.target {
                Logger()?.log("🧪", [
                    "target".lpad() + String(describing: targetView.exists),
                ])
                expect(targetView.exists).toEventually(beTrue(), timeout: 10)
                interactView.swipe(to: option.direction.inverted(), until: targetView.isVisible && interactView.frame.contains(targetView.frame))
            }
            usleep(sec: 1.0)
            /* NOTE: Perform dismiss interaction */
            switch option.direction {
            case .up: interactView.swipe(from: CGVector(dx: 0.5, dy: 0.8), to: CGVector(dx: 0.5, dy: 0.2))
            case .down: interactView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
            case .left: interactView.swipe(from: CGVector(dx: 0.8, dy: 0.5), to: CGVector(dx: 0.2, dy: 0.5))
            case .right: interactView.swipe(from: CGVector(dx: 0.2, dy: 0.5), to: CGVector(dx: 0.8, dy: 0.5))
            }
        }
        /* NOTE: Check whether the view controller already disappears */
        let visibleView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
        expect(visibleView.exists).toNotEventually(beTrue(), timeout: 10)
    }

    func dismissWithCancelInteraction(app: XCUIApplication, model: RootModel) {
//        print(app.debugDescription)
        let visibleView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
        expect(visibleView.exists).toEventually(beTrue(), timeout: 10)
        switch model {
        case .navigationFluidModal:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .navigationFluidFullScreen:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .navigationDrawerTop:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.8), to: CGVector(dx: 0.5, dy: 0.2))
        case .navigationDrawerBottom:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .navigationDrawerLeft:
            visibleView.swipe(from: CGVector(dx: 0.8, dy: 0.5), to: CGVector(dx: 0.2, dy: 0.5))
        case .navigationDrawerRight:
            visibleView.swipe(from: CGVector(dx: 0.2, dy: 0.5), to: CGVector(dx: 0.8, dy: 0.5))
        case .navigationSlideTop:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.8), to: CGVector(dx: 0.5, dy: 0.2))
        case .navigationSlideBottom:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .navigationSlideLeft:
            visibleView.swipe(from: CGVector(dx: 0.8, dy: 0.5), to: CGVector(dx: 0.2, dy: 0.5))
        case .navigationSlideRight:
            visibleView.swipe(from: CGVector(dx: 0.2, dy: 0.5), to: CGVector(dx: 0.8, dy: 0.5))
        case .transitionFluidModal:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .transitionFluidFullScreen:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .transitionDrawerTop:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.8), to: CGVector(dx: 0.5, dy: 0.2))
        case .transitionDrawerBottom:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .transitionDrawerLeft:
            visibleView.swipe(from: CGVector(dx: 0.8, dy: 0.5), to: CGVector(dx: 0.2, dy: 0.5))
        case .transitionDrawerRight:
            visibleView.swipe(from: CGVector(dx: 0.2, dy: 0.5), to: CGVector(dx: 0.8, dy: 0.5))
        case .transitionSlideTop:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.8), to: CGVector(dx: 0.5, dy: 0.2))
        case .transitionSlideBottom:
            visibleView.swipe(from: CGVector(dx: 0.5, dy: 0.2), to: CGVector(dx: 0.5, dy: 0.8))
        case .transitionSlideLeft:
            visibleView.swipe(from: CGVector(dx: 0.8, dy: 0.5), to: CGVector(dx: 0.2, dy: 0.5))
        case .transitionSlideRight:
            visibleView.swipe(from: CGVector(dx: 0.2, dy: 0.5), to: CGVector(dx: 0.8, dy: 0.5))
        }
        usleep(sec: 1.2)
    }

    func rotateAndRevertDevice(app: XCUIApplication, model: RootModel) {
        XCUIDevice.shared.orientation = XCUIDevice.shared.orientation.isPortrait ? .landscapeLeft : .portrait
        usleep(sec: 1.2)
        XCUIDevice.shared.orientation = XCUIDevice.shared.orientation.isPortrait ? .landscapeLeft : .portrait
        usleep(sec: 1.2)
    }
}

extension MainSpec {
    typealias InteractiveDismissOption = (interact: XCUIElement?, target: XCUIElement?, direction: SwipeDirection)
    func getInteractiveDismissOption(app: XCUIApplication, model: RootModel) -> InteractiveDismissOption {
        Logger()?.log("🧪", [
            "model".lpad() + String(describing: model),
            "model.className".lpad() + String(describing: model.className),
        ])
        return {
            switch model {
            case .navigationFluidModal, .transitionFluidModal, .navigationFluidFullScreen, .transitionFluidFullScreen,
                 .navigationDrawerBottom, .transitionDrawerBottom, .navigationSlideBottom, .transitionSlideBottom:

                let direction: SwipeDirection = .down

                switch model.className {

                case "NavigationCollectionViewController", "TransitionCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.parentCollectionViewAccessibilityIdentifier)
                    let targetView: XCUIElement = interactView.cells.element(boundBy: 0)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationMultiCollectionViewController", "TransitionMultiCollectionViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    let targetView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.parentScrollTopViewAccessibilityIdentifier)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationScrollViewController", "TransitionScrollViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    let targetView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.parentScrollTopViewAccessibilityIdentifier)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationTableViewController", "TransitionTableViewController":
                    let interactView: XCUIElement = app.tables.element(matching: .table, identifier: model.parentTableViewAccessibilityIdentifier)
                    let targetView: XCUIElement = interactView.cells.element(boundBy: 0)
                    return (interact: interactView, target: targetView, direction: direction)

                default: break
                }

                let interactView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
                return (interact: interactView, target: nil, direction: direction)

            case .navigationDrawerTop, .transitionDrawerTop, .navigationSlideTop, .transitionSlideTop:

                let direction: SwipeDirection = .up

                switch model.className {

                case "NavigationCollectionViewController", "TransitionCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.parentCollectionViewAccessibilityIdentifier)
                    let targetView: XCUIElement = interactView.cells.element(boundBy: interactView.cells.count - 1)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationMultiCollectionViewController", "TransitionMultiCollectionViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    let targetView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.parentScrollBottomViewAccessibilityIdentifier)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationScrollViewController", "TransitionScrollViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    let targetView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.parentScrollBottomViewAccessibilityIdentifier)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationTableViewController", "TransitionTableViewController":
                    let interactView: XCUIElement = app.tables.element(matching: .table, identifier: model.parentTableViewAccessibilityIdentifier)
                    guard let targetView: XCUIElement = interactView.cells.allElementsBoundByIndex.last else { return (interact: interactView, target: nil, direction: direction) }
                    return (interact: interactView, target: targetView, direction: direction)

                default: break
                }

                let interactView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
                return (interact: interactView, target: nil, direction: direction)

            case .navigationDrawerLeft, .transitionDrawerLeft, .navigationSlideLeft, .transitionSlideLeft:

                let direction: SwipeDirection = .left

                switch model.className {

                case "NavigationCollectionViewController", "TransitionCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.parentCollectionViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                case "NavigationMultiCollectionViewController", "TransitionMultiCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.childFirstCollectionViewAccessibilityIdentifier)
                    let targetView: XCUIElement = interactView.cells.element(boundBy: interactView.cells.count - 1)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationScrollViewController", "TransitionScrollViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                case "NavigationTableViewController", "TransitionTableViewController":
                    let interactView: XCUIElement = app.tables.element(matching: .table, identifier: model.parentTableViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                default: break
                }

                let interactView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
                return (interact: interactView, target: nil, direction: direction)

            case .navigationDrawerRight, .transitionDrawerRight, .navigationSlideRight, .transitionSlideRight:

                let direction: SwipeDirection = .right

                switch model.className {

                case "NavigationCollectionViewController", "TransitionCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.parentCollectionViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                case "NavigationMultiCollectionViewController", "TransitionMultiCollectionViewController":
                    let interactView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: model.childSecondCollectionViewAccessibilityIdentifier)
                    let targetView: XCUIElement = interactView.cells.element(boundBy: 0)
                    return (interact: interactView, target: targetView, direction: direction)

                case "NavigationScrollViewController", "TransitionScrollViewController":
                    let interactView: XCUIElement = app.scrollViews.element(matching: .scrollView, identifier: model.parentScrollViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                case "NavigationTableViewController", "TransitionTableViewController":
                    let interactView: XCUIElement = app.tables.element(matching: .table, identifier: model.parentTableViewAccessibilityIdentifier)
                    return (interact: interactView, target: nil, direction: direction)

                default: break
                }

                let interactView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
                return (interact: interactView, target: nil, direction: direction)
            }
        }()
    }
}
