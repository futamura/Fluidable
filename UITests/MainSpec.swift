//
//  MainSpec.swift
//  FluidableUITests
//
//  Created by Kojiro Futamura on 2019/07/04.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import XCTest

@testable import Fluidable

final class MainSpec: QuickSpec {
    static var env: String {
        return """
               {
               "isTesting": \(true),
               }
               """
    }

    override class func spec() {
        var app: XCUIApplication!
        afterEach { metadata in
            app?.terminate()
            XCUIDevice.shared.orientation = .portrait
        }
        let orientations: [UIDeviceOrientation] = [
            .portrait,
            .landscapeLeft,
        ]
        let allTestCases: [(orientation: UIDeviceOrientation, model: RootModel)] = orientations.flatMap { orientation in
            RootModel.testCases(for: orientation).map { model in
                (orientation: orientation, model: model)
            }
        }
        orientations.forEach { (orientation: UIDeviceOrientation) in
            let models = allTestCases.enumerated().compactMap { index, testCase -> RootModel? in
                guard testCase.orientation == orientation else { return nil }
                guard UITestShard.includes(testCaseIndex: index) else { return nil }
                return testCase.model
            }
            guard !models.isEmpty else { return }
            describe(XCUIDevice.shared.testDescription(for: orientation)) {
                beforeEach {
                    XCUIDevice.shared.orientation = orientation
                    usleep(sec: 1.0)
                    app = XCUIApplication()
                    app.setEnv(self.env)
                    app.launch()
                }
                models.forEach { (model: RootModel) in
                    context(model.description.capitalizingFirstLetter()) {
                        /* Fixed */
//                        it("FinishAnimatedPresent_FinishAnimatedDismiss") {
//                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
//                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismissByTappingCloseButton(app: app, orientation: orientation, model: model)
//                        }
                        /* FIXME: No way to perform interruptible transition */
//                        it("CancelAnimatedPresent") {
//                            self.cancelAnimatedPresent(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismissByTappingContainer(app: app, orientation: orientation, model: model)
//                        }
                        /* FIXME: No way to perform interruptible transition */
//                        it("FinishInteractivePresent_FinishAnimatedDismiss") {
//                            self.finishInteractivePresent(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismissByTappingCloseButton(app: app, orientation: orientation, model: model)
//                        }
                        /* FIXME: No way to perform interruptible transition */
//                        it("CancelInteractivePresent") {
//                            self.cancelAnimatedPresent(app: app, orientation: orientation, model: model)
//                            self.finishAnimatedDismissByTappingContainer(app: app, orientation: orientation, model: model)
//                        }
                        /* Fixed */
                        it("FinishAnimatedPresent_FinishInteractiveDismiss") {
                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
                            self.rotateAndRevertDevice(app: app, orientation: orientation, model: model)
                            self.scrollToDismissiblePosition(app: app, orientation: orientation, model: model)
                            self.finishInteractiveDismiss(app: app, orientation: orientation, model: model)
                        }
                        /* Fixed */
                        it("FinishAnimatedPresent_FinishAnimatedDismissWithBackground") {
                            self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
                            self.pushViewController(app: app, orientation: orientation, model: model)
                            self.popViewControllerByTappingBackButton(app: app, orientation: orientation, model: model)
                            self.finishAnimatedDismissByTappingContainer(app: app, orientation: orientation, model: model)
                        }
                        /* FIXME: No way to perform interruptible transition */
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

    private enum UITestShard {
        static let index = ProcessInfo.processInfo.environment["FLUIDABLE_UI_TEST_SHARD_INDEX"].flatMap(Int.init)
        static let total = ProcessInfo.processInfo.environment["FLUIDABLE_UI_TEST_SHARD_TOTAL"].flatMap(Int.init)

        static func includes(testCaseIndex: Int) -> Bool {
            guard let index = index,
                  let total = total,
                  total > 0,
                  index >= 0,
                  index < total else {
                return true
            }

            return testCaseIndex % total == index
        }
    }

    func execute(app: XCUIApplication, model: RootModel) {
        switch model {
        case .navigationFluidModal: break
        case .navigationFluidFullScreen: break
        case .navigationDrawerTop: break
        case .navigationDrawerBottom: break
        case .navigationDrawerLeft: break
        case .navigationDrawerRight: break
        case .navigationSlideTop: break
        case .navigationSlideBottom: break
        case .navigationSlideLeft: break
        case .navigationSlideRight: break
        case .transitionFluidModal: break
        case .transitionFluidFullScreen: break
        case .transitionDrawerTop: break
        case .transitionDrawerBottom: break
        case .transitionDrawerLeft: break
        case .transitionDrawerRight: break
        case .transitionSlideTop: break
        case .transitionSlideBottom: break
        case .transitionSlideLeft: break
        case .transitionSlideRight: break
        }
    }

}
