//
//  UIKitSpec.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import Fluidable

final class UIKitSpec: QuickSpec {
    class TestView: UIView {
        var name: String?
        init(name: String) {
            super.init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            self.name = name
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    class TestInteractiveView: UIView, FluidInteractiveView {}

    class TrackingScrollView: UIScrollView {
        var isTrackingOverride: Bool = false

        override var isTracking: Bool {
            return self.isTrackingOverride
        }
    }

    class StubTapGestureRecognizer: UITapGestureRecognizer {
        var locationValue: CGPoint = .zero

        override func location(in view: UIView?) -> CGPoint {
            return self.locationValue
        }
    }

    class StubPanGestureRecognizer: UIPanGestureRecognizer {
        var locationValue: CGPoint = .zero
        var translationValue: CGPoint = .zero
        var velocityValue: CGPoint = .zero

        override func location(in view: UIView?) -> CGPoint {
            return self.locationValue
        }

        override func translation(in view: UIView?) -> CGPoint {
            return self.translationValue
        }

        override func velocity(in view: UIView?) -> CGPoint {
            return self.velocityValue
        }
    }

    class StubScreenEdgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer {
        var locationValue: CGPoint = .zero
        var translationValue: CGPoint = .zero
        var velocityValue: CGPoint = .zero

        override func location(in view: UIView?) -> CGPoint {
            return self.locationValue
        }

        override func translation(in view: UIView?) -> CGPoint {
            return self.translationValue
        }

        override func velocity(in view: UIView?) -> CGPoint {
            return self.velocityValue
        }
    }

    class TestGestureDelegate: NSObject, FluidGestureDelegate {
        var tapUpdateCount: Int = 0
        var panUpdateCount: Int = 0
        var edgePanUpdateCount: Int = 0

        func tapGestureDidUpdate(gesture: UITapGestureRecognizer) {
            self.tapUpdateCount += 1
        }

        func panGestureDidUpdate(gesture: UIPanGestureRecognizer) {
            self.panUpdateCount += 1
        }

        func edgePanGestureDidUpdate(gesture: UIScreenEdgePanGestureRecognizer) {
            self.edgePanUpdateCount += 1
        }
    }

    class TestAdaptiveInterface: AdaptiveInterface {
        var traitCollection: UITraitCollection = UITraitCollection()
        var adaptiveElements: [AdaptiveElement] = []
    }

    class AdaptiveUpdateRecorder {
        var labels: [String] = []
    }

    struct RecordingAdaptiveElement: AdaptiveElement {
        let traitCollection: UITraitCollection
        let label: String
        let recorder: AdaptiveUpdateRecorder

        func update(for incomingTraitCollection: UITraitCollection) {
            self.recorder.labels.append(self.label)
        }
    }

    class TestBlurredBackgroundView: FluidBlurredBackgroundView {
        var blurRadiusValues: [CGFloat] = []
        var colorTintValues: [UIColor?] = []
        var colorTintAlphaValues: [CGFloat] = []
        var scaleValues: [CGFloat] = []

        override var blurRadius: CGFloat {
            get { return blurRadiusValues.last ?? 0 }
            set { blurRadiusValues.append(newValue) }
        }

        override var colorTint: UIColor? {
            get { return colorTintValues.last ?? nil }
            set { colorTintValues.append(newValue) }
        }

        override var colorTintAlpha: CGFloat {
            get { return colorTintAlphaValues.last ?? 0 }
            set { colorTintAlphaValues.append(newValue) }
        }

        override var scale: CGFloat {
            get { return scaleValues.last ?? 0 }
            set { scaleValues.append(newValue) }
        }
    }

    class TestNavigationController: UINavigationController {
        var name: String?
        init(rootViewController: UIViewController, name: String) {
            super.init(rootViewController: rootViewController)
            self.name = name
            self.title = name
            self.view.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
            self.view.backgroundColor = .white
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "btn", style: .plain, target: nil, action: nil)
            self.navigationBar.backgroundColor = .white
            self.navigationBar.barTintColor = .white
            self.setNavigationBarHidden(false, animated: false)
        }
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    class TestViewController: UIViewController {
        var name: String?
        init(name: String) {
            super.init(nibName: nil, bundle: nil)
            self.name = name
            self.view.frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
            self.view.backgroundColor = .white
        }
        override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
            super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        }
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }

    class TestShadowLayerCoder: NSCoder {
        var floats: [String: Float] = [:]
        var bools: [String: Bool] = [:]

        override var allowsKeyedCoding: Bool { return true }

        override func encode(_ value: Float, forKey key: String) {
            floats[key] = value
        }

        override func encode(_ value: Bool, forKey key: String) {
            bools[key] = value
        }

        override func encode(_ objv: Any?, forKey key: String) {}
        override func encode(_ value: Double, forKey key: String) {}
        override func encode(_ value: Int, forKey key: String) {}
        override func encode(_ value: Int32, forKey key: String) {}
        override func encode(_ value: Int64, forKey key: String) {}
        override func encodeBytes(_ bytesp: UnsafePointer<UInt8>?, length lenv: Int, forKey key: String) {}

        override func decodeFloat(forKey key: String) -> Float {
            return floats[key] ?? 0
        }

        override func decodeBool(forKey key: String) -> Bool {
            return bools[key] ?? false
        }

        override func decodeObject(forKey key: String) -> Any? {
            return nil
        }

        override func containsValue(forKey key: String) -> Bool {
            return floats[key] != nil || bools[key] != nil
        }
    }

