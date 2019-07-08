//
//  MainSpec.swift
//  FluidableUITests
//
//  Created by kojirof on 2019/07/04.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble

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
        /** NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        Logger()?.log("🧪", [
            "collectionView.exists:".lpad(48) + String(describing: collectionView.exists.debugString),
            "collectionView.isAccessibilityElement:".lpad(48) + String(describing: collectionView.isAccessibilityElement.debugString),
            "collectionView.identifier:".lpad(48) + String(describing: collectionView.identifier),
        ])
        /** NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        var retryCount: Int = 0
        let maxRetryCount: Int = 3
        while (true) {
            let firstCollectionCell: XCUIElement = app.collectionViews.children(matching: .cell).element(boundBy: 0)
            let secondCollectionCell: XCUIElement = app.collectionViews.children(matching: .cell).element(boundBy: 1)
            let thirdCollectionCell: XCUIElement = app.collectionViews.children(matching: .cell).element(boundBy: 3)
            collectionCell = app.collectionViews.cells.matching(identifier: model.cellAccessibilityIdentifier).element(boundBy: 0)
//            collectionCell = app.collectionViews.children(matching: .cell).matching(identifier: model.cellAccessibilityIdentifier).element
//            collectionCell = collectionView.cells.matching(identifier: model.cellAccessibilityIdentifier).element
//            collectionCell = self.collectionCellFor(app: app, identifier: model.cellAccessibilityIdentifier)
//            collectionCell = app.collectionViews.element.cells.element(matching: .cell, identifier: model.cellAccessibilityIdentifier)
//            collectionCell = collectionView.cells.firstMatch
//            collectionCell = app.collectionViews.children(matching: .cell).element(boundBy: 0)
//            collectionCell = app.children(matching: .any).matching(identifier: model.cellAccessibilityIdentifier).firstMatch
            Logger()?.log("🧪", [
                "retryCount:".lpad(48) + String(describing: retryCount),
                "model.cellAccessibilityIdentifier:".lpad(48) + String(describing: model.cellAccessibilityIdentifier),
//                "collectionView.cells.count:".lpad(48) + String(describing: collectionView.cells.count),
//                "collectionView.disclosedChildRows.count:".lpad(48) + String(describing: collectionView.disclosedChildRows.count),
                "collectionCell:".lpad(48) + String(describing: collectionCell),
                "collectionCell.identifier:".lpad(48) + String(describing: collectionCell.identifier),
                "collectionCell.isAccessibilityElement:".lpad(48) + String(describing: collectionCell.isAccessibilityElement.debugString),
                "collectionCell.exists:".lpad(48) + String(describing: collectionCell.exists.debugString),
                "collectionCell.isEnabled:".lpad(48) + String(describing: collectionCell.isEnabled.debugString),
                "collectionCell.isHittable:".lpad(48) + String(describing: collectionCell.isHittable.debugString),
                "firstCollectionCell.exists:".lpad(48) + String(describing: firstCollectionCell.exists.debugString),
                "firstCollectionCell.identifier:".lpad(48) + String(describing: firstCollectionCell.identifier),
                "secondCollectionCell.exists:".lpad(48) + String(describing: secondCollectionCell.exists.debugString),
                "secondCollectionCell.identifier:".lpad(48) + String(describing: secondCollectionCell.identifier),
                "thirdCollectionCell.exists:".lpad(48) + String(describing: thirdCollectionCell.exists.debugString),
                "thirdCollectionCell.identifier:".lpad(48) + String(describing: thirdCollectionCell.identifier),
            ])
            if collectionCell.exists && collectionCell.isEnabled && collectionCell.isHittable {
                collectionCell.tap()
                break
            } else {
                if retryCount < maxRetryCount {
                    retryCount += 1
                } else {
                    retryCount = 0
                    collectionView.swipeUp()
                    break
                }
                sleep(1)
            }
        }
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
