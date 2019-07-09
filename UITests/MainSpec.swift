//
//  MainSpec.swift
//  FluidableUITests
//
//  Created by kojirof on 2019/07/04.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
import AutoMate

@testable import Fluidable

class MainSpec: QuickSpec {
    var env: String {
        return """
               {
               "isTesting": \(true),
               }
               """
    }

    override func spec() {
        Logger()?.log("🧪", [
        ])
        var app: XCUIApplication!
        beforeEach {
            app = XCUIApplication()
            self.continueAfterFailure = false
            app.setEnv(self.env)
            app.launch()
        }
        afterEach { metadata in
            app.terminate()
        }
        describe("Main") {
            RootModel.testCases.forEach { (model: RootModel) in
                context(model.description) {
//                    it("AnimatedPresent_AnimatedDismiss") {
//                        self.presentWithAnimation(app: app, model: model)
//                        self.dismissByTappingCloseButton(app: app, model: model)
//                    }
                    it("AnimatedPresent_InteractiveDismiss") {
                        self.presentWithAnimation(app: app, model: model)
                        self.dismissWithInteraction(app: app, model: model)
                    }
                }
            }
        }
    }

    func presentWithAnimation(app: XCUIApplication, model: RootModel) {
        /* NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        /* NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        while (true) {
            collectionCell = collectionView.cells.element(matching: .cell, identifier: model.rootCellAccessibilityIdentifier)
            if collectionCell.isVisible {
                Logger()?.log("🧪", [
                    "model.rootCellAccessibilityIdentifier:".lpad(64) + String(describing: model.rootCellAccessibilityIdentifier),
                    "collectionCell.identifier:".lpad(64) + String(describing: collectionCell.identifier),
                ])
                collectionCell.tap()
                break
            } else {
                collectionView.swipe(from: CGVector(dx: 0.5, dy: 0.75), to: CGVector(dx: 0.5, dy: 0.25))
//                if let indexOfLastVisibleCell: Int = collectionView.indexOfLastVisibleCell {
//                    let indexOfNextVisibleCell: Int = indexOfLastVisibleCell + 1
//                    let nextVisibleCell: XCUIElement = collectionView.cells.element(boundBy: indexOfNextVisibleCell)
//                    collectionView.swipe(to: nextVisibleCell)
//                }
            }
        }
        usleep(sec: 1.5)
    }

    func dismissByTappingCloseButton(app: XCUIApplication, model: RootModel) {
        let button: XCUIElement = app.buttons.element(matching: .button, identifier: model.overlayCloseButtonAccessibilityIdentifier)
        expect(button.isVisible).toEventually(beTrue(), timeout: 10)
        button.tap()
        usleep(sec: 1.5)
    }

    func dismissWithInteraction(app: XCUIApplication, model: RootModel) {
        print(app.debugDescription)
        let visibleView: XCUIElement = app.otherElements.element(matching: .other, identifier: model.visibleControllerViewAccessibilityIdentifier)
        Logger()?.log("🧪", [
            "model.visibleControllerViewAccessibilityIdentifier:".lpad(64) + String(describing: model.visibleControllerViewAccessibilityIdentifier),
        ])
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
    }

    func execute(app: XCUIApplication, model: RootModel) {
        switch model {
        case .navigationFluidModal:
            break
        case .navigationFluidFullScreen:
            break
        case .navigationDrawerTop:
            break
        case .navigationDrawerBottom:
            break
        case .navigationDrawerLeft:
            break
        case .navigationDrawerRight:
            break
        case .navigationSlideTop:
            break
        case .navigationSlideBottom:
            break
        case .navigationSlideLeft:
            break
        case .navigationSlideRight:
            break
        case .transitionFluidModal:
            break
        case .transitionFluidFullScreen:
            break
        case .transitionDrawerTop:
            break
        case .transitionDrawerBottom:
            break
        case .transitionDrawerLeft:
            break
        case .transitionDrawerRight:
            break
        case .transitionSlideTop:
            break
        case .transitionSlideBottom:
            break
        case .transitionSlideLeft:
            break
        case .transitionSlideRight:
            break
        }
    }
}