    override class func spec() {
        describe("UIKit") {
            describe("UIView") {
                let rootView: TestView = .init(name: "rootView")
                let childView0: TestView = .init(name: "childView0")
                rootView.addSubview(childView0)
                let childView0_0: TestView = .init(name: "childView0_0")
                childView0.addSubview(childView0_0)
                let childView0_0_0: TestView = .init(name: "childView0_0_0")
                childView0_0.addSubview(childView0_0_0)
                let childView0_0_1: TestView = .init(name: "childView0_0_1")
                childView0_0.addSubview(childView0_0_1)
                let childView0_0_2: TestView = .init(name: "childView0_0_2")
                childView0_0.addSubview(childView0_0_2)
                let childView0_1: TestView = .init(name: "childView0_1")
                childView0.addSubview(childView0_1)
                let childView0_2: TestView = .init(name: "childView0_2")
                childView0.addSubview(childView0_2)
                let childView0_3: TestView = .init(name: "childView0_3")
                childView0.addSubview(childView0_3)
                let childView0_4: TestView = .init(name: "childView0_4")
                childView0.addSubview(childView0_4)
                let childView1: TestView = .init(name: "childView1")
                rootView.addSubview(childView1)
                let childView1_0: TestView = .init(name: "childView1_0")
                childView1.addSubview(childView1_0)
                let childView1_0_0: TestView = .init(name: "childView1_0_0")
                childView1_0.addSubview(childView1_0_0)
                let childView1_1: TestView = .init(name: "childView1_1")
                childView1.addSubview(childView1_1)
                let childView1_2: TestView = .init(name: "childView1_2")
                childView1.addSubview(childView1_2)
                let childView1_3: TestView = .init(name: "childView1_3")
                childView1.addSubview(childView1_3)
                let childView2: TestView = .init(name: "childView2")
                rootView.addSubview(childView2)
                let childView2_0: TestView = .init(name: "childView2_0")
                childView2.addSubview(childView2_0)
                let childView2_1: TestView = .init(name: "childView2_1")
                childView2.addSubview(childView2_1)
                let childView2_2: TestView = .init(name: "childView2_2")
                childView2.addSubview(childView2_2)
                let childView2_3: TestView = .init(name: "childView2_3")
                childView2.addSubview(childView2_3)
                it("Hierarchy") {
                    expect(rootView.numberOfSuperview).to(equal(0))
                    expect(childView0.numberOfSuperview).to(equal(1))
                    expect(childView0_0.numberOfSuperview).to(equal(2))
                    expect(childView0_0_0.numberOfSuperview).to(equal(3))
                    do {
                        let mostTopView: TestView? = UIView.mostTopView(rootView,
                                                                        childView0,
                                                                        childView0_0,
                                                                        childView0_0_0).view as? TestView
                        expect(mostTopView?.name).to(match(rootView.name))
                    }
                    do {
                        let mostTopView: TestView? = UIView.mostTopView(rootView,
                                                                        childView0,
                                                                        childView0_0,
                                                                        childView0_0_0,
                                                                        childView1,
                                                                        childView1_0,
                                                                        childView0_1,
                                                                        childView1,
                                                                        childView1_0,
                                                                        childView1_0_0,
                                                                        childView2,
                                                                        childView2_0,
                                                                        childView2_1).view as? TestView
                        expect(mostTopView?.name).to(match(rootView.name))
                    }
                    do {
                        let mostTopView: TestView? = UIView.mostTopView(rootView,
                                                                        childView0,
                                                                        childView0_0,
                                                                        childView0_0_0,
                                                                        childView1,
                                                                        childView1_0,
                                                                        childView0_1,
                                                                        childView1,
                                                                        childView1_0,
                                                                        childView1_0_0,
                                                                        childView2,
                                                                        childView2_0,
                                                                        childView2_1).view as? TestView
                        expect(mostTopView?.name).to(match(rootView.name))
                    }
                }
            }
            describe("UIViewController") {
                let rootVC0: TestViewController = .init(name: "rootVC0")
                let rootVC1: TestViewController = .init(name: "rootVC1")
                let rootNC: TestNavigationController = .init(rootViewController: rootVC0, name: "rootNC")

                let childVC0: TestViewController = .init(name: "childVC0")
                let childVC1: TestViewController = .init(name: "childVC1")
                let childVC2: TestViewController = .init(name: "childVC2")
                let childNC: TestNavigationController = .init(rootViewController: childVC0, name: "childNC")

                let emptyView: TestView = .init(name: "emptyView")

                it("Hierarchy") {
                    rootNC.pushViewController(rootVC1, animated: false)
                    rootNC.present(childNC, animated: false)
                    childNC.pushViewController(childVC1, animated: false)
                    childNC.pushViewController(childVC2, animated: false)
                    rootNC.navigationBar.setNeedsLayout()
                    rootNC.navigationBar.layoutIfNeeded()
                    childNC.navigationBar.setNeedsLayout()
                    childNC.navigationBar.layoutIfNeeded()

                    expect(rootVC0.isRootViewController).to(beTrue())
                    expect(rootVC1.isRootViewController).to(beFalse())
                    expect(childVC0.isRootViewController).to(beTrue())
                    expect(childVC1.isRootViewController).to(beFalse())
                    expect(childVC2.isRootViewController).to(beFalse())

                    expect((rootNC.navigationBar.navigationController as? TestNavigationController)?.name).to(match(rootNC.name))
                    expect((rootVC0.view.firstViewController as? TestViewController)?.name).to(match(rootVC0.name))
                    expect((rootVC0.view.parentViewController as? TestViewController)?.name).to(match(rootVC0.name))
                    expect((rootVC1.view.firstViewController as? TestViewController)?.name).to(match(rootVC1.name))
                    expect((rootVC1.view.parentViewController as? TestViewController)?.name).to(match(rootVC1.name))
                    expect(rootNC.isNavigationBarHidden).to(beFalse())
                    expect(rootNC.navigationBar.navigationController).to(beAKindOf(TestNavigationController.self))
                    /* TODO: contentView and backgroundView should not be nil */
                    expect(rootNC.navigationBar).notTo(beNil())
//                    expect(rootNC.navigationBar.subviews.count).to(beGreaterThan(0))
//                    expect(rootNC.navigationBar.contentView).notTo(beNil())
//                    expect(rootNC.navigationBar.backgroundView).notTo(beNil())

                    expect((childNC.navigationBar.navigationController as? TestNavigationController)?.name).to(match(childNC.name))
                    expect((childVC0.view.firstViewController as? TestViewController)?.name).to(match(childVC0.name))
                    expect((childVC0.view.parentViewController as? TestViewController)?.name).to(match(childVC0.name))
                    expect((childVC1.view.firstViewController as? TestViewController)?.name).to(match(childVC1.name))
                    expect((childVC1.view.parentViewController as? TestViewController)?.name).to(match(childVC1.name))
                    expect((childVC2.view.firstViewController as? TestViewController)?.name).to(match(childVC2.name))
                    expect((childVC2.view.parentViewController as? TestViewController)?.name).to(match(childVC2.name))
                    expect(childNC.isNavigationBarHidden).to(beFalse())
                    expect(childNC.navigationBar.navigationController).to(beAKindOf(TestNavigationController.self))
                    /* TODO: contentView and backgroundView should not be nil */
                    expect(childNC.navigationBar).notTo(beNil())
//                    expect(childNC.navigationBar.subviews.count).to(beGreaterThan(0))
//                    expect(childNC.navigationBar.contentView).notTo(beNil())
//                    expect(childNC.navigationBar.backgroundView).notTo(beNil())

                    expect((emptyView.firstViewController as? TestViewController)?.name).to(beNil())
                    expect((emptyView.parentViewController as? TestViewController)?.name).to(beNil())
                }
                it("Description") {
                    expect(String(describing: UINavigationController.Operation.none)).to(match("none"))
                    expect(String(describing: UINavigationController.Operation.push)).to(match("push"))
                    expect(String(describing: UINavigationController.Operation.pop)).to(match("pop"))
                    expect(String(describing: UIBarPosition.any)).to(match("any"))
                    expect(String(describing: UIBarPosition.bottom)).to(match("bottom"))
                    expect(String(describing: UIBarPosition.top)).to(match("top"))
                    expect(String(describing: UIBarPosition.topAttached)).to(match("topAttached"))
                }
            }
            describe("FluidProxy") {
                it("keeps the original base object") {
                    let controller = CoreTestFluidViewController()

                    expect(controller.fluid.base).to(beIdenticalTo(controller))
                    expect(FluidProxy(controller).base).to(beIdenticalTo(controller))
                }

                it("classifies navigation delegate roles") {
                    let controller = CoreTestFluidViewController()
                    expect(controller.fluid.isFluidNavigationSourceNavigationController).to(beFalse())
                    expect(controller.fluid.isFluidNavigationSourceViewController).to(beFalse())
                    expect(controller.fluid.isFluidNavigationDestinationViewController).to(beFalse())

                    let rootDelegate = CoreTestNavigationRootDelegate()
                    controller.fluidDelegate = rootDelegate
                    expect(controller.fluid.isFluidNavigationSourceNavigationController).to(beTrue())

                    let sourceDelegate = CoreTestNavigationSourceDelegate()
                    controller.fluidDelegate = sourceDelegate
                    expect(controller.fluid.isFluidNavigationSourceViewController).to(beTrue())

                    let destinationDelegate = CoreTestNavigationDestinationDelegate()
                    controller.fluidDelegate = destinationDelegate
                    expect(controller.fluid.isFluidNavigationDestinationViewController).to(beTrue())
                }

                it("classifies transition delegate roles") {
                    let controller = CoreTestFluidViewController()
                    expect(controller.fluid.isFluidTransitionDestinationNavigationController).to(beFalse())
                    expect(controller.fluid.isFluidTransitionSourceViewController).to(beFalse())
                    expect(controller.fluid.isFluidTransitionDestinationViewController).to(beFalse())

                    let rootDelegate = CoreTestTransitionRootDelegate()
                    controller.fluidDelegate = rootDelegate
                    expect(controller.fluid.isFluidTransitionDestinationNavigationController).to(beTrue())

                    let sourceDelegate = CoreTestTransitionSourceDelegate()
                    controller.fluidDelegate = sourceDelegate
                    expect(controller.fluid.isFluidTransitionSourceViewController).to(beTrue())

                    let destinationDelegate = CoreTestTransitionDestinationDelegate()
                    controller.fluidDelegate = destinationDelegate
                    expect(controller.fluid.isFluidTransitionDestinationViewController).to(beTrue())
                }

                it("returns configured controller delegates and drivers") {
                    let navigation = CoreTestFluidNavigationController()
                    let navigationDelegate = FluidNavigationControllerDelegate()
                    navigation.delegate = navigationDelegate

                    expect(navigation.fluid.navigationControllerDelegate).to(beIdenticalTo(navigationDelegate))
                    expect(navigation.fluid.navigationPresentDriver).to(beIdenticalTo(navigationDelegate.presentDriver))
                    expect(navigation.fluid.navigationDismissDriver).to(beIdenticalTo(navigationDelegate.dismissDriver))

                    let controller = CoreTestFluidViewController()
                    let transitionDelegate = FluidViewControllerTransitioningDelegate()
                    controller.transitioningDelegate = transitionDelegate

                    expect(controller.fluid.viewControllerTransitionDelegate).to(beIdenticalTo(transitionDelegate))
                    expect(controller.fluid.transitionPresentDriver).to(beIdenticalTo(transitionDelegate.presentDriver))
                    expect(controller.fluid.transitionDismissDriver).to(beIdenticalTo(transitionDelegate.dismissDriver))
                }
            }
            describe("FluidViewControllerTransitioningDelegate") {
                it("selects transition drivers for valid source and destination roles") {
                    let delegate = FluidViewControllerTransitioningDelegate()
                    let source = CoreTestFluidViewController()
                    let destination = CoreTestFluidViewController()
                    let plainDestination = CoreTestFluidViewController()
                    let sourceDelegate = CoreTestTransitionSourceDelegate()
                    let destinationDelegate = CoreTestTransitionDestinationDelegate()

                    source.fluidDelegate = sourceDelegate
                    destination.fluidDelegate = destinationDelegate

                    expect(delegate.animationController(forPresented: destination,
                                                        presenting: source,
                                                        source: source) as? FluidTransitionPresentDriver)
                        .to(beIdenticalTo(delegate.presentDriver))
                    expect(delegate.animationController(forPresented: plainDestination,
                                                        presenting: source,
                                                        source: source)).to(beNil())
                    expect(delegate.animationController(forDismissed: destination) as? FluidTransitionDismissDriver)
                        .to(beIdenticalTo(delegate.dismissDriver))
                    expect(delegate.interactionControllerForPresentation(using: delegate.presentDriver) as? FluidTransitionPresentDriver)
                        .to(beIdenticalTo(delegate.presentDriver))
                    expect(delegate.interactionControllerForDismissal(using: delegate.dismissDriver)).to(beNil())
                    delegate.dismissDriver.isInteracting = true
                    expect(delegate.interactionControllerForDismissal(using: delegate.dismissDriver) as? FluidTransitionDismissDriver)
                        .to(beIdenticalTo(delegate.dismissDriver))
                }
            }
            describe("Core interactive drivers") {
                it("propagates present interaction lifecycle and stores animator gesture info") {
                    let fixture = makeCoreTestTransitionFixture()
                    let info = FluidGestureInfo(locationLocal: CGPoint(x: 12, y: 24),
                                                locationGlobal: CGPoint(x: 12, y: 24),
                                                translation: CGPoint(x: -40, y: 0),
                                                velocity: CGVector(dx: -2_000, dy: 0),
                                                direction: .leftMiddle)

                    fixture.presentDriver.beginInteractiveTransition(progress: 0.25, info: info)

                    expect(fixture.presentAnimator.interactionProgress).to(beCloseTo(0.25))
                    expect(fixture.presentAnimator.pausedInteractionProgress).to(beCloseTo(0.25))
                    expect(fixture.presentAnimator.resizePosition).to(beCloseTo(0))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))
                    expect(fixture.destinationDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))

                    fixture.presentDriver.currentInteractionProgress = 0.65
                    fixture.presentDriver.previousInteractionProgress = 0.25
                    fixture.presentDriver.updateInteractiveTransition(progress: 0.65, info: info)

                    expect(fixture.presentAnimator.interactionProgress).to(beCloseTo(0.65))
                    expect(fixture.presentAnimator.currentGestureInfo?.direction.description).to(equal("leftMiddle"))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update"]))

                    fixture.presentDriver.finishInteractiveTransition(isCancelled: true, progress: 0.65, info: info)

                    expect(fixture.presentAnimator.currentGestureInfo?.direction.description).to(equal("leftMiddle"))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "cancel"]))
                    expect(fixture.destinationDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "cancel"]))
                    expect(fixture.presentDriver.observingGesture).to(beNil())
                    expect(fixture.presentDriver.observingScrolls).to(beNil())
                }

                it("finishes present interaction without reversing") {
                    let fixture = makeCoreTestTransitionFixture()
                    let info = FluidGestureInfo(locationLocal: CGPoint(x: 8, y: 16),
                                                locationGlobal: CGPoint(x: 8, y: 16),
                                                translation: CGPoint(x: -60, y: 0),
                                                velocity: CGVector(dx: -2_400, dy: 0),
                                                direction: .leftMiddle)

                    fixture.presentDriver.beginInteractiveTransition(progress: 0.2, info: info)
                    fixture.presentDriver.finishInteractiveTransition(isCancelled: false, progress: 0.8, info: info)

                    expect(fixture.presentAnimator.interactionProgress).to(beCloseTo(0.8))
                    expect(fixture.presentAnimator.currentGestureInfo?.direction.description).to(equal("leftMiddle"))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "end"]))
                    expect(fixture.destinationDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "end"]))
                    expect(fixture.presentDriver.observingGesture).to(beNil())
                    expect(fixture.presentDriver.observingScrolls).to(beNil())
                }

                it("evaluates present interaction begin and finish conditions") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    seedGesture(fixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                velocity: CGVector(dx: -2_000, dy: 0))

                    expect(fixture.presentDriver.canBeginPresentInteraction()).to(beTrue())

                    fixture.presentDriver.observingGesture.currentVelocity = .zero
                    expect(fixture.presentDriver.canBeginPresentInteraction()).to(beFalse())

                    seedGesture(fixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: 0, y: 30),
                                velocity: CGVector(dx: -2_000, dy: 0))
                    expect(fixture.presentDriver.canBeginPresentInteraction()).to(beFalse())

                    let blockedFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight),
                                                                       allowInteractivePresent: false)
                    seedGesture(blockedFixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                velocity: CGVector(dx: -2_000, dy: 0))
                    expect(blockedFixture.presentDriver.canBeginPresentInteraction()).to(beFalse())

                    seedGesture(fixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                velocity: .zero)
                    expect(fixture.presentDriver.canFinishPresentInteraction(progress: FluidConst.normalProgressFinishThreshold - 0.01)).to(beFalse())
                    expect(fixture.presentDriver.canFinishPresentInteraction(progress: FluidConst.normalProgressFinishThreshold)).to(beTrue())

                    seedGesture(fixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                velocity: CGVector(dx: -2_000, dy: 0))
                    expect(fixture.presentDriver.canFinishPresentInteraction(progress: 0.01)).to(beTrue())

                    seedGesture(fixture.presentDriver.observingGesture,
                                averageVector: CGPoint(x: 30, y: 0),
                                velocity: CGVector(dx: -2_000, dy: 0))
                    expect(fixture.presentDriver.canFinishPresentInteraction(progress: 1)).to(beFalse())
                }

                it("calculates present interaction progress from paused progress and slide axis") {
                    let fromRight = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    fromRight.presentDriver.pausedInterruptibleFractionComplete = 0.2
                    seedGesture(fromRight.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                initialLocation: CGPoint(x: 200, y: 0),
                                currentLocation: CGPoint(x: 120, y: 0))

                    expect(fromRight.presentDriver.calculateInteractionProgress()).to(beCloseTo(0.45, within: 0.001))

                    seedGesture(fromRight.presentDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                initialLocation: CGPoint(x: 320, y: 0),
                                currentLocation: CGPoint(x: -320, y: 0))
                    expect(fromRight.presentDriver.calculateInteractionProgress()).to(beCloseTo(1, within: 0.001))

                    let fromLeft = makeCoreTestTransitionFixture(style: .slide(direction: .fromLeft))
                    fromLeft.presentDriver.pausedInterruptibleFractionComplete = 0.1
                    seedGesture(fromLeft.presentDriver.observingGesture,
                                averageVector: CGPoint(x: 30, y: 0),
                                initialLocation: CGPoint(x: 100, y: 0),
                                currentLocation: CGPoint(x: 260, y: 0))

                    expect(fromLeft.presentDriver.calculateInteractionProgress()).to(beCloseTo(0.6, within: 0.001))
                }

                it("drives present pan gesture interaction paths") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    let gesture = StubPanGestureRecognizer()
                    let observer = fixture.presentDriver.observingGesture!

                    fixture.presentDriver.interruptibleAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear)
                    observer.baseFrame = fixture.destinationViewController.view.frame
                    observer.panGestureView = fixture.destinationViewController.view
                    observer.currentLocation = CGPoint(x: 220, y: 0)
                    observer.currentTranslation = CGPoint(x: -40, y: 0)
                    observer.currentVelocity = CGVector(dx: -2_000, dy: 0)
                    observer.translationHistory = [CGPoint(x: -40, y: 0), .zero]

                    fixture.presentDriver.beginPanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.presentDriver.isInteracting).to(beTrue())
                    expect(fixture.presentDriver.pausedInterruptibleFractionComplete).to(beCloseTo(0))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))

                    observer.currentLocation = CGPoint(x: 80, y: 0)
                    observer.currentTranslation = CGPoint(x: -140, y: 0)
                    observer.translationHistory = [CGPoint(x: -140, y: 0), .zero]
                    fixture.presentDriver.updatePanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.presentAnimator.interactionProgress).to(beCloseTo(0.4375, within: 0.001))
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update"]))

                    fixture.presentDriver.finishPanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.presentDriver.isInteracting).to(beFalse())
                    expect(fixture.presentDriver.isInteractionCancelled).to(beFalse())
                    expect(fixture.sourceDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "end"]))
                    expect(fixture.destinationDelegate.presentInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "end"]))
                    expect(fixture.presentDriver.observingGesture).to(beNil())
                }

                it("evaluates dismiss interaction progress and finish conditions") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    seedGesture(fixture.dismissDriver.observingGesture,
                                averageVector: CGPoint(x: 30, y: 0),
                                velocity: CGVector(dx: 2_000, dy: 0),
                                initialLocation: CGPoint(x: 20, y: 0),
                                currentLocation: CGPoint(x: 180, y: 0))

                    expect(fixture.dismissDriver.canBeginDismissInteraction(isEdgePan: false)).to(beTrue())
                    expect(fixture.dismissDriver.calculateTransitionProgress(isEdgePan: false)).to(beCloseTo(0.5, within: 0.001))
                    expect(fixture.dismissDriver.canFinishDismissInteraction(progress: FluidConst.normalProgressFinishThreshold)).to(beTrue())

                    seedGesture(fixture.dismissDriver.observingGesture,
                                averageVector: CGPoint(x: 30, y: 0),
                                velocity: CGVector(dx: 2_000, dy: 0))
                    expect(fixture.dismissDriver.canFinishDismissInteraction(progress: 0.01)).to(beTrue())

                    seedGesture(fixture.dismissDriver.observingGesture,
                                averageVector: CGPoint(x: -30, y: 0),
                                velocity: CGVector(dx: 2_000, dy: 0))
                    expect(fixture.dismissDriver.canBeginDismissInteraction(isEdgePan: false)).to(beFalse())
                    expect(fixture.dismissDriver.canFinishDismissInteraction(progress: 1)).to(beFalse())

                    let blockedFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight),
                                                                       allowInteractiveDismiss: false)
                    seedGesture(blockedFixture.dismissDriver.observingGesture,
                                averageVector: CGPoint(x: 30, y: 0),
                                velocity: CGVector(dx: 2_000, dy: 0))
                    expect(blockedFixture.dismissDriver.canBeginDismissInteraction(isEdgePan: false)).to(beFalse())
                }

                it("drives dismiss pan gesture interaction paths") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    let gesture = StubPanGestureRecognizer()
                    let observer = fixture.dismissDriver.observingGesture!

                    observer.baseFrame = fixture.destinationViewController.view.frame
                    observer.panGestureView = fixture.destinationViewController.view
                    observer.currentLocation = CGPoint(x: 20, y: 0)
                    observer.currentTranslation = CGPoint(x: 40, y: 0)
                    observer.currentVelocity = CGVector(dx: 2_000, dy: 0)
                    observer.translationHistory = [CGPoint(x: 40, y: 0), .zero]

                    fixture.dismissDriver.beginPanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.dismissDriver.isInteracting).to(beTrue())
                    expect(fixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))

                    observer.currentLocation = CGPoint(x: 180, y: 0)
                    observer.currentTranslation = CGPoint(x: 160, y: 0)
                    observer.translationHistory = [CGPoint(x: 160, y: 0), .zero]
                    fixture.dismissDriver.updatePanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.dismissDriver.interactionState).to(equal(.dismissing))
                    expect(fixture.dismissAnimator.interactionProgress).to(beCloseTo(0.5, within: 0.001))
                    expect(fixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update"]))

                    observer.currentLocation = CGPoint(x: 260, y: 0)
                    observer.currentTranslation = CGPoint(x: 240, y: 0)
                    observer.translationHistory = [CGPoint(x: 240, y: 0), .zero]
                    fixture.dismissDriver.finishPanGesture(gesture: gesture, isEdgePan: false)

                    expect(fixture.dismissDriver.isInteracting).to(beFalse())
                    expect(fixture.dismissDriver.isInteractionCancelled).to(beFalse())
                    expect(fixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "end"]))
                    expect(fixture.destinationDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "end"]))
                }

                it("begins dismiss interaction from a valid edge pan") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    let gesture = StubScreenEdgePanGestureRecognizer()
                    let observer = fixture.dismissDriver.observingGesture!

                    observer.baseFrame = fixture.destinationViewController.view.frame
                    observer.panGestureView = fixture.destinationViewController.view
                    observer.currentLocation = CGPoint(x: 0, y: 0)
                    observer.currentTranslation = CGPoint(x: 24, y: 0)
                    observer.currentVelocity = .zero
                    observer.translationHistory = [CGPoint(x: 24, y: 0), .zero]

                    fixture.dismissDriver.beginPanGesture(gesture: gesture, isEdgePan: true)

                    expect(fixture.dismissDriver.isInteracting).to(beTrue())
                    expect(fixture.dismissDriver.currentInteractionProgress).to(beCloseTo(0))

                    observer.currentLocation = CGPoint(x: 128, y: 0)
                    observer.currentTranslation = CGPoint(x: 128, y: 0)
                    observer.translationHistory = [CGPoint(x: 128, y: 0), .zero]

                    expect(fixture.dismissDriver.calculateTransitionProgress(isEdgePan: true)).to(beCloseTo(0.4, within: 0.001))
                }

                it("propagates dismiss interaction lifecycle and starts completion paths") {
                    let cancelledFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    let info = FluidGestureInfo(locationLocal: CGPoint(x: 24, y: 32),
                                                locationGlobal: CGPoint(x: 24, y: 32),
                                                translation: CGPoint(x: 80, y: 0),
                                                velocity: CGVector(dx: 2_000, dy: 0),
                                                direction: .rightMiddle)
                    cancelledFixture.dismissDriver.currentInteractionProgress = 0.25
                    cancelledFixture.dismissDriver.currentResizePosition = 0

                    cancelledFixture.dismissDriver.beginInteractiveTransition(progress: 0.25, position: 0, info: info)

                    expect(cancelledFixture.dismissAnimator.interactionProgress).to(beCloseTo(0.25))
                    expect(cancelledFixture.dismissAnimator.pausedInteractionProgress).to(beCloseTo(0.25))
                    expect(cancelledFixture.dismissAnimator.resizePosition).to(beCloseTo(0))
                    expect(cancelledFixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))
                    expect(cancelledFixture.destinationDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin"]))

                    cancelledFixture.dismissDriver.previousInteractionProgress = 0.25
                    cancelledFixture.dismissDriver.currentInteractionProgress = 0.6
                    cancelledFixture.dismissDriver.currentResizePosition = 0
                    cancelledFixture.dismissDriver.updateInteractiveTransition(progress: 0.6, position: 0, info: info)

                    expect(cancelledFixture.dismissAnimator.interactionProgress).to(beCloseTo(0.6))
                    expect(cancelledFixture.dismissAnimator.currentGestureInfo?.direction.description).to(equal("rightMiddle"))
                    expect(cancelledFixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update"]))

                    cancelledFixture.dismissDriver.finishInteractiveTransition(isCancelled: true, progress: 0.6, position: 0, info: info)

                    expect(cancelledFixture.dismissAnimator.animationTimer).to(beNil())
                    expect(cancelledFixture.dismissAnimator.progressAnimator).notTo(beNil())
                    expect(cancelledFixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "cancel"]))
                    expect(cancelledFixture.destinationDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "update", "cancel"]))

                    let completedFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    completedFixture.dismissDriver.currentInteractionProgress = 0.2
                    completedFixture.dismissDriver.currentResizePosition = 0

                    completedFixture.dismissDriver.beginInteractiveTransition(progress: 0.2, position: 0, info: info)
                    completedFixture.dismissDriver.finishInteractiveTransition(isCancelled: false, progress: 0.8, position: 0, info: info)

                    expect(completedFixture.dismissAnimator.animationTimer).to(beNil())
                    expect(completedFixture.sourceDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "end"]))
                    expect(completedFixture.destinationDelegate.dismissInteractionStates.map { String(describing: $0) }).to(equal(["begin", "end"]))
                }

                it("evaluates drawer resize conditions and delegates resize progress") {
                    let resizeDelegate = CoreTestResizableDelegate()
                    let finalDimension = FluidFinalFrameDimension(for: FluidTransitionStyle.drawer(position: .bottom),
                                                                  portraitContainerSize: CGSize(width: 320, height: 480),
                                                                  landscapeContainerSize: CGSize(width: 480, height: 320),
                                                                  portraitContentSize: CGSize(width: 320, height: 240),
                                                                  landscapeContentSize: CGSize(width: 480, height: 160),
                                                                  portraitContentTransform: CGAffineTransform.identity,
                                                                  landscapeContentTransform: CGAffineTransform.identity)
                    let fixture = makeCoreTestTransitionFixture(style: .drawer(position: .bottom),
                                                                resizableDelegate: resizeDelegate,
                                                                finalDimension: finalDimension)
                    let gesture = fixture.dismissDriver.observingGesture!

                    fixture.dismissDriver.currentInteractionProgress = 0.5
                    expect(fixture.dismissDriver.calculateResizePosition()).to(beLessThan(0))

                    seedGesture(gesture,
                                averageVector: CGPoint(x: 0, y: -40),
                                velocity: CGVector(dx: 0, dy: -2_000))
                    gesture.previousTranslation = .zero
                    gesture.currentTranslation = CGPoint(x: 0, y: -40)
                    fixture.dismissDriver.layout.top.constant = fixture.dismissDriver.baseConstantForResizing

                    expect(fixture.dismissDriver.canBeginResizeInteraction()).to(beTrue())

                    fixture.dismissDriver.currentResizePosition = 0.4
                    fixture.dismissDriver.previousResizePosition = 0.2
                    fixture.dismissDriver.beginInteractiveTransition(progress: 0.1, position: 0.4, info: .init())
                    fixture.dismissDriver.updateInteractiveTransition(progress: 0.2, position: 0.6, info: .init())
                    fixture.dismissDriver.finishInteractiveTransition(isCancelled: false, progress: 0.8, position: 1.2, info: .init())

                    expect(resizeDelegate.resizeStates.map { String(describing: $0) }).to(equal(["begin", "update", "end"]))
                    expect(resizeDelegate.resizePositions).to(equal([0.4, 0.6, 1.0]))
                }
            }
            describe("Core animated drivers") {
                it("configures present animators and completes a successful transition") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let context = CoreTestTransitionContext(container: fixture.container,
                                                            from: fixture.sourceViewController,
                                                            to: fixture.destinationViewController)

                    let firstAnimator = fixture.presentDriver.configureInterruptibleAnimator(using: context)
                    let secondAnimator = fixture.presentDriver.configureInterruptibleAnimator(using: context)

                    expect((firstAnimator as AnyObject) === (secondAnimator as AnyObject)).to(beTrue())
                    expect(fixture.presentDriver.interruptibleAnimator).notTo(beNil())
                    expect(fixture.presentAnimator.interruptibleAnimator).notTo(beNil())
                    expect(fixture.presentAnimator.progressAnimator).notTo(beNil())
                    expect(fixture.presentAnimator.activeDuration).to(beCloseTo(fixture.presentDriver.presentDuration, within: 0.001))
                    expect(fixture.sourceDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["begin"]))
                    expect(fixture.destinationDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["begin"]))

                    fixture.presentAnimator.progressAnimatorDidUpdate(progress: 0.4)
                    fixture.presentAnimator.progressAnimator?._animatorState = .finished

                    expect(fixture.sourceDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["begin", "update"]))
                    expect(fixture.destinationDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["begin", "update"]))
                    expect(context.completedTransitions).to(equal([true]))
                }

                it("configures dismiss animators from interaction progress and completes cancellation") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromRight))
                    let context = CoreTestTransitionContext(container: fixture.container,
                                                            from: fixture.destinationViewController,
                                                            to: fixture.sourceViewController,
                                                            transitionWasCancelled: true)
                    fixture.dismissDriver.currentInteractionProgress = 0.4
                    fixture.dismissDriver.isInteractionCancelled = true

                    _ = fixture.dismissDriver.configureInterruptibleAnimator(using: context)

                    expect(fixture.dismissDriver.interruptibleAnimator).notTo(beNil())
                    expect(fixture.dismissAnimator.progressAnimator).notTo(beNil())
                    expect(fixture.dismissAnimator.activeDuration).to(beCloseTo(fixture.dismissDriver.dismissDuration * 0.6, within: 0.001))
                    expect(fixture.dismissAnimator.activeEasing).to(equal(FluidAnimatorEasing.linear))
                    expect(fixture.sourceDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["begin"]))
                    expect(fixture.destinationDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["begin"]))

                    fixture.dismissAnimator.progressAnimatorDidUpdate(progress: 0.25)
                    fixture.dismissAnimator.progressAnimator?._animatorState = .finished

                    expect(fixture.sourceDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["begin", "update"]))
                    expect(fixture.destinationDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["begin", "update"]))
                    expect(context.completedTransitions).to(equal([false]))
                }

                it("configures reverse and rotate animations from current driver parameters") {
                    let reverseFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    reverseFixture.presentDriver.currentInteractionProgress = 0.35

                    reverseFixture.presentDriver.configureAndRunReverseTransitionAnimation()

                    expect(reverseFixture.presentAnimator.progressAnimator).notTo(beNil())
                    expect(reverseFixture.presentAnimator.progressAnimator?.duration).to(beCloseTo(FluidConst.fluidInteractionReverseDuration, within: 0.001))

                    let rotateFixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    rotateFixture.dismissDriver.configureAndRunRotateAnimation(from: CGSize(width: 320, height: 480),
                                                                               to: CGSize(width: 480, height: 320),
                                                                               duration: 0.12)

                    expect(rotateFixture.dismissDriver.parameters.animationType).to(equal(.rotate))
                    expect(rotateFixture.dismissAnimator.progressAnimator?.duration).to(beCloseTo(0.12, within: 0.001))

                    rotateFixture.dismissAnimator.progressAnimator?._animatorState = .finished

                    expect(rotateFixture.dismissDriver.parameters.animationType).to(equal(.dismiss))
                    expect(rotateFixture.dismissDriver.observingGesture).notTo(beNil())
                }

                it("cleans up present animation completion and cancellation") {
                    let completedFixture = makeCoreTestTransitionFixture()
                    completedFixture.presentDriver.interruptibleAnimator = UIViewPropertyAnimator(duration: 0, curve: .linear)

                    completedFixture.presentDriver.animationDidEnd(true)

                    expect(completedFixture.sourceDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["end"]))
                    expect(completedFixture.destinationDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["end"]))
                    expect(completedFixture.presentDriver.interruptibleAnimator).to(beNil())
                    expect(completedFixture.presentDriver.observingGesture).to(beNil())
                    expect(completedFixture.presentAnimator.parameters).to(beNil())

                    let cancelledFixture = makeCoreTestTransitionFixture()
                    cancelledFixture.presentDriver.interruptibleAnimator = UIViewPropertyAnimator(duration: 0, curve: .linear)

                    cancelledFixture.presentDriver.animationDidEnd(false)

                    expect(cancelledFixture.sourceDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["cancel"]))
                    expect(cancelledFixture.destinationDelegate.presentAnimationStates.map { String(describing: $0) }).to(equal(["cancel"]))
                    expect(cancelledFixture.presentDriver.interruptibleAnimator).to(beNil())
                    expect(cancelledFixture.presentDriver.observingGesture).to(beNil())
                    expect(cancelledFixture.presentAnimator.parameters).to(beNil())
                    expect(cancelledFixture.destinationViewController.view.superview).to(beNil())
                }

                it("cleans up dismiss animation completion and restores cancellation parameters") {
                    let completedFixture = makeCoreTestTransitionFixture()
                    completedFixture.dismissDriver.interruptibleAnimator = UIViewPropertyAnimator(duration: 0, curve: .linear)

                    completedFixture.dismissDriver.animationDidEnd(true)

                    expect(completedFixture.sourceDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["end"]))
                    expect(completedFixture.destinationDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["end"]))
                    expect(completedFixture.dismissDriver.interruptibleAnimator).to(beNil())
                    expect(completedFixture.dismissDriver.observingGesture).to(beNil())
                    expect(completedFixture.dismissAnimator.parameters).to(beNil())
                    expect(completedFixture.destinationViewController.view.superview).to(beNil())

                    let cancelledFixture = makeCoreTestTransitionFixture()
                    cancelledFixture.dismissDriver.interruptibleAnimator = UIViewPropertyAnimator(duration: 0, curve: .linear)

                    cancelledFixture.dismissDriver.animationDidEnd(false)

                    expect(cancelledFixture.sourceDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["cancel"]))
                    expect(cancelledFixture.destinationDelegate.dismissAnimationStates.map { String(describing: $0) }).to(equal(["cancel"]))
                    expect(cancelledFixture.dismissDriver.interruptibleAnimator).to(beNil())
                    expect(cancelledFixture.dismissDriver.parameters.animationType).to(equal(.dismiss))
                    expect(cancelledFixture.dismissAnimator.parameters).notTo(beNil())
                    expect(cancelledFixture.destinationViewController.view.superview).notTo(beNil())
                }
            }
            describe("Core animator helpers") {
                it("converts delayed transition progress into animator progress") {
                    let fixture = makeCoreTestTransitionFixture()
                    let animator = fixture.presentAnimator

                    expect(animator.convertProgress(transitionProgress: 0.2,
                                                    transitionDuration: 2,
                                                    animatorDuration: 1,
                                                    animatorDelay: 0.5)).to(beCloseTo(0))
                    expect(animator.convertProgress(transitionProgress: 0.25,
                                                    transitionDuration: 2,
                                                    animatorDuration: 1,
                                                    animatorDelay: 0.5)).to(beCloseTo(0))
                    expect(animator.convertProgress(transitionProgress: 0.625,
                                                    transitionDuration: 2,
                                                    animatorDuration: 1,
                                                    animatorDelay: 0.5)).to(beCloseTo(0.75, within: 0.001))
                    expect(animator.convertProgress(transitionProgress: 1,
                                                    transitionDuration: 2,
                                                    animatorDuration: 1,
                                                    animatorDelay: 0.5)).to(beCloseTo(1))
                }

                it("pauses, updates, and finishes core animation groups") {
                    let fixture = makeCoreTestTransitionFixture()
                    let animator = fixture.presentAnimator
                    let info = FluidGestureInfo(direction: .leftMiddle)
                    let progressView = UIView(frame: fixture.container.bounds)
                    let frameView = UIView(frame: fixture.container.bounds)
                    let extraView = UIView(frame: fixture.container.bounds)
                    let progressAnimator = FluidCoreAnimator(for: progressView,
                                                             id: "test.progress",
                                                             duration: 2)!
                    let frameAnimator = FluidCoreAnimator(for: frameView,
                                                          id: "test.frame",
                                                          duration: 1,
                                                          beginTime: 0.5)!
                    let extraAnimator = FluidCoreAnimator(for: extraView,
                                                          id: "test.extra",
                                                          duration: 2,
                                                          beginTime: 0.25)!

                    fixture.container.addSubview(progressView)
                    fixture.container.addSubview(frameView)
                    fixture.container.addSubview(extraView)
                    progressAnimator._animatorState = .running
                    frameAnimator._animatorState = .running
                    extraAnimator._animatorState = .running

                    var parameters = animator.parameters!
                    parameters.activeDuration = 2
                    parameters.progressAnimator = progressAnimator
                    parameters.frameCoreAnimators = [frameAnimator]
                    parameters.extraCoreAnimators = [extraAnimator]
                    animator.parameters = parameters

                    animator.pauseAnimation(progress: 0.25, position: 0.1, info: info)

                    expect(animator.pausedAnimationProgress).to(beCloseTo(0.25))
                    expect(String(describing: progressAnimator.animatorState)).to(equal("paused"))
                    expect(String(describing: frameAnimator.animatorState)).to(equal("paused"))
                    expect(String(describing: extraAnimator.animatorState)).to(equal("paused"))

                    animator.updateAnimation(progress: 0.75, position: 0.4, info: info)

                    expect(frameAnimator.layer?.timeOffset).to(beCloseTo(1, within: 0.001))
                    expect(extraAnimator.layer?.timeOffset).to(beCloseTo(1.25, within: 0.001))
                    expect(progressAnimator.layer?.timeOffset).to(beCloseTo(1.5, within: 0.001))

                    animator.finishAnimation(isReversed: false, progress: 0.75, position: 0.6, info: info)

                    expect(String(describing: progressAnimator.animatorState)).to(equal("running"))
                    expect(String(describing: frameAnimator.animatorState)).to(equal("running"))
                    expect(String(describing: extraAnimator.animatorState)).to(equal("running"))
                    expect(frameAnimator.layer?.speed).to(beCloseTo(1))
                    expect(extraAnimator.layer?.speed).to(beCloseTo(1))
                    expect(progressAnimator.layer?.speed).to(beCloseTo(1))
                }

                it("applies shadow layer properties and transparent masks") {
                    let fixture = makeCoreTestTransitionFixture()
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)
                    let frame = CGRect(x: 12, y: 20, width: 120, height: 80)
                    let shadowOffset = CGSize(width: 3, height: -2)

                    fixture.container.addSubview(shadowView)
                    fixture.presentAnimator.parameters.shadowView = shadowView
                    shadowView.layer.mask = CAShapeLayer()

                    fixture.presentAnimator.applyShadowProperties(frame: frame,
                                                                  cornerRadius: 10,
                                                                  cornerStyle: .top,
                                                                  shadowColor: UIColor.red.cgColor,
                                                                  shadowOpacity: 0.65,
                                                                  shadowRadius: 6,
                                                                  shadowOffset: shadowOffset,
                                                                  isTransparentBackground: true)

                    expect(shadowView.layer.frame).to(equal(frame))
                    expect(shadowView.layer.cornerRadius).to(beCloseTo(10))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.65, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(6))
                    expect(shadowView.layer.shadowOffset).to(equal(shadowOffset))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect((shadowView.layer.mask as? CAShapeLayer)?.path).notTo(beNil())
                }

                it("configures transition and interruptible animator state") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let animator = fixture.presentAnimator
                    let layoutContainerView = animator.layoutContainerView!
                    let backgroundView = FluidDimmedBackgroundView(color: .black)
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)
                    var progressValues = [CGFloat]()
                    var stateValues = [String]()
                    var completionWasStored = false

                    fixture.container.insertSubview(backgroundView, belowSubview: layoutContainerView)
                    fixture.container.addSubview(shadowView)
                    var parameters = animator.parameters!
                    parameters.layoutContainerView = layoutContainerView
                    parameters.backgroundView = backgroundView
                    parameters.shadowView = shadowView
                    parameters.shouldCastShadow = true
                    parameters.shouldMaskCorner = true
                    parameters.initialStyle = FluidInitialFrameStyle(alpha: 1,
                                                                     cornerRadius: 6,
                                                                     shadowColor: UIColor.blue.cgColor,
                                                                     shadowOpacity: 0.25,
                                                                     shadowRadius: 3,
                                                                     shadowOffset: CGSize(width: -1, height: 2))
                    parameters.finalStyle = FluidFinalFrameStyle(alpha: 1,
                                                                 cornerRadius: 18,
                                                                 cornerStyle: .top,
                                                                 shadowColor: UIColor.red.cgColor,
                                                                 shadowOpacity: 0.75,
                                                                 shadowRadius: 9,
                                                                 shadowOffset: CGSize(width: 3, height: 4))
                    animator.parameters = parameters

                    animator.configureTransitionAnimators(isReversed: false,
                                                          from: 0,
                                                          to: 1,
                                                          progress: { progressValues.append($0) },
                                                          state: { state, progress in
                                                              stateValues.append("\(state):\(progress)")
                                                          })
                    animator.configureInterruptibleAnimator { _, _ in
                        completionWasStored = true
                    }

                    expect(animator.framePropertyAnimators?.count).to(equal(2))
                    expect(animator.frameCoreAnimators?.count).to(equal(1))
                    expect(animator.backgroundAnimator).notTo(beNil())
                    expect(animator.progressView).to(beIdenticalTo(fixture.container.viewWithTag(FluidConst.progressViewTag)))
                    expect(animator.progressAnimator).notTo(beNil())
                    expect(animator.interruptibleView).to(beIdenticalTo(fixture.container.viewWithTag(FluidConst.interruptibleViewTag)))
                    expect(animator.interruptibleView?.alpha).to(beCloseTo(0))
                    expect(animator.interruptibleAnimator?.completionBlock).notTo(beNil())
                    expect(completionWasStored).to(beFalse())

                    animator.progressAnimatorDidUpdate(progress: 0.42)
                    animator.progressAnimatorStateDidChange(state: .finished, progress: 1)

                    expect(progressValues).to(equal([0.42]))
                    expect(stateValues).to(equal(["finished:1.0"]))
                }

                it("creates shadow and corner animators from configured styles") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let animator = fixture.presentAnimator
                    let layoutContainerView = animator.layoutContainerView!
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)

                    fixture.container.addSubview(shadowView)
                    var parameters = animator.parameters!
                    parameters.layoutContainerView = layoutContainerView
                    parameters.shadowView = shadowView
                    parameters.shouldCastShadow = true
                    parameters.shouldMaskCorner = true
                    parameters.initialStyle = FluidInitialFrameStyle(alpha: 1,
                                                                     cornerRadius: 4,
                                                                     shadowColor: UIColor.blue.cgColor,
                                                                     shadowOpacity: 0.2,
                                                                     shadowRadius: 2,
                                                                     shadowOffset: CGSize(width: -2, height: 1))
                    parameters.finalStyle = FluidFinalFrameStyle(alpha: 1,
                                                                 cornerRadius: 16,
                                                                 cornerStyle: .bottom,
                                                                 shadowColor: UIColor.red.cgColor,
                                                                 shadowOpacity: 0.6,
                                                                 shadowRadius: 8,
                                                                 shadowOffset: CGSize(width: 3, height: 5))
                    animator.parameters = parameters

                    let expectedShadowFrame = animator.toShadowFrame(false, 0)
                    let shadowAnimators = animator.createShadowPropertyAnimation(false)
                    let cornerAnimators = animator.createCornerRadiusPropertyAnimation(false)

                    expect(shadowAnimators.count).to(equal(1))
                    expect(cornerAnimators.count).to(equal(1))
                    expect(shadowView.layer.frame).to(equal(expectedShadowFrame))
                    expect(shadowView.layer.cornerRadius).to(beCloseTo(16))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.6, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(8))
                    expect(shadowView.layer.shadowOffset).to(equal(CGSize(width: 3, height: 5)))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect(animator.layoutContainerView.layer.masksToBounds).to(beTrue())
                    expect(animator.layoutContainerView.layer.cornerRadius).to(beCloseTo(4))
                    expect(animator.layoutContainerView.layer.maskedCorners).to(equal(animator.initialStyle.maskedCorners))
                }

                it("creates core animation fallbacks for shadow and corner masks") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let animator = fixture.presentAnimator
                    let layoutContainerView = animator.layoutContainerView!
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: true)

                    fixture.container.addSubview(shadowView)
                    shadowView.layer.mask = CAShapeLayer()
                    var parameters = animator.parameters!
                    var initialStyle = FluidInitialFrameStyle(alpha: 1,
                                                             cornerRadius: 6,
                                                             shadowColor: UIColor.blue.cgColor,
                                                             shadowOpacity: 0.25,
                                                             shadowRadius: 3,
                                                             shadowOffset: CGSize(width: -1, height: 2))
                    var finalStyle = FluidFinalFrameStyle(alpha: 1,
                                                          cornerRadius: 18,
                                                          cornerStyle: .bottom,
                                                          shadowColor: UIColor.red.cgColor,
                                                          shadowOpacity: 0.75,
                                                          shadowRadius: 9,
                                                          shadowOffset: CGSize(width: 3, height: 4))
                    initialStyle.isTransparentBackground = true
                    finalStyle.isTransparentBackground = true
                    parameters.layoutContainerView = layoutContainerView
                    parameters.shadowView = shadowView
                    parameters.shouldCastShadow = true
                    parameters.shouldMaskCorner = true
                    parameters.initialStyle = initialStyle
                    parameters.finalStyle = finalStyle
                    animator.parameters = parameters

                    let expectedShadowFrame = animator.toShadowFrame(false, 0)
                    let shadowAnimators = animator.createShadowCoreAnimation(false)
                    let cornerAnimators = animator.createCornerRadiusCoreAnimation(false)

                    expect(shadowAnimators.count).to(equal(2))
                    expect((shadowAnimators.first as? FluidCoreAnimator)?.animationCount).to(equal(8))
                    expect((shadowAnimators.last as? FluidCoreAnimator)?.animationCount).to(equal(1))
                    expect(cornerAnimators.count).to(equal(1))
                    expect((cornerAnimators.first as? FluidCoreAnimator)?.animationCount).to(equal(1))
                    expect(shadowView.layer.frame).to(equal(expectedShadowFrame))
                    expect(shadowView.layer.cornerRadius).to(beCloseTo(18))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.75, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(9))
                    expect(shadowView.layer.shadowOffset).to(equal(CGSize(width: 3, height: 4)))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect(shadowView.layer.mask as? CAShapeLayer).notTo(beNil())
                    expect(animator.layoutContainerView.layer.mask as? FluidCornerMaskLayer).notTo(beNil())
                }

                it("invalidates animator state and removes transient views") {
                    let fixture = makeCoreTestTransitionFixture()
                    let animator = fixture.presentAnimator
                    let backgroundView = FluidDimmedBackgroundView(color: .black)
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)
                    let progressView = FluidProgressView()
                    let interruptibleView = FluidInterruptibleView()

                    fixture.container.addSubview(backgroundView)
                    fixture.container.addSubview(shadowView)
                    fixture.container.addSubview(progressView)
                    fixture.container.addSubview(interruptibleView)

                    var parameters = animator.parameters!
                    parameters.backgroundView = backgroundView
                    parameters.shadowView = shadowView
                    parameters.progressView = progressView
                    parameters.interruptibleView = interruptibleView
                    animator.parameters = parameters
                    animator.pausedGestureInfo = FluidGestureInfo(direction: .leftMiddle)
                    animator.currentGestureInfo = FluidGestureInfo(direction: .rightMiddle)
                    animator.storedFromFrame = CGRect(x: 1, y: 2, width: 3, height: 4)
                    animator.storedToFrame = CGRect(x: 4, y: 3, width: 2, height: 1)
                    animator.storedFromStyle = FluidInitialFrameStyle(alpha: 1)
                    animator.storedToStyle = FluidFinalFrameStyle(alpha: 1)

                    animator.invalidate(willRemoveContainer: true)

                    expect(interruptibleView.superview).to(beNil())
                    expect(progressView.superview).to(beNil())
                    expect(backgroundView.superview).to(beNil())
                    expect(shadowView.superview).to(beNil())
                    expect(animator.pausedGestureInfo).to(beNil())
                    expect(animator.currentGestureInfo).to(beNil())
                    expect(animator.storedFromFrame).to(beNil())
                    expect(animator.storedToFrame).to(beNil())
                    expect(animator.storedFromStyle).to(beNil())
                    expect(animator.storedToStyle).to(beNil())
                    expect(animator.parameters).to(beNil())
                }
            }
            describe("FluidShadowLayer") {
                it("creates expanded shadow frames and optional masks") {
                    let frame = CGRect(x: 10, y: 20, width: 100, height: 80)
                    let shadowOffset = CGSize(width: 2, height: -3)

                    let shadowFrame = FluidShadowLayer.createShadowFrame(frame: frame,
                                                                         shadowRadius: 4,
                                                                         shadowOffset: shadowOffset)

                    expect(shadowFrame).to(equal(CGRect(x: 4, y: 9, width: 116, height: 96)))
                    expect(FluidShadowLayer.createShadowMask(bounds: frame.bounds,
                                                             cornerRadius: 8,
                                                             roundingCorners: [.topLeft, .topRight],
                                                             shadowRadius: 4,
                                                             shadowOffset: shadowOffset,
                                                             isTransparentBackground: false)).to(beNil())

                    let mask = FluidShadowLayer.createShadowMask(bounds: frame.bounds,
                                                                 cornerRadius: 8,
                                                                 roundingCorners: [.topLeft, .topRight],
                                                                 shadowRadius: 4,
                                                                 shadowOffset: shadowOffset,
                                                                 isTransparentBackground: true)

                    expect(mask?.frame).to(equal(CGRect(x: 0, y: 0, width: 116, height: 96)))
                    expect(mask?.path).notTo(beNil())
                }

                it("casts shadow and marks animatable keys for display") {
                    let layer = FluidShadowLayer(frame: .zero)
                    let frame = CGRect(x: 0, y: 0, width: 90, height: 70)
                    let shadowOffset = CGSize(width: -2, height: 5)

                    layer.castShadow(frame: frame,
                                     shadowCornerRadius: 12,
                                     shadowRoundingCorners: .bottomRight,
                                     shadowColor: UIColor.blue.cgColor,
                                     shadowOpacity: 0.55,
                                     shadowRadius: 5,
                                     shadowOffset: shadowOffset,
                                     isTransparentBackground: true)

                    expect(layer.shadowCornerRadius).to(beCloseTo(12))
                    expect(layer.shadowRoundingCorners).to(equal(.bottomRight))
                    expect(CGFloat(layer.shadowOpacity)).to(beCloseTo(0.55, within: 0.001))
                    expect(layer.shadowRadius).to(beCloseTo(5))
                    expect(layer.shadowOffset).to(equal(shadowOffset))
                    expect(layer.isTransparentBackground).to(beTrue())
                    expect(layer.shadowPath).notTo(beNil())
                    expect(layer.mask as? CAShapeLayer).notTo(beNil())
                    expect(FluidShadowLayer.needsDisplay(forKey: "shadowCornerRadius")).to(beTrue())
                    expect(FluidShadowLayer.needsDisplay(forKey: "isTransparentBackground")).to(beTrue())
                }

                it("preserves shadow state when copied and encoded") {
                    let layer = FluidShadowLayer(frame: CGRect(x: 1, y: 2, width: 30, height: 40))
                    layer.castShadow(frame: CGRect(x: 0, y: 0, width: 50, height: 60),
                                     shadowCornerRadius: 9,
                                     shadowRoundingCorners: [.topLeft, .bottomRight],
                                     shadowColor: UIColor.green.cgColor,
                                     shadowOpacity: 0.45,
                                     shadowRadius: 6,
                                     shadowOffset: CGSize(width: 3, height: 4),
                                     isTransparentBackground: true)

                    layer.castShadow(frame: CGRect(x: 0, y: 0, width: 50, height: 60))

                    expect(layer.shadowCornerRadius).to(beCloseTo(9))
                    expect(layer.shadowRoundingCorners).to(equal([.topLeft, .bottomRight]))
                    expect(CGFloat(layer.shadowOpacity)).to(beCloseTo(0.45, within: 0.001))
                    expect(layer.shadowRadius).to(beCloseTo(6))
                    expect(layer.shadowOffset).to(equal(CGSize(width: 3, height: 4)))
                    expect(layer.isTransparentBackground).to(beTrue())

                    let copied = FluidShadowLayer(layer: layer)
                    expect(copied.shadowCornerRadius).to(beCloseTo(layer.shadowCornerRadius))
                    expect(copied.shadowRoundingCorners).to(equal(layer.shadowRoundingCorners))
                    expect(copied.isTransparentBackground).to(equal(layer.isTransparentBackground))

                    let coder = TestShadowLayerCoder()
                    layer.encode(with: coder)

                    let decoded = FluidShadowLayer(coder: coder)

                    expect(decoded?.shadowCornerRadius).to(beCloseTo(layer.shadowCornerRadius))
                    expect(decoded?.isTransparentBackground).to(equal(layer.isTransparentBackground))
                    expect(FluidShadowLayer.needsDisplay(forKey: "shadowOpacity")).to(beFalse())
                }
            }
            describe("FluidBackgroundView") {
                it("fits dimmed backgrounds and clamps visibility") {
                    let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 120))
                    let backgroundView = FluidDimmedBackgroundView(color: .red)

                    container.addSubview(backgroundView)

                    expect(backgroundView.backgroundColor).to(equal(.red))
                    expect(backgroundView.alpha).to(beCloseTo(0))
                    expect(backgroundView.isUserInteractionEnabled).to(beFalse())
                    expect(backgroundView.tag).to(equal(FluidConst.backgroundViewTag))

                    backgroundView.visibility = 0.5
                    expect(backgroundView.alpha).to(beCloseTo(0.5))
                    backgroundView.visibility = -1
                    expect(backgroundView.alpha).to(beCloseTo(0))
                    backgroundView.visibility = 2
                    expect(backgroundView.alpha).to(beCloseTo(1))

                    backgroundView.updateConstraints()

                    let attachedConstraints = container.constraints.filter { constraint in
                        return (constraint.firstItem as? UIView) === backgroundView ||
                               (constraint.secondItem as? UIView) === backgroundView
                    }
                    expect(backgroundView.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    expect(attachedConstraints.count).to(equal(4))
                }

                it("fits blurred backgrounds and maps visibility to blur radius") {
                    let container = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 120))
                    let backgroundView = TestBlurredBackgroundView(radius: 20, color: .blue, alpha: 0.35)

                    container.addSubview(backgroundView)

                    expect(backgroundView.baseBlurRadius).to(beCloseTo(20))
                    expect(backgroundView.blurRadius).to(beCloseTo(0))
                    expect(backgroundView.colorTint).to(equal(.blue))
                    expect(backgroundView.colorTintAlpha).to(beCloseTo(0.35, within: 0.001))
                    expect(backgroundView.isUserInteractionEnabled).to(beFalse())
                    expect(backgroundView.tag).to(equal(FluidConst.backgroundViewTag))

                    backgroundView.visibility = 0.25
                    expect(backgroundView.blurRadius).to(beCloseTo(5))
                    backgroundView.visibility = -1
                    expect(backgroundView.blurRadius).to(beCloseTo(0))
                    backgroundView.visibility = 2
                    expect(backgroundView.blurRadius).to(beCloseTo(20))

                    backgroundView.scale = 2
                    expect(backgroundView.scale).to(beCloseTo(2))

                    backgroundView.updateConstraints()

                    let attachedConstraints = container.constraints.filter { constraint in
                        return (constraint.firstItem as? UIView) === backgroundView ||
                               (constraint.secondItem as? UIView) === backgroundView
                    }
                    expect(backgroundView.translatesAutoresizingMaskIntoConstraints).to(beFalse())
                    expect(attachedConstraints.count).to(equal(4))
                }
            }
            describe("FluidInteractiveView") {
                it("expands, restores, and resets transforms") {
                    let view = TestInteractiveView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

                    expect(view.expandScale).to(beCloseTo(1.05))
                    expect(view.restoreScale).to(beCloseTo(1.0))

                    view.expand()

                    expect(view.transform.a).to(beCloseTo(view.expandScale, within: 0.001))
                    expect(view.transform.d).to(beCloseTo(view.expandScale, within: 0.001))

                    view.restore()

                    expect(view.transform.a).to(beCloseTo(view.restoreScale, within: 0.001))
                    expect(view.transform.d).to(beCloseTo(view.restoreScale, within: 0.001))

                    view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    view.reset()

                    expect(view.transform).to(equal(.identity))
                }
            }
            describe("FluidCornerMaskLayer") {
                it("updates mask paths and preserves copied mask state") {
                    let initialBounds = CGRect(x: 0, y: 0, width: 100, height: 80)
                    let updatedBounds = CGRect(x: 0, y: 0, width: 120, height: 90)
                    let layer = FluidCornerMaskLayer(bounds: initialBounds,
                                                     cornerRadius: 8,
                                                     roundingCorners: [.topLeft, .topRight])

                    expect(layer.frame).to(equal(initialBounds))
                    expect(layer.fluidCornerRadius).to(beCloseTo(8))
                    expect(layer.fluidRoundingCorners).to(equal([.topLeft, .topRight]))
                    expect(layer.path).notTo(beNil())

                    layer.updateMaskPath(bounds: updatedBounds,
                                         cornerRadius: 14,
                                         roundingCorners: [.bottomLeft, .bottomRight])

                    expect(layer.fluidCornerRadius).to(beCloseTo(14))
                    expect(layer.fluidRoundingCorners).to(equal([.bottomLeft, .bottomRight]))
                    expect(layer.path?.boundingBoxOfPath).to(equal(updatedBounds))

                    layer.bounds = CGRect(x: 0, y: 0, width: 60, height: 40)

                    expect(layer.path?.boundingBoxOfPath).to(equal(CGRect(x: 0, y: 0, width: 60, height: 40)))

                    let copied = FluidCornerMaskLayer(layer: layer)

                    expect(copied.frame).to(equal(layer.frame))
                    expect(copied.fluidCornerRadius).to(beCloseTo(layer.fluidCornerRadius))
                    expect(copied.fluidRoundingCorners).to(equal(layer.fluidRoundingCorners))
                    expect(copied.path).notTo(beNil())
                    expect(FluidCornerMaskLayer.createMaskPath(bounds: initialBounds,
                                                               cornerRadius: 8,
                                                               roundingCorners: .topLeft).boundingBoxOfPath)
                        .to(equal(initialBounds))
                }
            }
            describe("Navigation interactive animator") {
                it("interpolates dismiss frames and shadow properties") {
                    let fixture = makeCoreTestNavigationFixture(style: .slide(direction: .fromBottom))
                    let animator = fixture.dismissAnimator
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)

                    fixture.container.addSubview(shadowView)
                    animator.parameters.shadowView = shadowView
                    shadowView.layer.mask = CAShapeLayer()

                    animator.interactionDidStart(progress: 0, position: 0, info: FluidGestureInfo())
                    defer {
                        animator.animationTimer?.stop()
                        animator.animationTimer = nil
                    }

                    let fromFrame = animator.finalDimension.frame()
                    let toFrame = animator.initialDimension.frame()
                    var fromStyle = FluidFinalFrameStyle(cornerRadius: 24,
                                                         cornerStyle: .top,
                                                         shadowColor: UIColor.red.cgColor,
                                                         shadowOpacity: 0.8,
                                                         shadowRadius: 10,
                                                         shadowOffset: CGSize(width: 4, height: 2))
                    fromStyle.isTransparentBackground = true
                    let toStyle = FluidInitialFrameStyle(cornerRadius: 4,
                                                         shadowColor: UIColor.blue.cgColor,
                                                         shadowOpacity: 0.2,
                                                         shadowRadius: 2,
                                                         shadowOffset: CGSize(width: -2, height: 6))

                    animator.storedFromStyle = fromStyle
                    animator.storedToStyle = toStyle
                    animator.interactionProgress = 0.5
                    animator.animationTimerDidUpdate()

                    let expectedFrame = fromFrame - (fromFrame - toFrame) * 0.5

                    expect(animator.layoutContainerView.frame).to(equal(expectedFrame))
                    expect(animator.layoutContainerView.layer.cornerRadius).to(beCloseTo(14))
                    expect(animator.backgroundView?.visibility).to(beCloseTo(0.5))
                    expect(shadowView.layer.frame).to(equal(expectedFrame))
                    expect(shadowView.layer.cornerRadius).to(beCloseTo(14))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.5, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(6))
                    expect(shadowView.layer.shadowOffset).to(equal(CGSize(width: 1, height: 4)))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect((shadowView.layer.mask as? CAShapeLayer)?.path).notTo(beNil())
                }
            }
            describe("Navigation scroll observer") {
                it("observes, locks, and restores scroll state") {
                    let fixture = makeCoreTestNavigationFixture(style: .slide(direction: .fromBottom))
                    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
                    let observer = FluidNavigationScrollObserver(view: scrollView)

                    scrollView.contentSize = CGSize(width: 120, height: 240)
                    scrollView.contentOffset = CGPoint(x: 0, y: 12)
                    scrollView.showsVerticalScrollIndicator = true
                    scrollView.showsHorizontalScrollIndicator = true
                    observer.registerParameters(parameters: fixture.dismissDriver.parameters)

                    observer.startObserving()

                    expect(observer.panGestureRecognizer).notTo(beNil())
                    expect(observer.offsetObservation).notTo(beNil())
                    expect(observer.gestureRecognizerShouldBegin(observer.panGestureRecognizer)).to(beTrue())
                    expect(observer.gestureRecognizer(observer.panGestureRecognizer,
                                                      shouldRecognizeSimultaneouslyWith: UIPanGestureRecognizer()))
                        .to(beTrue())
                    expect(observer.description).to(contain("FluidScrollObservable"))

                    observer.updateScroll(progress: 0.4, position: 0, state: .dismissing)

                    expect(observer.isTransitioning).to(beTrue())
                    expect(observer.lockedContentOffset).to(equal(CGPoint(x: 0, y: 12)))
                    expect(scrollView.showsVerticalScrollIndicator).to(beFalse())
                    expect(scrollView.showsHorizontalScrollIndicator).to(beFalse())

                    scrollView.contentOffset = CGPoint(x: 0, y: -20)
                    observer.contentOffsetDidChange(oldValue: CGPoint(x: 0, y: -20))

                    expect(scrollView.contentOffset).to(equal(CGPoint(x: 0, y: 12)))

                    observer.updateScroll(progress: 0, position: 0, state: .none)

                    expect(observer.isTransitioning).to(beFalse())
                    expect(observer.lockedContentOffset).to(beNil())
                    expect(scrollView.showsVerticalScrollIndicator).to(beTrue())
                    expect(scrollView.showsHorizontalScrollIndicator).to(beTrue())

                    observer.disableInteraction()
                    expect(scrollView.isUserInteractionEnabled).to(beFalse())
                    expect(scrollView.isScrollEnabled).to(beFalse())
                    observer.enableInteraction()
                    expect(scrollView.isUserInteractionEnabled).to(beTrue())
                    expect(scrollView.isScrollEnabled).to(beTrue())

                    observer.stopObserving()

                    expect(observer.panGestureRecognizer).to(beNil())
                    expect(observer.offsetObservation).to(beNil())
                }
            }
            describe("Transition interactive animator") {
                it("interpolates dismiss frames and shadow properties") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let animator = fixture.dismissAnimator
                    let backgroundView = FluidDimmedBackgroundView(color: .black)
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)

                    fixture.container.insertSubview(backgroundView, belowSubview: animator.layoutContainerView)
                    fixture.container.addSubview(shadowView)
                    animator.parameters.backgroundView = backgroundView
                    animator.parameters.shadowView = shadowView
                    shadowView.layer.mask = CAShapeLayer()

                    animator.interactionDidStart(progress: 0, position: 0, info: FluidGestureInfo())
                    defer {
                        animator.animationTimer?.stop()
                        animator.animationTimer = nil
                    }

                    let fromFrame = animator.finalDimension.frame()
                    let toFrame = animator.initialDimension.frame()
                    var fromStyle = FluidFinalFrameStyle(cornerRadius: 24,
                                                         cornerStyle: .top,
                                                         shadowColor: UIColor.red.cgColor,
                                                         shadowOpacity: 0.8,
                                                         shadowRadius: 10,
                                                         shadowOffset: CGSize(width: 4, height: 2))
                    fromStyle.isTransparentBackground = true
                    let toStyle = FluidInitialFrameStyle(cornerRadius: 4,
                                                         shadowColor: UIColor.blue.cgColor,
                                                         shadowOpacity: 0.2,
                                                         shadowRadius: 2,
                                                         shadowOffset: CGSize(width: -2, height: 6))

                    animator.storedFromStyle = fromStyle
                    animator.storedToStyle = toStyle
                    animator.interactionProgress = 0.5
                    animator.animationTimerDidUpdate()

                    let expectedFrame = fromFrame - (fromFrame - toFrame) * 0.5
                    let expectedEdges = FluidLayoutEdgeConstant(size: animator.initialContainerSize,
                                                                frame: expectedFrame)

                    expect(animator.layout.top.constant).to(beCloseTo(expectedEdges.top))
                    expect(animator.layout.bottom.constant).to(beCloseTo(expectedEdges.bottom))
                    expect(animator.layout.left.constant).to(beCloseTo(expectedEdges.left))
                    expect(animator.layout.right.constant).to(beCloseTo(expectedEdges.right))
                    expect(animator.layoutContainerView.layer.cornerRadius).to(beCloseTo(14))
                    expect(animator.backgroundView?.visibility).to(beCloseTo(0.5))
                    expect(shadowView.layer.frame).to(equal(expectedFrame))
                    expect(shadowView.layer.cornerRadius).to(beCloseTo(14))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.5, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(6))
                    expect(shadowView.layer.shadowOffset).to(equal(CGSize(width: 1, height: 4)))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect((shadowView.layer.mask as? CAShapeLayer)?.path).notTo(beNil())
                }

                it("updates fluid dismiss transform and shadow feedback") {
                    let fixture = makeCoreTestTransitionFixture(style: .fluid(behavior: .all),
                                                                easing: .linear)
                    let animator = fixture.dismissAnimator
                    let backgroundView = FluidDimmedBackgroundView(color: .black)
                    let shadowView = FluidShadowView(shadowCornerRadius: 0,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 0,
                                                     shadowOffset: .zero,
                                                     isTransparentBackground: false)

                    fixture.container.insertSubview(backgroundView, belowSubview: animator.layoutContainerView)
                    fixture.container.addSubview(shadowView)
                    animator.parameters.backgroundView = backgroundView
                    animator.parameters.shadowView = shadowView
                    shadowView.layer.mask = CAShapeLayer()

                    animator.beginInteraction(progress: 0, position: 0, info: FluidGestureInfo(translation: .zero))
                    defer {
                        animator.animationTimer?.stop()
                        animator.animationTimer = nil
                    }

                    var fromStyle = FluidFinalFrameStyle(cornerRadius: 20,
                                                         cornerStyle: .all,
                                                         shadowColor: UIColor.red.cgColor,
                                                         shadowOpacity: 0.8,
                                                         shadowRadius: 12,
                                                         shadowOffset: CGSize(width: 4, height: 2))
                    fromStyle.isTransparentBackground = true
                    let toStyle = FluidInitialFrameStyle(cornerRadius: 4,
                                                         shadowColor: UIColor.blue.cgColor,
                                                         shadowOpacity: 0.2,
                                                         shadowRadius: 2,
                                                         shadowOffset: CGSize(width: -2, height: 6))

                    animator.storedFromStyle = fromStyle
                    animator.storedToStyle = toStyle
                    animator.updateInteraction(progress: 0.5,
                                               position: 0,
                                               info: FluidGestureInfo(translation: CGPoint(x: 80, y: 40)))
                    animator.animationTimerDidUpdate()

                    expect(animator.layoutContainerView.transform.a).to(beLessThan(1))
                    expect(animator.layoutContainerView.transform.d).to(beLessThan(1))
                    expect(animator.layoutContainerView.transform.tx).to(beGreaterThan(0))
                    expect(animator.layoutContainerView.transform.ty).to(beGreaterThan(0))
                    expect(animator.layoutContainerView.layer.cornerRadius).to(beCloseTo(13.6, within: 0.001))
                    expect(animator.backgroundView?.visibility).to(beCloseTo(0.75, within: 0.001))
                    expect(shadowView.layer.frame).to(equal(animator.layoutContainerView.layer.frame))
                    expect(CGFloat(shadowView.layer.shadowOpacity)).to(beCloseTo(0.65, within: 0.001))
                    expect(shadowView.layer.shadowRadius).to(beCloseTo(9.5, within: 0.001))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                    expect((shadowView.layer.mask as? CAShapeLayer)?.path).notTo(beNil())
                }

                it("resizes drawer frames from interaction position") {
                    let resizeDelegate = CoreTestResizableDelegate()
                    let finalDimension = FluidFinalFrameDimension(for: FluidTransitionStyle.drawer(position: .bottom),
                                                                  portraitContainerSize: CGSize(width: 320, height: 480),
                                                                  landscapeContainerSize: CGSize(width: 480, height: 320),
                                                                  portraitContentSize: CGSize(width: 320, height: 240),
                                                                  landscapeContentSize: CGSize(width: 480, height: 160),
                                                                  portraitContentTransform: CGAffineTransform.identity,
                                                                  landscapeContentTransform: CGAffineTransform.identity)
                    let fixture = makeCoreTestTransitionFixture(style: .drawer(position: .bottom),
                                                                resizableDelegate: resizeDelegate,
                                                                finalDimension: finalDimension)
                    let animator = fixture.dismissAnimator
                    let shadowView = FluidShadowView(shadowCornerRadius: 8,
                                                     shadowRoundingCorners: nil,
                                                     shadowOpacity: 0.7,
                                                     shadowColor: UIColor.black.cgColor,
                                                     shadowRadius: 6,
                                                     shadowOffset: CGSize(width: 0, height: 4),
                                                     isTransparentBackground: false)

                    fixture.container.addSubview(shadowView)
                    animator.parameters.shadowView = shadowView

                    animator.interactionDidStart(progress: 0, position: 0, info: FluidGestureInfo())
                    defer {
                        animator.animationTimer?.stop()
                        animator.animationTimer = nil
                    }

                    animator.resizePosition = 0.5
                    animator.animationTimerDidUpdate()

                    let expectedTop = animator.baseConstantForResizing - animator.constantRangeForResizing * 0.5

                    expect(animator.shouldPerformResizing).to(beTrue())
                    expect(animator.layout.top.constant).to(beCloseTo(expectedTop, within: 0.001))
                    expect(animator.layoutContainerView.layer.cornerRadius).to(beCloseTo(animator.storedFromStyle.cornerRadius, within: 0.001))
                    expect(shadowView.layer.shadowPath).notTo(beNil())
                }
            }
            describe("Transition scroll observer") {
                it("observes, locks, and restores scroll state") {
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 120, height: 80))
                    let observer = FluidTransitionScrollObserver(view: scrollView)

                    scrollView.contentSize = CGSize(width: 120, height: 240)
                    scrollView.contentOffset = CGPoint(x: 0, y: 12)
                    scrollView.showsVerticalScrollIndicator = true
                    scrollView.showsHorizontalScrollIndicator = true
                    observer.registerParameters(parameters: fixture.dismissDriver.parameters)

                    observer.startObserving()

                    expect(observer.panGestureRecognizer).notTo(beNil())
                    expect(observer.offsetObservation).notTo(beNil())
                    expect(observer.gestureRecognizerShouldBegin(observer.panGestureRecognizer)).to(beTrue())
                    expect(observer.gestureRecognizer(observer.panGestureRecognizer,
                                                      shouldRecognizeSimultaneouslyWith: UIPanGestureRecognizer()))
                        .to(beTrue())
                    expect(observer.description).to(contain("FluidScrollObservable"))

                    observer.updateScroll(progress: 0.4, position: 0, state: .dismissing)

                    expect(observer.isTransitioning).to(beTrue())
                    expect(observer.lockedContentOffset).to(equal(CGPoint(x: 0, y: 12)))
                    expect(scrollView.showsVerticalScrollIndicator).to(beFalse())
                    expect(scrollView.showsHorizontalScrollIndicator).to(beFalse())

                    scrollView.contentOffset = CGPoint(x: 0, y: -20)
                    observer.contentOffsetDidChange(oldValue: CGPoint(x: 0, y: -20))

                    expect(scrollView.contentOffset).to(equal(CGPoint(x: 0, y: 12)))

                    observer.updateScroll(progress: 0, position: 0, state: .none)

                    expect(observer.isTransitioning).to(beFalse())
                    expect(observer.lockedContentOffset).to(beNil())
                    expect(scrollView.showsVerticalScrollIndicator).to(beTrue())
                    expect(scrollView.showsHorizontalScrollIndicator).to(beTrue())

                    observer.disableInteraction()
                    expect(scrollView.isUserInteractionEnabled).to(beFalse())
                    expect(scrollView.isScrollEnabled).to(beFalse())
                    observer.enableInteraction()
                    expect(scrollView.isUserInteractionEnabled).to(beTrue())
                    expect(scrollView.isScrollEnabled).to(beTrue())

                    observer.stopObserving()

                    expect(observer.panGestureRecognizer).to(beNil())
                    expect(observer.offsetObservation).to(beNil())
                }

                it("evaluates dismiss and resize boundaries while scroll view is tracking") {
                    let scrollView = TrackingScrollView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
                    scrollView.contentSize = CGSize(width: 360, height: 360)
                    scrollView.isTrackingOverride = true

                    func makeObserver(style: FluidTransitionStyle) -> FluidTransitionScrollObserver {
                        let fixture = makeCoreTestTransitionFixture(style: style, easing: .linear)
                        let observer = FluidTransitionScrollObserver(view: scrollView)
                        observer.registerParameters(parameters: fixture.dismissDriver.parameters)
                        return observer
                    }

                    let bottomSlide = makeObserver(style: .slide(direction: .fromBottom))
                    bottomSlide.gestureDirection = .bottomCenter
                    scrollView.contentOffset = .zero
                    expect(bottomSlide.isDismissAllowed()).to(beTrue())
                    scrollView.contentOffset = CGPoint(x: 0, y: 24)
                    expect(bottomSlide.isDismissAllowed()).to(beFalse())
                    bottomSlide.gestureDirection = .topCenter
                    scrollView.contentOffset = .zero
                    expect(bottomSlide.isDismissAllowed()).to(beFalse())

                    let topSlide = makeObserver(style: .slide(direction: .fromTop))
                    topSlide.gestureDirection = .topCenter
                    scrollView.contentOffset = CGPoint(x: 0, y: scrollView.maxScrollableY)
                    expect(topSlide.isDismissAllowed()).to(beTrue())

                    let leftSlide = makeObserver(style: .slide(direction: .fromLeft))
                    leftSlide.gestureDirection = .leftMiddle
                    scrollView.contentOffset = CGPoint(x: scrollView.maxScrollableX, y: 0)
                    expect(leftSlide.isDismissAllowed()).to(beTrue())

                    let rightSlide = makeObserver(style: .slide(direction: .fromRight))
                    rightSlide.gestureDirection = .rightMiddle
                    scrollView.contentOffset = .zero
                    expect(rightSlide.isDismissAllowed()).to(beTrue())

                    let fluid = makeObserver(style: .fluid(behavior: .all))
                    fluid.gestureDirection = .bottomCenter
                    scrollView.contentOffset = .zero
                    expect(fluid.isDismissAllowed()).to(beTrue())
                    fluid.gestureDirection = .leftMiddle
                    expect(fluid.isDismissAllowed()).to(beTrue())

                    let scale = makeObserver(style: .scale)
                    scale.gestureDirection = .bottomCenter
                    expect(scale.isDismissAllowed()).to(beTrue())
                    scale.gestureDirection = .none
                    expect(scale.isDismissAllowed()).to(beFalse())

                    let drawer = makeObserver(style: .drawer(position: .bottom))
                    drawer.gestureDirection = .bottomCenter
                    scrollView.contentOffset = .zero
                    expect(drawer.isDismissAllowed()).to(beTrue())
                    expect(drawer.isResizeAllowed()).to(beTrue())
                    scrollView.contentOffset = CGPoint(x: 0, y: 24)
                    expect(drawer.isResizeAllowed()).to(beFalse())
                    scrollView.contentSize = CGSize(width: 120, height: 80)
                    expect(drawer.isResizeAllowed()).to(beTrue())

                    scrollView.contentSize = CGSize(width: 360, height: 360)
                    scrollView.isTrackingOverride = false
                    expect(bottomSlide.isDismissAllowed()).to(beTrue())
                    expect(drawer.isResizeAllowed()).to(beTrue())
                    scrollView.isTrackingOverride = true
                    scrollView.isScrollEnabled = false
                    expect(bottomSlide.isDismissAllowed()).to(beTrue())
                    expect(drawer.isResizeAllowed()).to(beTrue())
                }

                it("locks offsets for fluid and drawer styles without changing drawer interaction") {
                    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
                    scrollView.contentSize = CGSize(width: 360, height: 360)
                    scrollView.contentOffset = CGPoint(x: 8, y: 12)

                    let fluidFixture = makeCoreTestTransitionFixture(style: .fluid(behavior: .all), easing: .linear)
                    let fluid = FluidTransitionScrollObserver(view: scrollView)
                    fluid.registerParameters(parameters: fluidFixture.dismissDriver.parameters)
                    fluid.lockScroll()
                    scrollView.contentOffset = CGPoint(x: 80, y: 80)
                    fluid.contentOffsetDidChange(oldValue: CGPoint(x: 0, y: -10))

                    expect(scrollView.contentOffset).to(equal(CGPoint(x: 8, y: scrollView.minScrollableY)))

                    fluid.unlockScroll()
                    scrollView.contentOffset = CGPoint(x: 8, y: 12)

                    let drawerFixture = makeCoreTestTransitionFixture(style: .drawer(position: .right), easing: .linear)
                    let drawer = FluidTransitionScrollObserver(view: scrollView)
                    drawer.registerParameters(parameters: drawerFixture.dismissDriver.parameters)
                    drawer.lockScroll()
                    scrollView.contentOffset = CGPoint(x: 80, y: 80)
                    drawer.contentOffsetDidChange(oldValue: CGPoint(x: -10, y: 0))

                    expect(scrollView.isUserInteractionEnabled).to(beTrue())
                    expect(scrollView.contentOffset).to(equal(CGPoint(x: 8, y: 12)))

                    drawer.unlockScroll()
                    drawer.abortScroll()

                    expect(scrollView.isScrollEnabled).to(beTrue())
                }
            }
            describe("Transition gesture observer") {
                it("updates gesture parameters, trims history, and delegates callbacks") {
                    let delegate = TestGestureDelegate()
                    let fixture = makeCoreTestTransitionFixture(style: .slide(direction: .fromBottom))
                    let observer = FluidTransitionGestureObserver(delegate: delegate)
                    let pan = StubPanGestureRecognizer()
                    let tap = StubTapGestureRecognizer()
                    let edgePan = StubScreenEdgePanGestureRecognizer()

                    observer.registerParameters(parameters: fixture.dismissDriver.parameters)

                    pan.locationValue = CGPoint(x: 10, y: 12)
                    pan.translationValue = CGPoint(x: 0, y: 20)
                    pan.velocityValue = CGPoint(x: 0, y: 200)
                    observer.updateCurrentParameters(gesture: pan)

                    expect(observer.initialLocation).to(equal(CGPoint(x: 10, y: 12)))
                    expect(observer.currentTranslation).to(equal(CGPoint(x: 0, y: 20)))
                    expect(observer.currentVelocity).to(equal(CGVector(dx: 0, dy: 200)))
                    expect(observer.currentTranslationDirection).to(equal(.bottomCenter))
                    expect(observer.initialGestureDirection).to(equal(.bottomCenter))

                    pan.locationValue = CGPoint(x: 11, y: 13)
                    pan.translationValue = CGPoint(x: 0, y: 24)
                    observer.updateCurrentParameters(gesture: pan)
                    pan.locationValue = CGPoint(x: 12, y: 14)
                    pan.translationValue = CGPoint(x: 0, y: 28)
                    observer.updateCurrentParameters(gesture: pan)
                    pan.locationValue = CGPoint(x: 13, y: 15)
                    pan.translationValue = CGPoint(x: 0, y: 32)
                    observer.updateCurrentParameters(gesture: pan)

                    expect(observer.locationHistory).to(haveCount(3))
                    expect(observer.translationHistory).to(haveCount(3))
                    expect(observer.averageLocation).to(equal(CGPoint(x: 12, y: 14)))
                    expect(observer.averageTranslation).to(equal(CGPoint(x: 0, y: 28)))
                    expect(observer.averageGestureDirection).to(equal(.bottomCenter))

                    observer.updatePreviousParameters()

                    expect(observer.previousLocation).to(equal(CGPoint(x: 13, y: 15)))
                    expect(observer.previousTranslation).to(equal(CGPoint(x: 0, y: 32)))
                    expect(observer.currentGestureDirection).to(equal(FluidGestureDirection.none))

                    observer.currentVelocity = nil
                    expect(observer.currentGestureInfo().locationLocal).to(equal(.zero))

                    tap.locationValue = CGPoint(x: 20, y: 24)
                    observer.handleTapGesture(gesture: tap)

                    expect(delegate.tapUpdateCount).to(equal(1))
                    expect(observer.currentLocation).to(equal(CGPoint(x: 20, y: 24)))

                    pan.locationValue = CGPoint(x: 30, y: 32)
                    pan.translationValue = CGPoint(x: 4, y: 0)
                    observer.handlePanGesture(gesture: pan)

                    expect(delegate.panUpdateCount).to(equal(1))
                    expect(observer.gestureState).to(beNil())

                    edgePan.locationValue = CGPoint(x: 40, y: 42)
                    edgePan.translationValue = CGPoint(x: -6, y: 0)
                    observer.handleEdgePanGesture(gesture: edgePan)

                    expect(delegate.edgePanUpdateCount).to(equal(1))
                    expect(observer.gestureState).to(beNil())
                }

                it("snapshots base locations and evaluates gesture routing") {
                    let delegate = TestGestureDelegate()
                    var retainedPanViews: [UIView] = []

                    func makeObserver(style: FluidTransitionStyle) -> FluidTransitionGestureObserver {
                        let fixture = makeCoreTestTransitionFixture(style: style, easing: .linear)
                        let observer = FluidTransitionGestureObserver(delegate: delegate)
                        let panGestureView = UIView(frame: CGRect(x: 10, y: 20, width: 100, height: 80))
                        retainedPanViews.append(panGestureView)
                        observer.registerParameters(parameters: fixture.dismissDriver.parameters)
                        observer.baseFrame = CGRect(x: 0, y: 0, width: 120, height: 100)
                        observer.panGestureView = panGestureView
                        observer.currentLocation = CGPoint(x: 30, y: 40)
                        return observer
                    }

                    let bottom = makeObserver(style: .drawer(position: .bottom))
                    bottom.snapshotBaseParameters()
                    expect(bottom.initialLocation).to(equal(CGPoint(x: 20, y: 20)))

                    let top = makeObserver(style: .drawer(position: .top))
                    top.snapshotBaseParameters()
                    expect(top.initialLocation).to(equal(CGPoint(x: 30, y: 20)))

                    let left = makeObserver(style: .drawer(position: .left))
                    left.snapshotBaseParameters()
                    expect(left.initialLocation).to(equal(CGPoint(x: 10, y: 40)))

                    let right = makeObserver(style: .drawer(position: .right))
                    right.snapshotBaseParameters()
                    expect(right.initialLocation).to(equal(CGPoint(x: 20, y: 20)))

                    let slide = makeObserver(style: .slide(direction: .fromBottom))
                    slide.snapshotBaseParameters()
                    expect(slide.initialLocation).to(equal(CGPoint(x: 20, y: 20)))
                    slide.panGestureView = nil
                    slide.snapshotBaseParameters()
                    expect(slide.initialLocation).to(beNil())

                    slide.panGestureRecognizer = StubPanGestureRecognizer()
                    slide.edgePanGestureRecognizer = StubScreenEdgePanGestureRecognizer()
                    slide.abortGesture()
                    expect(slide.panGestureRecognizer.isEnabled).to(beTrue())
                    expect(slide.edgePanGestureRecognizer?.isEnabled).to(beTrue())

                    let insidePan = StubPanGestureRecognizer()
                    insidePan.locationValue = CGPoint(x: 20, y: 20)
                    let outsideTap = StubTapGestureRecognizer()
                    outsideTap.locationValue = CGPoint(x: 400, y: 500)
                    let insideTap = StubTapGestureRecognizer()
                    insideTap.locationValue = CGPoint(x: 20, y: 20)
                    let insideEdgePan = StubScreenEdgePanGestureRecognizer()
                    insideEdgePan.locationValue = CGPoint(x: 20, y: 20)

                    expect(slide.handleGestureRecognizerShouldBegin(outsideTap)).to(beTrue())
                    expect(slide.handleGestureRecognizerShouldBegin(insideTap)).to(beFalse())
                    expect(slide.handleGestureRecognizerShouldBegin(insidePan)).to(beTrue())
                    expect(slide.handleGestureRecognizerShouldBegin(insideEdgePan)).to(beTrue())
                    expect(slide.handleGestureRecognizer(insidePan,
                                                         shouldRequireFailureOf: insideEdgePan)).to(beTrue())
                    expect(slide.handleGestureRecognizer(insideEdgePan,
                                                         shouldBeRequiredToFailBy: insidePan)).to(beTrue())
                    expect(slide.handleGestureRecognizer(insideEdgePan,
                                                         shouldRecognizeSimultaneouslyWith: insidePan)).to(beFalse())
                    expect(slide.handleGestureRecognizer(insidePan,
                                                         shouldRecognizeSimultaneouslyWith: insideTap)).to(beTrue())
                }
            }
            describe("FluidLayoutEdgeConstant") {
                it("calculates edge constants from container size and frame") {
                    let constants = FluidLayoutEdgeConstant(
                        size: CGSize(width: 100, height: 80),
                        frame: CGRect(x: 10, y: 12, width: 40, height: 30)
                    )

                    expect(constants.top).to(beCloseTo(12))
                    expect(constants.bottom).to(beCloseTo(-38))
                    expect(constants.left).to(beCloseTo(10))
                    expect(constants.right).to(beCloseTo(-50))
                    expect(String(describing: constants)).to(equal("(t: 12.0, b: -38.0, l: 10.0, r: -50.0)"))
                }

                it("creates optional constants only when all edges are provided") {
                    let constants = FluidLayoutEdgeConstant(top: 1, bottom: 2, left: 3, right: 4)
                    expect(constants).notTo(beNil())
                    expect(constants?.top).to(beCloseTo(1))
                    expect(constants?.bottom).to(beCloseTo(2))
                    expect(constants?.left).to(beCloseTo(3))
                    expect(constants?.right).to(beCloseTo(4))

                    expect(FluidLayoutEdgeConstant(top: nil, bottom: 2, left: 3, right: 4)).to(beNil())
                    expect(FluidLayoutEdgeConstant(top: 1, bottom: nil, left: 3, right: 4)).to(beNil())
                    expect(FluidLayoutEdgeConstant(top: 1, bottom: 2, left: nil, right: 4)).to(beNil())
                    expect(FluidLayoutEdgeConstant(top: 1, bottom: 2, left: 3, right: nil)).to(beNil())
                }

                it("applies only provided edge overrides") {
                    var constants = FluidLayoutEdgeConstant(top: 1, bottom: 2, left: 3, right: 4)!
                    constants.apply(top: 10, right: 40)

                    expect(constants).to(equal(FluidLayoutEdgeConstant(top: 10, bottom: 2, left: 3, right: 40)))
                    expect(constants).notTo(equal(FluidLayoutEdgeConstant(top: 1, bottom: 2, left: 3, right: 4)))
                }
            }
            describe("FluidLayout generator") {
                it("creates expected frames for slide and drawer styles") {
                    let containerSize = CGSize(width: 320, height: 480)

                    expect(FluidLayout.createFrame(for: .slide(direction: .fromTop),
                                                   containerSize: containerSize,
                                                   contentOrigin: nil,
                                                   contentSize: nil,
                                                   idiom: .phone,
                                                   isInitial: true))
                        .to(equal(CGRect(x: 0, y: -480, width: 320, height: 480)))

                    expect(FluidLayout.createFrame(for: .slide(direction: .fromRight),
                                                   containerSize: containerSize,
                                                   contentOrigin: nil,
                                                   contentSize: nil,
                                                   idiom: .phone,
                                                   isInitial: true))
                        .to(equal(CGRect(x: 320, y: 0, width: 320, height: 480)))

                    expect(FluidLayout.createFrame(for: .drawer(position: .bottom),
                                                   containerSize: containerSize,
                                                   contentOrigin: nil,
                                                   contentSize: nil,
                                                   idiom: .phone,
                                                   isInitial: false))
                        .to(equal(CGRect(x: 0, y: 120, width: 320, height: 360)))

                    expect(FluidLayout.createFrame(for: .drawer(position: .left),
                                                   containerSize: containerSize,
                                                   contentOrigin: nil,
                                                   contentSize: nil,
                                                   idiom: .phone,
                                                   isInitial: false))
                        .to(equal(CGRect(x: 0, y: 0, width: 228, height: 480)))
                }

                it("activates, applies, and deactivates transition edge constraints") {
                    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
                    let content = UIView(frame: .zero)
                    content.translatesAutoresizingMaskIntoConstraints = false
                    container.addSubview(content)
                    var layout = FluidLayout(for: .slide(direction: .fromBottom),
                                             presentationType: .transition,
                                             container: container,
                                             content: content,
                                             containerSize: CGSize(width: 320, height: 480),
                                             contentSize: CGSize(width: 240, height: 300))

                    expect(String(describing: FluidLayout.FluidPresentationType.navigation)).to(equal("navigation"))
                    expect(String(describing: FluidLayout.FluidPresentationType.transition)).to(equal("transition"))
                    expect(layout.isFullScreen).to(beFalse())
                    expect(layout.top.isActive).to(beFalse())
                    expect(layout.bottom.isActive).to(beFalse())
                    expect(layout.left.isActive).to(beFalse())
                    expect(layout.right.isActive).to(beFalse())

                    layout.activate(type: .transition)

                    expect(layout.top.isActive).to(beTrue())
                    expect(layout.bottom.isActive).to(beTrue())
                    expect(layout.left.isActive).to(beTrue())
                    expect(layout.right.isActive).to(beTrue())

                    layout.apply(top: 0, bottom: 0, left: 0, right: 0)

                    expect(layout.isFullScreen).to(beTrue())

                    layout.apply(top: 12, right: 24)

                    expect(layout.top.constant).to(beCloseTo(12))
                    expect(layout.bottom.constant).to(beCloseTo(0))
                    expect(layout.left.constant).to(beCloseTo(0))
                    expect(layout.right.constant).to(beCloseTo(24))

                    layout.deactivate(type: .transition)

                    expect(layout.top.isActive).to(beFalse())
                    expect(layout.bottom.isActive).to(beFalse())
                    expect(layout.left.isActive).to(beFalse())
                    expect(layout.right.isActive).to(beFalse())

                    let navigationLayout = FluidLayout(for: .scale,
                                                       presentationType: .navigation,
                                                       container: container,
                                                       content: content,
                                                       containerSize: CGSize(width: 320, height: 480),
                                                       contentSize: nil)

                    expect(navigationLayout.isFullScreen).to(beTrue())
                    navigationLayout.deactivate(type: .navigation)
                }

                it("creates drawer edge anchors for each exposed side") {
                    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
                    let content = UIView(frame: .zero)
                    container.addSubview(content)
                    let containerSize = CGSize(width: 320, height: 480)
                    let contentSize = CGSize(width: 200, height: 160)

                    let top = FluidLayout.topEdgeDrawerAnchors(container, content, containerSize, contentSize)
                    let bottom = FluidLayout.bottomEdgeDrawerAnchors(container, content, containerSize, contentSize)
                    let left = FluidLayout.leftEdgeDrawerAnchors(container, content, containerSize, contentSize)
                    let right = FluidLayout.rightEdgeDrawerAnchors(container, content, containerSize, contentSize)

                    expect(top.top.constant).to(beCloseTo(0))
                    expect(top.bottom.constant).to(beCloseTo(320))
                    expect(top.left.constant).to(beCloseTo(60))
                    expect(top.right.constant).to(beCloseTo(60))

                    expect(bottom.top.constant).to(beCloseTo(320))
                    expect(bottom.bottom.constant).to(beCloseTo(0))
                    expect(bottom.left.constant).to(beCloseTo(60))
                    expect(bottom.right.constant).to(beCloseTo(60))

                    expect(left.top.constant).to(beCloseTo(160))
                    expect(left.bottom.constant).to(beCloseTo(160))
                    expect(left.left.constant).to(beCloseTo(0))
                    expect(left.right.constant).to(beCloseTo(120))

                    expect(right.top.constant).to(beCloseTo(160))
                    expect(right.bottom.constant).to(beCloseTo(160))
                    expect(right.left.constant).to(beCloseTo(120))
                    expect(right.right.constant).to(beCloseTo(0))
                }

                it("creates fluid size constants for idiom and transition state") {
                    let portrait = CGSize(width: 320, height: 480)
                    let landscape = CGSize(width: 600, height: 400)

                    expect(FluidLayout.sizeConstant(for: .fluid(behavior: .scale),
                                                    containerSize: portrait,
                                                    idiom: .phone,
                                                    isInitial: true))
                        .to(equal(CGSize(width: 173, height: 346)))
                    expect(FluidLayout.sizeConstant(for: .fluid(behavior: .scale),
                                                    containerSize: portrait,
                                                    idiom: .phone,
                                                    isInitial: false))
                        .to(equal(portrait))
                    expect(FluidLayout.sizeConstant(for: .fluid(behavior: .scale),
                                                    containerSize: landscape,
                                                    idiom: .pad,
                                                    isInitial: true))
                        .to(equal(CGSize(width: 324, height: 288)))
                    expect(FluidLayout.sizeConstant(for: .fluid(behavior: .scale),
                                                    containerSize: landscape,
                                                    idiom: .pad,
                                                    isInitial: false))
                        .to(equal(landscape))
                }

                it("creates center and size constraints for full screen content") {
                    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
                    let content = UIView(frame: .zero)
                    container.addSubview(content)

                    let constraints = FluidLayout.centeredFullScreenAnchors(container, content)

                    expect(constraints.midX.firstAttribute).to(equal(NSLayoutConstraint.Attribute.centerX))
                    expect(constraints.midY.firstAttribute).to(equal(NSLayoutConstraint.Attribute.centerY))
                    expect(constraints.width.firstAttribute).to(equal(NSLayoutConstraint.Attribute.width))
                    expect(constraints.height.firstAttribute).to(equal(NSLayoutConstraint.Attribute.height))
                    expect(constraints.midX.constant).to(beCloseTo(0))
                    expect(constraints.midY.constant).to(beCloseTo(0))
                    expect(constraints.width.constant).to(beCloseTo(0))
                    expect(constraints.height.constant).to(beCloseTo(0))
                }

                it("derives layout traits from size orientation") {
                    let portrait = FluidLayout.trait(for: CGSize(width: 320, height: 480))
                    let landscape = FluidLayout.trait(for: CGSize(width: 480, height: 320))

                    expect(portrait.horizontalSizeClass).to(equal(UIUserInterfaceSizeClass.compact))
                    expect(portrait.verticalSizeClass).to(equal(UIUserInterfaceSizeClass.regular))
                    expect(landscape.horizontalSizeClass).to(equal(UIUserInterfaceSizeClass.regular))
                    expect(landscape.verticalSizeClass).to(equal(UIUserInterfaceSizeClass.compact))
                }
            }
            describe("FluidFrameStyle validation") {
                it("fills initial style defaults from presentation style and final style") {
                    var scaleStyle = FluidInitialFrameStyle(alpha: nil, cornerRadius: 2)
                    var drawerStyle = FluidInitialFrameStyle(alpha: nil, cornerRadius: 3)
                    var finalStyle = FluidFinalFrameStyle(alpha: nil, cornerRadius: 8, cornerStyle: .top)
                    finalStyle = finalStyle.validate(for: .drawer(position: .bottom))

                    let validatedScale = scaleStyle.validate(for: .scale, finalFrameStyle: finalStyle)
                    let validatedDrawer = drawerStyle.validate(for: .drawer(position: .bottom), finalFrameStyle: finalStyle)

                    expect(validatedScale.alpha).to(beCloseTo(0))
                    expect(validatedDrawer.alpha).to(beCloseTo(1))
                    expect(validatedScale.cornerStyle?.rawValue).to(equal(finalStyle.cornerStyle?.rawValue))
                    expect(validatedDrawer.cornerStyle?.rawValue).to(equal(finalStyle.cornerStyle?.rawValue))
                    expect(validatedScale.isTransparentBackground).to(equal(finalStyle.isTransparentBackground))
                    expect(validatedDrawer.isTransparentBackground).to(equal(finalStyle.isTransparentBackground))
                }

                it("maps drawer positions to exposed final corners") {
                    var top = FluidFinalFrameStyle(alpha: nil, cornerStyle: nil)
                    var right = FluidFinalFrameStyle(alpha: nil, cornerStyle: nil)
                    var bottom = FluidFinalFrameStyle(alpha: nil, cornerStyle: nil)
                    var left = FluidFinalFrameStyle(alpha: nil, cornerStyle: nil)

                    expect(top.validate(for: .drawer(position: .top)).cornerStyle?.rawValue).to(equal(FluidRoundCornerStyle.bottom.rawValue))
                    expect(right.validate(for: .drawer(position: .right)).cornerStyle?.rawValue).to(equal(FluidRoundCornerStyle.left.rawValue))
                    expect(bottom.validate(for: .drawer(position: .bottom)).cornerStyle?.rawValue).to(equal(FluidRoundCornerStyle.top.rawValue))
                    expect(left.validate(for: .drawer(position: .left)).cornerStyle?.rawValue).to(equal(FluidRoundCornerStyle.right.rawValue))
                }
            }
            describe("FluidFrameDimension") {
                it("creates initial frames from explicit transition containers") {
                    let containerSize = CGSize(width: 320, height: 480)
                    let contentOrigin = CGPoint(x: 12, y: 24)
                    let contentSize = CGSize(width: 120, height: 160)
                    let transform = CATransform3DMakeTranslation(4, 5, 0)
                    let dimension = FluidInitialFrameDimension(
                        for: FluidTransitionStyle.slide(direction: .fromLeft),
                        containerSize: containerSize,
                        contentOrigin: contentOrigin,
                        contentSize: contentSize,
                        contentTransform: transform
                    )

                    expect(dimension.frame()).to(equal(FluidLayout.createFrame(for: .slide(direction: .fromLeft),
                                                                               containerSize: containerSize,
                                                                               contentOrigin: contentOrigin,
                                                                               contentSize: contentSize,
                                                                               idiom: UIDevice.current.userInterfaceIdiom,
                                                                               isInitial: true)))
                    expect(CATransform3DEqualToTransform(dimension.transform(), transform)).to(beTrue())
                }

                it("selects final frames by portrait and landscape container orientation") {
                    let portraitContainer = CGSize(width: 320, height: 480)
                    let landscapeContainer = CGSize(width: 480, height: 320)
                    let portraitOrigin = CGPoint(x: 10, y: 20)
                    let portraitSize = CGSize(width: 200, height: 240)
                    let landscapeOrigin = CGPoint(x: 30, y: 40)
                    let landscapeSize = CGSize(width: 260, height: 180)
                    let portraitTransform = CATransform3DMakeScale(1.1, 1.2, 1)
                    let landscapeTransform = CATransform3DMakeTranslation(7, 8, 0)
                    let dimension = FluidFinalFrameDimension(
                        for: FluidTransitionStyle.drawer(position: .bottom),
                        portraitContainerSize: portraitContainer,
                        landscapeContainerSize: landscapeContainer,
                        portraitContentOrigin: portraitOrigin,
                        portraitContentSize: portraitSize,
                        landscapeContentOrigin: landscapeOrigin,
                        landscapeContentSize: landscapeSize,
                        portraitContentTransform: portraitTransform,
                        landscapeContentTransform: landscapeTransform
                    )

                    expect(dimension.frame(for: portraitContainer)).to(equal(FluidLayout.createFrame(for: .drawer(position: .bottom),
                                                                                                     containerSize: portraitContainer,
                                                                                                     contentOrigin: portraitOrigin,
                                                                                                     contentSize: portraitSize,
                                                                                                     idiom: UIDevice.current.userInterfaceIdiom,
                                                                                                     isInitial: false)))
                    expect(dimension.frame(for: landscapeContainer)).to(equal(FluidLayout.createFrame(for: .drawer(position: .bottom),
                                                                                                      containerSize: landscapeContainer,
                                                                                                      contentOrigin: landscapeOrigin,
                                                                                                      contentSize: landscapeSize,
                                                                                                      idiom: UIDevice.current.userInterfaceIdiom,
                                                                                                      isInitial: false)))
                    expect(CATransform3DEqualToTransform(dimension.transform(for: portraitContainer), portraitTransform)).to(beTrue())
                    expect(CATransform3DEqualToTransform(dimension.transform(for: landscapeContainer), landscapeTransform)).to(beTrue())
                }
            }
        }
        describe("NSLayoutConstraint") {
            let prefix: String = "test"
            let parentView: UIView = .init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            let childView: UIView = .init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            parentView.addSubview(childView)
            let topAnchor: NSLayoutConstraint = childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 0).named(for: .top, prefix: prefix)
            let bottomAnchor: NSLayoutConstraint = childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: 0).named(for: .top, prefix: prefix)
            let leftAnchor: NSLayoutConstraint = childView.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 0).named(for: .left, prefix: prefix)
            let rightAnchor: NSLayoutConstraint = childView.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: 0).named(for: .right, prefix: prefix)

            it("Property") {
                expect(topAnchor.isActive).to(beFalse())
                expect(bottomAnchor.isActive).to(beFalse())
                expect(leftAnchor.isActive).to(beFalse())
                expect(rightAnchor.isActive).to(beFalse())

                topAnchor.activate()
                bottomAnchor.activate()
                leftAnchor.activate()
                rightAnchor.activate()
                expect(topAnchor.isActive).to(beTrue())
                expect(bottomAnchor.isActive).to(beTrue())
                expect(leftAnchor.isActive).to(beTrue())
                expect(rightAnchor.isActive).to(beTrue())
                parentView.updateConstraintsAndLayoutImmediately()

                expect(topAnchor.identifier).to(match(parentView.constraint(for: .top, prefix: prefix)?.identifier))
                expect(bottomAnchor.identifier).to(match(parentView.constraint(for: .bottom, prefix: prefix)?.identifier))
                expect(leftAnchor.identifier).to(match(parentView.constraint(for: .left, prefix: prefix)?.identifier))
                expect(rightAnchor.identifier).to(match(parentView.constraint(for: .right, prefix: prefix)?.identifier))

                topAnchor.deactivate()
                bottomAnchor.deactivate()
                leftAnchor.deactivate()
                rightAnchor.deactivate()
                expect(topAnchor.isActive).to(beFalse())
                expect(bottomAnchor.isActive).to(beFalse())
                expect(leftAnchor.isActive).to(beFalse())
                expect(rightAnchor.isActive).to(beFalse())
                parentView.setNeedsUpdateConstraintsAndLayout()
                parentView.updateConstraintsAndLayoutIfNeeded()

                topAnchor.toggle()
                bottomAnchor.toggle()
                leftAnchor.toggle()
                rightAnchor.toggle()
                expect(topAnchor.isActive).to(beTrue())
                expect(bottomAnchor.isActive).to(beTrue())
                expect(leftAnchor.isActive).to(beTrue())
                expect(rightAnchor.isActive).to(beTrue())
                parentView.updateConstraintsAndLayoutImmediately()
            }
            it("Description") {
                expect(String(describing: NSLayoutConstraint.Attribute.left)).to(match("left"))
                expect(String(describing: NSLayoutConstraint.Attribute.right)).to(match("right"))
                expect(String(describing: NSLayoutConstraint.Attribute.top)).to(match("top"))
                expect(String(describing: NSLayoutConstraint.Attribute.bottom)).to(match("bottom"))
                expect(String(describing: NSLayoutConstraint.Attribute.leading)).to(match("leading"))
                expect(String(describing: NSLayoutConstraint.Attribute.trailing)).to(match("trailing"))
                expect(String(describing: NSLayoutConstraint.Attribute.width)).to(match("width"))
                expect(String(describing: NSLayoutConstraint.Attribute.height)).to(match("height"))
                expect(String(describing: NSLayoutConstraint.Attribute.centerX)).to(match("centerX"))
                expect(String(describing: NSLayoutConstraint.Attribute.centerY)).to(match("centerY"))
                expect(String(describing: NSLayoutConstraint.Attribute.lastBaseline)).to(match("lastBaseline"))
                expect(String(describing: NSLayoutConstraint.Attribute.firstBaseline)).to(match("firstBaseline"))
                expect(String(describing: NSLayoutConstraint.Attribute.leftMargin)).to(match("leftMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.rightMargin)).to(match("rightMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.topMargin)).to(match("topMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.bottomMargin)).to(match("bottomMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.leadingMargin)).to(match("leadingMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.trailingMargin)).to(match("trailingMargin"))
                expect(String(describing: NSLayoutConstraint.Attribute.centerXWithinMargins)).to(match("centerXWithinMargins"))
                expect(String(describing: NSLayoutConstraint.Attribute.centerYWithinMargins)).to(match("centerYWithinMargins"))
                expect(String(describing: NSLayoutConstraint.Attribute.notAnAttribute)).to(match("notAnAttribute"))
            }
        }

        describe("UIGestureRecognizer") {
            it("Property") {
                expect(UIScreenEdgePanGestureRecognizer().isEdgePan).to(beTrue())
                expect(UIScreenEdgePanGestureRecognizer().isNormalPan).to(beFalse())
                expect(UIPanGestureRecognizer().isEdgePan).to(beFalse())
                expect(UIPanGestureRecognizer().isNormalPan).to(beTrue())
            }
            it("Description") {
                expect(String(describing: UIGestureRecognizer.State.possible)).to(match("possible"))
                expect(String(describing: UIGestureRecognizer.State.began)).to(match("began"))
                expect(String(describing: UIGestureRecognizer.State.changed)).to(match("changed"))
                expect(String(describing: UIGestureRecognizer.State.ended)).to(match("ended"))
                expect(String(describing: UIGestureRecognizer.State.cancelled)).to(match("cancelled"))
                expect(String(describing: UIGestureRecognizer.State.failed)).to(match("failed"))
            }
        }
        describe("UIDeviceOrientation") {
            it("Description") {
                expect(String(describing: UIDeviceOrientation.portrait)).to(match("portrait"))
                expect(String(describing: UIDeviceOrientation.portraitUpsideDown)).to(match("portraitUpsideDown"))
                expect(String(describing: UIDeviceOrientation.landscapeRight)).to(match("landscapeRight"))
                expect(String(describing: UIDeviceOrientation.landscapeLeft)).to(match("landscapeLeft"))
                expect(String(describing: UIDeviceOrientation.faceUp)).to(match("faceUp"))
                expect(String(describing: UIDeviceOrientation.faceDown)).to(match("faceDown"))
                expect(String(describing: UIDeviceOrientation.unknown)).to(match("unknown"))
            }
        }
        describe("UIModalPresentationStyle") {
            it("Description") {
                expect(String(describing: UIModalPresentationStyle.fullScreen)).to(match("fullScreen"))
                expect(String(describing: UIModalPresentationStyle.pageSheet)).to(match("pageSheet"))
                expect(String(describing: UIModalPresentationStyle.formSheet)).to(match("formSheet"))
                expect(String(describing: UIModalPresentationStyle.currentContext)).to(match("currentContext"))
                expect(String(describing: UIModalPresentationStyle.custom)).to(match("custom"))
                expect(String(describing: UIModalPresentationStyle.overFullScreen)).to(match("overFullScreen"))
                expect(String(describing: UIModalPresentationStyle.overCurrentContext)).to(match("overCurrentContext"))
                expect(String(describing: UIModalPresentationStyle.popover)).to(match("popover"))
                expect(String(describing: UIModalPresentationStyle.none)).to(match("none"))
            }
        }
        describe("UIUserInterfaceIdiom") {
            it("Property") {
                if UIDevice.current.userInterfaceIdiom.isPhone {
                    expect(UIDevice.current.userInterfaceIdiom.isPhone).to(beTrue())
                    expect(UIDevice.current.userInterfaceIdiom.isPad).to(beFalse())
                } else if UIDevice.current.userInterfaceIdiom.isPad {
                    expect(UIDevice.current.userInterfaceIdiom.isPhone).to(beFalse())
                    expect(UIDevice.current.userInterfaceIdiom.isPad).to(beTrue())
                }
            }
            it("Description") {
                expect(String(describing: UIUserInterfaceIdiom.phone)).to(match("phone"))
                expect(String(describing: UIUserInterfaceIdiom.pad)).to(match("pad"))
                expect(String(describing: UIUserInterfaceIdiom.carPlay)).to(match("carPlay"))
                expect(String(describing: UIUserInterfaceIdiom.tv)).to(match("tv"))
                expect(String(describing: UIUserInterfaceIdiom.unspecified)).to(match("unspecified"))
            }
        }
        describe("UIViewPropertyAnimator") {
            it("Initialization") {
                expect(UIViewPropertyAnimator(duration: 1, easing: .linear).duration).to(equal(1))
                let cubicParam0: UICubicTimingParameters = .init(0.47, 0, 0.745, 0.715)
                let cubicParam1: UICubicTimingParameters = .init(controlPoint1: CGPoint(x: 0.47, y: 0), controlPoint2: CGPoint(x: 0.745, y: 0.715))
                expect(cubicParam0.controlPoint1.x).to(beCloseTo(cubicParam1.controlPoint1.x))
                expect(cubicParam0.controlPoint1.y).to(beCloseTo(cubicParam1.controlPoint1.y))
                expect(cubicParam0.controlPoint2.x).to(beCloseTo(cubicParam1.controlPoint2.x))
                expect(cubicParam0.controlPoint2.y).to(beCloseTo(cubicParam1.controlPoint2.y))
                let springOptions: UISpringTimingParameters.SpringParameters = UISpringTimingParameters.parameters(dampingRatio: FluidConst.springDampingRatio, frequencyResponse: FluidConst.springFrequencyResponse)
                let springParam0: UISpringTimingParameters = .init(dampingRatio: FluidConst.springDampingRatio, frequencyResponse: FluidConst.springFrequencyResponse)
                let springParam1: UISpringTimingParameters = .init(mass: springOptions.mass, stiffness: springOptions.stiffness, damping: springOptions.damping, initialVelocity: springOptions.velocity)
                expect(springParam0.initialVelocity).to(equal(springParam1.initialVelocity))
                expect(springParam0.timingCurveType).to(equal(springParam1.timingCurveType))
                let springDuration0: TimeInterval = UISpringTimingParameters.duration(dampingRatio: FluidConst.springDampingRatio, frequencyResponse: FluidConst.springFrequencyResponse)
                let springDuration1: TimeInterval = UISpringTimingParameters.duration(mass: springOptions.mass, stiffness: springOptions.stiffness, damping: springOptions.damping, velocity: springOptions.velocity)
                expect(springDuration0).to(beCloseTo(springDuration1))
            }
            it("Description") {
                expect(String(describing: UITimingCurveType.builtin)).to(match("builtin"))
                expect(String(describing: UITimingCurveType.cubic)).to(match("cubic"))
                expect(String(describing: UITimingCurveType.spring)).to(match("spring"))
                expect(String(describing: UITimingCurveType.composed)).to(match("composed"))

                expect(String(describing: UIViewAnimatingPosition.end)).to(match("end"))
                expect(String(describing: UIViewAnimatingPosition.start)).to(match("start"))
                expect(String(describing: UIViewAnimatingPosition.current)).to(match("current"))

                expect(String(describing: UIViewAnimatingState.active)).to(match("active"))
                expect(String(describing: UIViewAnimatingState.inactive)).to(match("inactive"))
                expect(String(describing: UIViewAnimatingState.stopped)).to(match("stopped"))
                expect(String(describing: UIViewAnimatingState(rawValue: 3))).to(match("nil"))
            }
        }
        describe("UIScrollView") {
            let scrollView: UIScrollView = .init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            let childView: UIView = .init(frame: CGRect(x: 0, y: 0, width: 1000, height: 1000))
            scrollView.setContentOffset(CGPoint(x: 0, y: 100), animated: false)
            scrollView.addSubview(childView)
            it("Property") {
                expect(scrollView.minScrollableX).to(equal(0))
                expect(scrollView.maxScrollableX).to(equal(-1000))
                expect(scrollView.minScrollableY).to(equal(0))
                expect(scrollView.maxScrollableY).to(equal(-1000))
                expect(scrollView.normalizedContentOffset).to(equal(CGPoint(x: 0, y: 100)))
                expect(scrollView.effectiveContentInset).to(equal(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)))
            }
        }
        describe("AdaptiveLayout") {
            it("generates trait collections from adaptive attributes") {
                expect(Idiom.phone.generateTraitCollection().userInterfaceIdiom).to(equal(.phone))
                expect(Idiom.pad.generateTraitCollection().userInterfaceIdiom).to(equal(.pad))
                expect(Idiom.tv.generateTraitCollection().userInterfaceIdiom).to(equal(.tv))
                expect(Idiom.carPlay.generateTraitCollection().userInterfaceIdiom).to(equal(.carPlay))

                expect(Scale.oneX.generateTraitCollection().displayScale).to(equal(1))
                expect(Scale.twoX.generateTraitCollection().displayScale).to(equal(2))
                expect(Scale.threeX.generateTraitCollection().displayScale).to(equal(3))
                expect(Scale.fourX.generateTraitCollection().displayScale).to(equal(4))

                expect(SizeClass.horizontalCompact.generateTraitCollection().horizontalSizeClass).to(equal(.compact))
                expect(SizeClass.horizontalRegular.generateTraitCollection().horizontalSizeClass).to(equal(.regular))
                expect(SizeClass.verticalCompact.generateTraitCollection().verticalSizeClass).to(equal(.compact))
                expect(SizeClass.verticalRegular.generateTraitCollection().verticalSizeClass).to(equal(.regular))

                expect(ForceTouch.available.generateTraitCollection().forceTouchCapability).to(equal(.available))
                expect(ForceTouch.unavailable.generateTraitCollection().forceTouchCapability).to(equal(.unavailable))

                if #available(iOS 10.0, *) {
                    expect(LayoutDirection.leftToRight.generateTraitCollection().layoutDirection).to(equal(.leftToRight))
                    expect(LayoutDirection.rightToLeft.generateTraitCollection().layoutDirection).to(equal(.rightToLeft))
                    expect(DisplayGamut.SRGB.generateTraitCollection().displayGamut).to(equal(.SRGB))
                    expect(DisplayGamut.P3.generateTraitCollection().displayGamut).to(equal(.P3))

                    let sizeCategories: [(SizeCategory, UIContentSizeCategory)] = [
                        (.extraSmall, .extraSmall),
                        (.small, .small),
                        (.medium, .medium),
                        (.large, .large),
                        (.extraLarge, .extraLarge),
                        (.extraExtraLarge, .extraExtraLarge),
                        (.extraExtraExtraLarge, .extraExtraExtraLarge),
                        (.accessibilityMedium, .accessibilityMedium),
                        (.accessibilityLarge, .accessibilityLarge),
                        (.accessibilityExtraLarge, .accessibilityExtraLarge),
                        (.accessibilityExtraExtraLarge, .accessibilityExtraExtraLarge),
                        (.accessibilityExtraExtraExtraLarge, .accessibilityExtraExtraExtraLarge),
                    ]

                    sizeCategories.forEach { (attribute, expectedCategory) in
                        expect(attribute.generateTraitCollection().preferredContentSizeCategory).to(equal(expectedCategory))
                    }
                }
            }

            it("maps trait collections back to adaptive attributes") {
                let attributes: [AdaptiveAttribute] = [
                    Idiom.pad,
                    Scale.twoX,
                    SizeClass.horizontalCompact,
                    SizeClass.verticalRegular,
                    ForceTouch.available,
                    LayoutDirection.rightToLeft,
                    SizeCategory.accessibilityLarge,
                    DisplayGamut.P3,
                ]
                let traits = UITraitCollection(attributes: attributes)

                expect(traits.contains(Idiom.pad)).to(beTrue())
                expect(traits.contains(Idiom.phone)).to(beFalse())
                expect(traits.contains(Scale.twoX)).to(beTrue())
                expect(traits.contains(SizeClass.horizontalCompact)).to(beTrue())
                expect(traits.contains(SizeClass.verticalRegular)).to(beTrue())
                expect(traits.contains(ForceTouch.available)).to(beTrue())
                expect(traits.contains(LayoutDirection.rightToLeft)).to(beTrue())
                expect(traits.contains(SizeCategory.accessibilityLarge)).to(beTrue())
                expect(traits.contains(DisplayGamut.P3)).to(beTrue())

                let adaptiveAttributes = traits.adaptiveAttributes

                expect(adaptiveAttributes.contains { ($0 as? Idiom) == .pad }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? Scale) == .twoX }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? SizeClass) == .horizontalCompact }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? SizeClass) == .verticalRegular }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? ForceTouch) == .available }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? LayoutDirection) == .rightToLeft }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? SizeCategory) == .accessibilityLarge }).to(beTrue())
                expect(adaptiveAttributes.contains { ($0 as? DisplayGamut) == .P3 }).to(beTrue())
            }

            it("updates behaviors, constraints, and views through an adaptive interface") {
                let adaptiveInterface = TestAdaptiveInterface()
                let parent = UIView()
                let directChild = UIView()
                let attributesChild = UIView()
                let attributeChild = UIView()
                let directWidth = directChild.widthAnchor.constraint(equalToConstant: 44)
                let attributesWidth = attributesChild.widthAnchor.constraint(equalToConstant: 45)
                let attributeWidth = attributeChild.widthAnchor.constraint(equalToConstant: 46)
                var behaviorCount = 0
                var counterBehaviorCount = 0

                adaptiveInterface.addBehavior(for: UITraitCollection(attributes: [Idiom.pad]),
                                              behavior: { behaviorCount += 1 },
                                              counterBehavior: { counterBehaviorCount += 1 })
                adaptiveInterface.addBehavior(for: [Scale.twoX],
                                              behavior: { behaviorCount += 1 },
                                              counterBehavior: { counterBehaviorCount += 1 })
                adaptiveInterface.addBehavior(for: SizeClass.horizontalRegular,
                                              behavior: { behaviorCount += 1 },
                                              counterBehavior: { counterBehaviorCount += 1 })

                adaptiveInterface.addConstraints(for: UITraitCollection(attributes: [Idiom.pad]),
                                                 constraints: [directWidth])
                adaptiveInterface.addConstraints(for: [Scale.twoX],
                                                 constraints: attributesWidth)
                adaptiveInterface.addConstraints(for: SizeClass.horizontalRegular,
                                                 constraints: attributeWidth)

                adaptiveInterface.addView(for: UITraitCollection(attributes: [Idiom.pad]),
                                          view: directChild,
                                          parent: parent,
                                          constraints: [])
                adaptiveInterface.addView(for: [Scale.twoX],
                                          view: attributesChild,
                                          parent: parent,
                                          constraints: [])
                adaptiveInterface.addView(for: SizeClass.horizontalRegular,
                                          view: attributeChild,
                                          parent: parent,
                                          constraints: [])

                let nonMatchingTraits = UITraitCollection(attributes: [Idiom.phone, Scale.threeX, SizeClass.horizontalCompact])
                adaptiveInterface.update(for: nonMatchingTraits)

                expect(behaviorCount).to(equal(0))
                expect(counterBehaviorCount).to(equal(3))
                expect(directWidth.isActive).to(beFalse())
                expect(attributesWidth.isActive).to(beFalse())
                expect(attributeWidth.isActive).to(beFalse())
                expect(directChild.superview).to(beNil())
                expect(attributesChild.superview).to(beNil())
                expect(attributeChild.superview).to(beNil())

                let matchingTraits = UITraitCollection(attributes: [Idiom.pad, Scale.twoX, SizeClass.horizontalRegular])
                adaptiveInterface.update(for: matchingTraits)

                expect(behaviorCount).to(equal(3))
                expect(counterBehaviorCount).to(equal(3))
                expect(directWidth.isActive).to(beTrue())
                expect(attributesWidth.isActive).to(beTrue())
                expect(attributeWidth.isActive).to(beTrue())
                expect(directChild.superview).to(beIdenticalTo(parent))
                expect(attributesChild.superview).to(beIdenticalTo(parent))
                expect(attributeChild.superview).to(beIdenticalTo(parent))
            }

            it("updates nonmatching adaptive elements before matching elements") {
                let adaptiveInterface = TestAdaptiveInterface()
                let recorder = AdaptiveUpdateRecorder()
                let matchingTraits = UITraitCollection(attributes: [Idiom.pad])

                adaptiveInterface.adaptiveElements = [
                    RecordingAdaptiveElement(traitCollection: matchingTraits,
                                             label: "matching",
                                             recorder: recorder),
                    RecordingAdaptiveElement(traitCollection: UITraitCollection(attributes: [Idiom.phone]),
                                             label: "nonmatching",
                                             recorder: recorder),
                ]

                adaptiveInterface.update(for: matchingTraits)

                expect(recorder.labels).to(equal(["nonmatching", "matching"]))
            }
        }
        describe("UIBezierPath") {
            it("Initialization") {
                let path0: UIBezierPath = UIBezierPath(bounds: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 10, roundingCorners: .allCorners)
                expect(path0.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 100)))
                let path1: UIBezierPath = UIBezierPath(bounds: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 10, roundingCorners: .none)
                expect(path1.bounds).to(equal(CGRect(x: 0, y: 0, width: 100, height: 100)))
            }
        }
    }
}

