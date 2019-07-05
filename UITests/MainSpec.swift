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

    func execute(app: XCUIApplication, model: RootModel) {
        print("execute", app, model)
        /** NOTE: Find collection view */
        /* Wait until collection view is ready */
//        let collectionViews: XCUIElementQuery = app.collectionViews
//        expect(collectionViews.element.exists).toEventually(beTrue(), timeout: 30)
//        printf("collectionViews.element.exists", collectionViews.element.exists)
        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        expect(collectionView.exists).toEventually(beTrue(), timeout: 30)
        printf("collectionView.exists", collectionView.exists)
        printf("collectionView.isAccessibilityElement", collectionView.isAccessibilityElement)
        printf("collectionView.identifier", collectionView.identifier)
        /** NOTE: Scroll until the collection cell is found */
        var collectionCell: XCUIElement!
        while (true) {
            sleep(1)
//            collectionCell = collectionView.cells.element(matching: .cell, identifier: model.description)
            collectionCell = collectionView.cells.matching(identifier: model.description).element
            collectionCell = collectionView.cells.firstMatch
            printf("model.description", model.description)
            printf("collectionView.cells.count", collectionView.cells.count)
            printf("collectionCell", collectionCell)
            printf("collectionCell.description", collectionCell.description)
            printf("collectionCell.isAccessibilityElement", collectionCell.isAccessibilityElement)
            printf("collectionCell.exists", collectionCell.exists)
            printf("collectionCell.isEnabled", collectionCell.isEnabled)
            printf("collectionCell.isHittable", collectionCell.isHittable)
            if collectionCell.exists && collectionCell.isEnabled && collectionCell.isHittable { break }
            collectionView.swipeUp()
        }
        collectionCell.tap()
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

    override func spec() {
        describe("Main") {
            RootModel.allCases.forEach { (model: RootModel) in
                describe(model.description) {
                    var app: XCUIApplication!
                    beforeEach {
                        app = XCUIApplication()
                        app.setEnv(self.env)
                        self.continueAfterFailure = false
                        app.launch()
                    }
                    afterEach { metadata in
                        sleep(1)
                        app.terminate()
                    }
                    it("Execute") {
                        self.execute(app: app, model: model)
                    }
                }
            }
        }
    }
}
