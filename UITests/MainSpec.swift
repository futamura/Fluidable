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

    override func setUp() {
        Logger()?.log("🧪", [
        ])
//        super.setUp()
        self.continueAfterFailure = false
    }

    override func spec() {
        Logger()?.log("🧪", [
        ])
        describe("Main") {
            RootModel.allCases.forEach { (model: RootModel) in
                describe(model.description) {
                    var app: XCUIApplication!
                    beforeEach {
                        app = XCUIApplication()
                        app.setEnv(self.env)
                        app.launch()
                    }
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
            "app:".lpad(48) + String(debug: app),
            "model:".lpad(48) + String(debug: model),
        ])
        /** NOTE: Wait until collection view is ready */
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 10)
        Logger()?.log("🧪", [
            "collectionView.exists:".lpad(48) + String(debug: collectionView.exists.debugString),
            "collectionView.isAccessibilityElement:".lpad(48) + String(debug: collectionView.isAccessibilityElement.debugString),
            "collectionView.identifier:".lpad(48) + String(debug: collectionView.identifier),
        ])
        let collectionView2: XCUIElement = app.tables.element(matching: .table, identifier: "rootCollectionView")
        expect(collectionView2.exists).toEventually(beTrue(), timeout: 10)
        Logger()?.log("🧪", [
            "collectionView2.exists:".lpad(48) + String(debug: collectionView2.exists.debugString),
            "collectionView2.isAccessibilityElement:".lpad(48) + String(debug: collectionView2.isAccessibilityElement.debugString),
            "collectionView2.identifier:".lpad(48) + String(debug: collectionView2.identifier),
        ])
        /** NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        var retryCount: Int = 0
        while (true) {
            sleep(1)
            collectionCell = app.collectionViews.element.cells.element(matching: .cell, identifier: model.description)
//            collectionCell = collectionView.cells.matching(identifier: model.description).element
//            collectionCell = collectionView.cells.firstMatch
//            let collectionCell2: XCUIElement = app.collectionViews.children(matching: .cell).element(boundBy: 0)
            Logger()?.log("🧪", [
                "retryCount:".lpad(48) + String(debug: retryCount),
                "model.description:".lpad(48) + String(debug: model.description),
                "collectionView.cells.count:".lpad(48) + String(debug: collectionView.cells.count),
                "collectionCell:".lpad(48) + String(debug: collectionCell),
                "collectionCell.identifier:".lpad(48) + String(debug: collectionCell.identifier),
                "collectionCell.isAccessibilityElement:".lpad(48) + String(debug: collectionCell.isAccessibilityElement.debugString),
                "collectionCell.exists:".lpad(48) + String(debug: collectionCell.exists.debugString),
                "collectionCell.isEnabled:".lpad(48) + String(debug: collectionCell.isEnabled.debugString),
                "collectionCell.isHittable:".lpad(48) + String(debug: collectionCell.isHittable.debugString),
                "app.children(matching: .any).count:".lpad(48) + String(debug: app.children(matching: .any).count),
                "collectionView.children.count:".lpad(48) + String(debug: collectionView.children(matching: .any).count),
                "elementType:".lpad(48) + String(debug: collectionView.children(matching: .cell).firstMatch.elementType),
//                "collectionCell2:".lpad(48) + String(debug: collectionCell2),
//                "collectionCell2.identifier:".lpad(48) + String(debug: collectionCell2.identifier),
//                "collectionCell2.isAccessibilityElement:".lpad(48) + String(debug: collectionCell2.isAccessibilityElement.debugString),
//                "collectionCell2.exists:".lpad(48) + String(debug: collectionCell2.exists.debugString),
//                "collectionCell2.isEnabled:".lpad(48) + String(debug: collectionCell2.isEnabled.debugString),
//                "collectionCell2.isHittable:".lpad(48) + String(debug: collectionCell2.isHittable.debugString),
//                "collectionViews.children(matching: .cell).allElementsBoundByIndex.count:".lpad(48) + String(debug: app.collectionViews.children(matching: .cell).allElementsBoundByIndex.count),
            ])
            if collectionCell.exists && collectionCell.isEnabled && collectionCell.isHittable {
                collectionCell.tap()
                break
            } else {
                if retryCount < 10 {
                    retryCount += 1
                } else {
                    retryCount = 0
                    collectionView.swipeUp()
                }
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
}