private final class CoreTestFluidViewController: UIViewController, Fluidable, FluidResizable {}

private final class CoreTestFluidNavigationController: UINavigationController, Fluidable {}

private final class CoreTestTransitionContext: NSObject, UIViewControllerContextTransitioning {
    let containerView: UIView
    var isAnimated: Bool
    var isInteractive: Bool
    var transitionWasCancelled: Bool
    var presentationStyle: UIModalPresentationStyle
    var completedTransitions: [Bool] = []
    var updatedPercentCompletes: [CGFloat] = []
    var didFinishInteractiveTransition = false
    var didCancelInteractiveTransition = false
    var didPauseInteractiveTransition = false

    private let fromViewController: UIViewController
    private let toViewController: UIViewController

    init(container: UIView,
         from fromViewController: UIViewController,
         to toViewController: UIViewController,
         transitionWasCancelled: Bool = false,
         isAnimated: Bool = true,
         isInteractive: Bool = false,
         presentationStyle: UIModalPresentationStyle = .custom) {
        self.containerView = container
        self.fromViewController = fromViewController
        self.toViewController = toViewController
        self.transitionWasCancelled = transitionWasCancelled
        self.isAnimated = isAnimated
        self.isInteractive = isInteractive
        self.presentationStyle = presentationStyle
        super.init()
    }

