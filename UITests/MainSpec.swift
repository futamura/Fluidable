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
        var app: XCUIApplication!
        beforeEach {
            app = XCUIApplication()
            self.continueAfterFailure = false
            app.setEnv(self.env)
            app.launch()
        }
        afterEach { metadata in
            app.terminate()
            XCUIDevice.shared.orientation = .portrait
        }
        let orientations: [UIDeviceOrientation] = [
            .portrait,
            .landscapeLeft,
        ]
        orientations.forEach { (orientation: UIDeviceOrientation) in
            XCUIDevice.shared.orientation = orientation
            describe(XCUIDevice.shared.testDescription(for: orientation)) {
                RootModel.testCases(for: orientation).forEach { (model: RootModel) in
                    context(model.description.capitalizingFirstLetter()) {
                        it("FinishAnimatedPresent_FinishAnimatedDismiss") {
                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
                            self.finishAnimatedDismissByTappingCloseButton(app: app, orientation: orientation, model: model)
                        }
//                        it("CancelAnimatedPresent") {
//                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
//                        }
//                        it("FinishInteractivePresent_FinishAnimatedDismiss") {
//                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
//                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismiss(app: app, orientation: orientation, model: model)
//                        }
//                        it("CancelInteractivePresent") {
//                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
//                        }
                        it("FinishAnimatedPresent_FinishInteractiveDismiss") {
                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
//                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
                            self.scrollToDismissiblePosition(app: app, orientation: orientation, model: model)
                            self.finishInteractiveDismiss(app: app, orientation: orientation, model: model)
                        }
                        it("FinishAnimatedPresent_FinishAnimatedDismissWithBackground") {
                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
                            self.pushViewController(app: app, orientation: orientation, model: model)
                            self.popViewControllerByTappingBackButton(app: app, orientation: orientation, model: model)
//                            print(app.debugDescription)
                            self.finishAnimatedDismissByTappingContainer(app: app, orientation: orientation, model: model)
                        }
//                        it("FinishAnimatedPresent_CancelInteractiveDismiss") {
//                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
////                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
//                            self.scrollToDismissiblePosition(app: app, orientation: orientation, model: model)
//                            self.cancelInteractiveDismiss(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismissByTappingCloseButton(app: app, orientation: orientation, model: model)
//                        }
                    }
                }
            }
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
