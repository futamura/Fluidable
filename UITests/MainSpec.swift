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
//        afterEach { metadata in
//            sleep(1)
//            app.terminate()
//        }
        RootModel.allCases.forEach { (model: RootModel) in
            describe(model.description) {
                context("SimplyPresentAndDismiss") {
                    it("Present") {
                        self.presentSimply(app: app, model: model)
                        self.dismissByTappingCloseButton(app: app, model: model)
                    }
//                    it("Dismiss") {
//                    }
                }
            }
        }
    }

    func presentSimply(app: XCUIApplication, model: RootModel) {
        /* NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        /* NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        while (true) {
            collectionCell = collectionView.cells.element(matching: .cell, identifier: model.rootCellAccessibilityIdentifier)
            if collectionCell.exists && collectionCell.isEnabled && collectionCell.isHittable {
                Logger()?.log("🧪", [
                    "model.cellAccessibilityIdentifier:".lpad(48) + String(describing: model.rootCellAccessibilityIdentifier),
                    "collectionCell.identifier:".lpad(48) + String(describing: collectionCell.identifier),
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
        sleep(1)
    }

    func dismissByTappingCloseButton(app: XCUIApplication, model: RootModel) {
        let button: XCUIElement = app.buttons.element(matching: .button, identifier: model.overlayCloseButtonAccessibilityIdentifier)
        Logger()?.log("🧪", [
            "button.exists:".lpad(48) + String(describing: button.exists.debugString),
        ])
        expect(button.exists && button.isEnabled && button.isHittable).toEventually(beTrue(), timeout: 10)
        button.tap()
        sleep(1)
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