    func updateInteractiveTransition(_ percentComplete: CGFloat) {
        self.updatedPercentCompletes.append(percentComplete)
    }

    func finishInteractiveTransition() {
        self.didFinishInteractiveTransition = true
    }

    func cancelInteractiveTransition() {
        self.didCancelInteractiveTransition = true
        self.transitionWasCancelled = true
    }

    func pauseInteractiveTransition() {
        self.didPauseInteractiveTransition = true
    }

    func completeTransition(_ didComplete: Bool) {
        self.completedTransitions.append(didComplete)
    }

    func viewController(forKey key: UITransitionContextViewControllerKey) -> UIViewController? {
        switch key {
        case .from: return self.fromViewController
        case .to:   return self.toViewController
        default:    return nil
        }
    }

    func view(forKey key: UITransitionContextViewKey) -> UIView? {
        switch key {
        case .from: return self.fromViewController.view
        case .to:   return self.toViewController.view
        default:    return nil
        }
    }

    var targetTransform: CGAffineTransform {
        return .identity
    }

    func initialFrame(for viewController: UIViewController) -> CGRect {
        return viewController === self.fromViewController ? self.containerView.bounds : .zero
    }

    func finalFrame(for viewController: UIViewController) -> CGRect {
        return viewController === self.toViewController ? self.containerView.bounds : .zero
    }
}

