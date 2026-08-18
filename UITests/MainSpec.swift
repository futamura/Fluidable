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
                        if orientation == .portrait && model == .navigationFluidModal {
                            it("KeepRootNavigationVisibleAndAlignFluidModalContent") {
                                self.finishAnimatedPresent(app: app, orientation: orientation, model: model)
                                self.assertRootNavigationVisibleAndFluidModalContentAligned(app: app, model: model)
                            }
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

@MainActor final class FluidModalTableDismissalLayoutTests: XCTestCase {
    class TestFluidSourceViewController: UIViewController, Fluidable {}

    func testConstrainsTableCellLabelsToDismissTargetWidth() {
        let bundle = Bundle(for: FluidModalTableDismissalLayoutTests.self)
        let cell = UINib(nibName: "TableCell", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! TableCell
        cell.frame = CGRect(x: 0, y: 0, width: 430, height: 64)
        cell.contentView.frame = cell.bounds
        cell.configure(row: 0)
        cell.layoutIfNeeded()

        cell.layoutTextLabels(forContentWidth: 390)

        XCTAssertEqual(cell.titleLabel.lineBreakMode, .byTruncatingTail)
        XCTAssertEqual(cell.captionLabel.lineBreakMode, .byTruncatingTail)
        XCTAssertEqual(cell.titleLabel.frame.width,
                       390 - cell.titleLabel.frame.minX - 20,
                       accuracy: 0.5)
        XCTAssertLessThan(cell.titleLabel.frame.maxX, cell.contentView.frame.maxX)
    }

    func testUpdatesVisibleTableCellsWhileTheModalShrinks() {
        let model: RootModel = .navigationFluidFullScreen
        let bundle = Bundle(for: FluidModalTableDismissalLayoutTests.self)
        let navigation = UINib(nibName: "NavigationRootNavigationController", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! NavigationRootNavigationController
        let destination = UINib(nibName: "NavigationTableViewController", bundle: bundle)
            .instantiate(withOwner: nil, options: nil).first as! NavigationTableViewController
        let source: TestFluidSourceViewController = TestFluidSourceViewController()

        navigation.configure(modelIndex: model.rawValue)
        navigation.pushViewController(destination, animated: false)
        destination.configure(modelIndex: model.rawValue)
        destination.loadViewIfNeeded()
        source.loadViewIfNeeded()

        let animators: [FluidAnimatorCompatible] = destination.transitionAdditionalDismissAnimations(
            from: destination,
            to: source,
            with: navigation,
            on: UIView(frame: CGRect(x: 0, y: 0, width: 430, height: 930)),
            initialDimension: FluidInitialFrameDimension(for: model.transitionStyle,
                                                         contentOrigin: CGPoint(x: 20, y: 100),
                                                         contentSize: CGSize(width: 390, height: 700),
                                                         contentTransform: CATransform3DIdentity),
            finalDimension: FluidFinalFrameDimension(for: model.transitionStyle,
                                                     portraitContentSize: CGSize(width: 430, height: 930),
                                                     landscapeContentSize: CGSize(width: 930, height: 430),
                                                     portraitContentTransform: CATransform3DIdentity,
                                                     landscapeContentTransform: CATransform3DIdentity),
            initialStyle: model.initialFrameStyle!,
            finalStyle: model.finalFrameStyle!,
            transitionStyle: model.transitionStyle,
            duration: 0.5,
            easing: FluidAnimatorEasing.linear) ?? []

        XCTAssertTrue(animators.contains { $0.identifier == "cellLayoutAnimator (Dismiss)" })
    }
}

final class NavigationFluidFullScreenDismissUITests: XCTestCase {
    func testFinishAnimatedDismissWithTableContent() {
        let app: XCUIApplication = XCUIApplication()
        let orientation: UIDeviceOrientation = .portrait
        let model: RootModel = .navigationFluidFullScreen

        addTeardownBlock {
            app.terminate()
            XCUIDevice.shared.orientation = .portrait
        }

        XCUIDevice.shared.orientation = orientation
        app.setEnv(MainSpec.env)
        app.launch()

        MainSpec.finishAnimatedPresent(app: app, orientation: orientation, model: model)
        MainSpec.pushViewController(app: app, orientation: orientation, model: model)
        MainSpec.popViewControllerByTappingBackButton(app: app, orientation: orientation, model: model)
        MainSpec.finishAnimatedDismissByTappingContainer(app: app, orientation: orientation, model: model)
    }
}

final class RootThumbnailHeaderMarginUITests: XCTestCase {
    func testTableThumbnailHeaderTopMarginMatchesImageThumbnailHeader() {
        let app: XCUIApplication = XCUIApplication()
        addTeardownBlock {
            app.terminate()
            XCUIDevice.shared.orientation = .portrait
        }

        XCUIDevice.shared.orientation = .portrait
        app.setEnv(MainSpec.env)
        app.launch()

        let collectionView: XCUIElement = app.collectionViews.element(matching: .collectionView, identifier: "rootCollectionView")
        MainSpec.assertEventually(collectionView.exists)

        let baseline = headerTopMargin(in: collectionView, app: app, model: .navigationFluidModal)
        let targetModels: [RootModel] = [
            .navigationFluidFullScreen,
            .navigationDrawerBottom,
            .navigationSlideBottom,
            .transitionFluidFullScreen,
            .transitionDrawerBottom,
            .transitionSlideBottom
        ]

        for model in targetModels {
            let margin = headerTopMargin(in: collectionView, app: app, model: model)
            XCTAssertEqual(
                margin,
                baseline,
                accuracy: 2,
                "\(model.description) header top margin should match image thumbnail header"
            )
        }
    }

    private func headerTopMargin(in collectionView: XCUIElement, app: XCUIApplication, model: RootModel) -> CGFloat {
        let cell = bringCellIntoView(in: collectionView, app: app, model: model)
        let label = cell.staticTexts["Case \(String(format: "%02d", model.rawValue + 1))"]
        MainSpec.assertEventually(label.exists)

        return label.frame.minY - cell.frame.minY
    }

    private func bringCellIntoView(in collectionView: XCUIElement, app: XCUIApplication, model: RootModel) -> XCUIElement {
        let cell = collectionView.cells.element(matching: .cell, identifier: model.rootCellAccessibilityIdentifier)
        let label = cell.staticTexts["Case \(String(format: "%02d", model.rawValue + 1))"]
        for _ in 0..<60 {
            if cell.exists && cell.isVisible && label.exists {
                return cell
            }

            if cell.exists && cell.isVisible {
                let windowFrame = app.windows.element(boundBy: 0).frame
                let visibleCollectionFrame = collectionView.frame.intersection(windowFrame)
                if cell.frame.midY < visibleCollectionFrame.midY {
                    collectionView.swipeDown()
                } else {
                    collectionView.swipeUp()
                }
            } else {
                collectionView.swipeUp()
            }
        }

        XCTFail("Failed to bring \(model.rootCellAccessibilityIdentifier) into view")
        return cell
    }
}
