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
        describe("Main") {
            var app: XCUIApplication!
            beforeEach {
                app = XCUIApplication()
                self.continueAfterFailure = false
                app.setEnv(self.env)
                app.launch()
            }
            RootModel.allCases.forEach { (model: RootModel) in
                describe(model.description) {
//                    afterEach { metadata in
//                        sleep(1)
//                        app.terminate()
//                    }
                    it("Execute") {
                        self.execute(app: app, model: model)
                    }
                }
            }
        }
    }

    func execute(app: XCUIApplication, model: RootModel) {
        Logger()?.log("🧪", [
            "app:".lpad(48) + String(describing: app),
            "model:".lpad(48) + String(describing: model),
        ])
        /* NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
//        let collectionView: XCUIElement = app.collectionViews.element
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        Logger()?.log("🧪", [
            "collectionView.exists:".lpad(48) + String(describing: collectionView.exists.debugString),
            "collectionView.identifier:".lpad(48) + String(describing: collectionView.identifier),
            "collectionView.cells:".lpad(48) + String(describing: collectionView.cells),
            "collectionView.cells.count:".lpad(48) + String(describing: collectionView.cells.count),
        ])
        /* NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        while (true) {
            collectionCell = collectionView.cells.element(matching: .cell, identifier: model.cellAccessibilityIdentifier)
            if collectionCell.exists && collectionCell.isEnabled && collectionCell.isHittable {
                Logger()?.log("🧪", [
                    "model.cellAccessibilityIdentifier:".lpad(48) + String(describing: model.cellAccessibilityIdentifier),
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

    func collectionCellFor(app: XCUIApplication, identifier: String) -> XCUIElement {
        let cellsQuery: XCUIElementQuery = app.collectionViews.children(matching: .cell)
        return cellsQuery.matching(NSPredicate(format: "identifier == '\(identifier)'")).element
    }
}