private final class CoreTestNavigationRootDelegate: NSObject, FluidNavigationRootNavigationControllerDelegate {
    func navigationPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func navigationPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func navigationDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, navigationStyle: FluidNavigationStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}

private final class CoreTestNavigationSourceDelegate: NSObject, FluidNavigationSourceViewControllerDelegate {
    var navigationStyle: FluidNavigationStyle

    init(navigationStyle: FluidNavigationStyle = .slide(direction: .fromRight)) {
        self.navigationStyle = navigationStyle
    }

    func navigationPresentationStyle(from source: FluidSourceViewController,
                                     to destination: FluidDestinationViewController,
                                     with navigation: FluidNavigationController?) -> FluidNavigationStyle {
        return self.navigationStyle
    }

    func navigationBackgroundStyle(from source: FluidSourceViewController,
                                   to destination: FluidDestinationViewController,
                                   with navigation: FluidNavigationController?) -> FluidBackgroundStyle {
        return .dim(color: UIColor.black.withAlphaComponent(0.4))
    }
}

private final class CoreTestNavigationDestinationDelegate: NSObject, FluidNavigationDestinationViewControllerDelegate {}

private struct CoreTestNavigationFixture {
    let container: UIView
    let navigationController: CoreTestFluidNavigationController
    let sourceViewController: CoreTestFluidViewController
    let destinationViewController: CoreTestFluidViewController
    let rootDelegate: CoreTestNavigationRootDelegate
    let sourceDelegate: CoreTestNavigationSourceDelegate
    let destinationDelegate: CoreTestNavigationDestinationDelegate
    let presentAnimator: FluidNavigationViewAnimator
    let dismissAnimator: FluidNavigationViewAnimator
    let presentDriver: FluidNavigationPresentDriver
    let dismissDriver: FluidNavigationDismissDriver
}

private func makeCoreTestNavigationFixture(style: FluidNavigationStyle = .slide(direction: .fromRight)) -> CoreTestNavigationFixture {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let sourceViewController = CoreTestFluidViewController()
    let destinationViewController = CoreTestFluidViewController()
    let navigationController = CoreTestFluidNavigationController(rootViewController: sourceViewController)
    let rootDelegate = CoreTestNavigationRootDelegate()
    let sourceDelegate = CoreTestNavigationSourceDelegate(navigationStyle: style)
    let destinationDelegate = CoreTestNavigationDestinationDelegate()
    let presentAnimator = FluidNavigationViewAnimator()
    let dismissAnimator = FluidNavigationViewAnimator()
    let presentDriver = FluidNavigationPresentDriver(presentAnimator)
    let dismissDriver = FluidNavigationDismissDriver(dismissAnimator)

    navigationController.view.frame = container.bounds
    sourceViewController.view.frame = container.bounds
    destinationViewController.view.frame = container.bounds
    navigationController.fluidDelegate = rootDelegate
    sourceViewController.fluidDelegate = sourceDelegate
    destinationViewController.fluidDelegate = destinationDelegate
    container.addSubview(navigationController.view)
    container.addSubview(destinationViewController.view)

    try! presentDriver.configureParameters(driverType: .present,
                                           animationType: .present,
                                           context: nil,
                                           container: container,
                                           source: sourceViewController,
                                           destination: destinationViewController,
                                           initialContainerSize: container.bounds.size,
                                           finalContainerSize: container.bounds.size,
                                           shouldInsertSubview: true)
    try! dismissDriver.configureParameters(driverType: .dismiss,
                                           animationType: .dismiss,
                                           context: nil,
                                           container: container,
                                           source: sourceViewController,
                                           destination: destinationViewController,
                                           initialContainerSize: container.bounds.size,
                                           finalContainerSize: container.bounds.size,
                                           shouldInsertSubview: true)

    return CoreTestNavigationFixture(container: container,
                                     navigationController: navigationController,
                                     sourceViewController: sourceViewController,
                                     destinationViewController: destinationViewController,
                                     rootDelegate: rootDelegate,
                                     sourceDelegate: sourceDelegate,
                                     destinationDelegate: destinationDelegate,
                                     presentAnimator: presentAnimator,
                                     dismissAnimator: dismissAnimator,
                                     presentDriver: presentDriver,
                                     dismissDriver: dismissDriver)
}

private final class CoreTestTransitionRootDelegate: NSObject, FluidTransitionRootNavigationControllerDelegate {
    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController, to destination: FluidDestinationViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat) {}
    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController, to source: FluidSourceViewController, with navigation: FluidNavigationController?, on container: UIView?, transitionStyle: FluidTransitionStyle, duration: TimeInterval, easing: FluidAnimatorEasing, state: FluidProgressState, progress: CGFloat, info: FluidGestureInfo) {}
}

private final class CoreTestTransitionSourceDelegate: NSObject, FluidTransitionSourceViewControllerDelegate {
    var transitionStyle: FluidTransitionStyle
    var allowInteractivePresent: Bool
    var finalDimension: FluidFinalFrameDimension?
    var easing: FluidAnimatorEasing?
    var presentAnimationStates: [FluidProgressState] = []
    var dismissAnimationStates: [FluidProgressState] = []
    var presentInteractionStates: [FluidProgressState] = []
    var dismissInteractionStates: [FluidProgressState] = []

    init(transitionStyle: FluidTransitionStyle = .slide(direction: .fromRight),
         allowInteractivePresent: Bool = true,
         finalDimension: FluidFinalFrameDimension? = nil,
         easing: FluidAnimatorEasing? = nil) {
        self.transitionStyle = transitionStyle
        self.allowInteractivePresent = allowInteractivePresent
        self.finalDimension = finalDimension
        self.easing = easing
    }

    func transitionAllowsInteractivePresent(from source: FluidSourceViewController,
                                            to destination: FluidDestinationViewController,
                                            with navigation: FluidNavigationController?) -> Bool {
        return self.allowInteractivePresent
    }

    func transitionPresentationStyle(from source: FluidSourceViewController,
                                     to destination: FluidDestinationViewController,
                                     with navigation: FluidNavigationController?) -> FluidTransitionStyle {
        return self.transitionStyle
    }

    func transitionFinalDestinationFrameDimension(from source: FluidSourceViewController,
                                                  to destination: FluidDestinationViewController,
                                                  with navigation: FluidNavigationController?) -> FluidFinalFrameDimension? {
        return self.finalDimension
    }

    func transitionPresentEasing(from source: FluidSourceViewController,
                                 to destination: FluidDestinationViewController,
                                 with navigation: FluidNavigationController?) -> FluidAnimatorEasing? {
        return self.easing
    }

    func transitionDismissEasing(from destination: FluidDestinationViewController,
                                 to source: FluidSourceViewController,
                                 with navigation: FluidNavigationController?) -> FluidAnimatorEasing? {
        return self.easing
    }

    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController,
                                               to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?,
                                               on container: UIView?,
                                               transitionStyle: FluidTransitionStyle,
                                               duration: TimeInterval,
                                               easing: FluidAnimatorEasing,
                                               state: FluidProgressState,
                                               progress: CGFloat) {
        self.presentAnimationStates.append(state)
    }

    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController,
                                               to source: FluidSourceViewController,
                                               with navigation: FluidNavigationController?,
                                               on container: UIView?,
                                               transitionStyle: FluidTransitionStyle,
                                               duration: TimeInterval,
                                               easing: FluidAnimatorEasing,
                                               state: FluidProgressState,
                                               progress: CGFloat) {
        self.dismissAnimationStates.append(state)
    }

    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController,
                                                 to destination: FluidDestinationViewController,
                                                 with navigation: FluidNavigationController?,
                                                 on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle,
                                                 duration: TimeInterval,
                                                 easing: FluidAnimatorEasing,
                                                 state: FluidProgressState,
                                                 progress: CGFloat,
                                                 info: FluidGestureInfo) {
        self.presentInteractionStates.append(state)
    }

    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController,
                                                 to source: FluidSourceViewController,
                                                 with navigation: FluidNavigationController?,
                                                 on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle,
                                                 duration: TimeInterval,
                                                 easing: FluidAnimatorEasing,
                                                 state: FluidProgressState,
                                                 progress: CGFloat,
                                                 info: FluidGestureInfo) {
        self.dismissInteractionStates.append(state)
    }
}

private final class CoreTestTransitionDestinationDelegate: NSObject, FluidTransitionDestinationViewControllerDelegate {
    var allowInteractiveDismiss: Bool
    var observedScrollViews: [UIScrollView]?
    var presentAnimationStates: [FluidProgressState] = []
    var dismissAnimationStates: [FluidProgressState] = []
    var presentInteractionStates: [FluidProgressState] = []
    var dismissInteractionStates: [FluidProgressState] = []

    init(allowInteractiveDismiss: Bool = true, observedScrollViews: [UIScrollView]? = nil) {
        self.allowInteractiveDismiss = allowInteractiveDismiss
        self.observedScrollViews = observedScrollViews
    }

    func transitionAllowsInteractiveDismiss(from destination: FluidDestinationViewController,
                                            to source: FluidSourceViewController,
                                            with navigation: FluidNavigationController?) -> Bool {
        return self.allowInteractiveDismiss
    }

    func transitionObservesScrollViews(from destination: FluidDestinationViewController,
                                       to source: FluidSourceViewController,
                                       with navigation: FluidNavigationController?) -> [UIScrollView]? {
        return self.observedScrollViews
    }

    func transitionPresentAnimationDidProgress(from source: FluidSourceViewController,
                                               to destination: FluidDestinationViewController,
                                               with navigation: FluidNavigationController?,
                                               on container: UIView?,
                                               transitionStyle: FluidTransitionStyle,
                                               duration: TimeInterval,
                                               easing: FluidAnimatorEasing,
                                               state: FluidProgressState,
                                               progress: CGFloat) {
        self.presentAnimationStates.append(state)
    }

    func transitionDismissAnimationDidProgress(from destination: FluidDestinationViewController,
                                               to source: FluidSourceViewController,
                                               with navigation: FluidNavigationController?,
                                               on container: UIView?,
                                               transitionStyle: FluidTransitionStyle,
                                               duration: TimeInterval,
                                               easing: FluidAnimatorEasing,
                                               state: FluidProgressState,
                                               progress: CGFloat) {
        self.dismissAnimationStates.append(state)
    }

    func transitionPresentInteractionDidProgress(from source: FluidSourceViewController,
                                                 to destination: FluidDestinationViewController,
                                                 with navigation: FluidNavigationController?,
                                                 on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle,
                                                 duration: TimeInterval,
                                                 easing: FluidAnimatorEasing,
                                                 state: FluidProgressState,
                                                 progress: CGFloat,
                                                 info: FluidGestureInfo) {
        self.presentInteractionStates.append(state)
    }

    func transitionDismissInteractionDidProgress(from destination: FluidDestinationViewController,
                                                 to source: FluidSourceViewController,
                                                 with navigation: FluidNavigationController?,
                                                 on container: UIView?,
                                                 transitionStyle: FluidTransitionStyle,
                                                 duration: TimeInterval,
                                                 easing: FluidAnimatorEasing,
                                                 state: FluidProgressState,
                                                 progress: CGFloat,
                                                 info: FluidGestureInfo) {
        self.dismissInteractionStates.append(state)
    }
}

private final class CoreTestResizableDelegate: NSObject, FluidResizableTransitionDelegate {
    var resizeStates: [FluidProgressState] = []
    var resizePositions: [CGFloat] = []

    func transitionShouldPerformResizing() -> Bool {
        return true
    }

    func transitionMinimumMarginForResizing() -> CGFloat {
        return 64
    }

    func transitionSnapPositionsForResizing() -> [CGFloat]? {
        return [0, 0.5, 1]
    }

    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {
        self.resizeStates.append(state)
        self.resizePositions.append(position)
    }
}

private struct CoreTestTransitionFixture {
    let container: UIView
    let sourceViewController: CoreTestFluidViewController
    let destinationViewController: CoreTestFluidViewController
    let sourceDelegate: CoreTestTransitionSourceDelegate
    let destinationDelegate: CoreTestTransitionDestinationDelegate
    let presentAnimator: FluidTransitionViewAnimator
    let dismissAnimator: FluidTransitionViewAnimator
    let presentDriver: FluidTransitionPresentDriver
    let dismissDriver: FluidTransitionDismissDriver
}

private func makeCoreTestTransitionFixture(style: FluidTransitionStyle = .slide(direction: .fromRight),
                                           allowInteractivePresent: Bool = true,
                                           allowInteractiveDismiss: Bool = true,
                                           observedScrollViews: [UIScrollView]? = nil,
                                           resizableDelegate: FluidResizableTransitionDelegate? = nil,
                                           finalDimension: FluidFinalFrameDimension? = nil,
                                           easing: FluidAnimatorEasing? = nil) -> CoreTestTransitionFixture {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let sourceViewController = CoreTestFluidViewController()
    let destinationViewController = CoreTestFluidViewController()
    let sourceDelegate = CoreTestTransitionSourceDelegate(transitionStyle: style,
                                                          allowInteractivePresent: allowInteractivePresent,
                                                          finalDimension: finalDimension,
                                                          easing: easing)
    let destinationDelegate = CoreTestTransitionDestinationDelegate(allowInteractiveDismiss: allowInteractiveDismiss,
                                                                    observedScrollViews: observedScrollViews)
    let presentAnimator = FluidTransitionViewAnimator()
    let dismissAnimator = FluidTransitionViewAnimator()
    let presentDriver = FluidTransitionPresentDriver(presentAnimator)
    let dismissDriver = FluidTransitionDismissDriver(dismissAnimator)

    sourceViewController.view.frame = container.bounds
    destinationViewController.view.frame = container.bounds
    sourceViewController.fluidDelegate = sourceDelegate
    destinationViewController.fluidDelegate = destinationDelegate
    destinationViewController.fluidResizableDelegate = resizableDelegate
    container.addSubview(sourceViewController.view)

    try! presentDriver.configureParameters(driverType: .present,
                                           animationType: .present,
                                           context: nil,
                                           container: container,
                                           source: sourceViewController,
                                           destination: destinationViewController,
                                           initialContainerSize: container.bounds.size,
                                           finalContainerSize: container.bounds.size,
                                           easing: easing,
                                           shouldInsertSubview: true)
    try! dismissDriver.configureParameters(driverType: .dismiss,
                                           animationType: .dismiss,
                                           context: nil,
                                           container: container,
                                           source: sourceViewController,
                                           destination: destinationViewController,
                                           initialContainerSize: container.bounds.size,
                                           finalContainerSize: container.bounds.size,
                                           easing: easing,
                                           shouldInsertSubview: true)

    return CoreTestTransitionFixture(container: container,
                                     sourceViewController: sourceViewController,
                                     destinationViewController: destinationViewController,
                                     sourceDelegate: sourceDelegate,
                                     destinationDelegate: destinationDelegate,
                                     presentAnimator: presentAnimator,
                                     dismissAnimator: dismissAnimator,
                                     presentDriver: presentDriver,
                                     dismissDriver: dismissDriver)
}

private func seedGesture(_ observer: FluidTransitionGestureObserver,
                         averageVector: CGPoint,
                         velocity: CGVector = .zero,
                         initialLocation: CGPoint = .zero,
                         currentLocation: CGPoint = .zero) {
    observer.initialLocation = initialLocation
    observer.currentLocation = currentLocation
    observer.currentVelocity = velocity
    observer.translationHistory = [averageVector, .zero]
}
