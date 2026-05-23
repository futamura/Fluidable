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

private final class CoreTestFluidViewController: UIViewController, Fluidable {}

private final class CoreTestFluidNavigationController: UINavigationController, Fluidable {}

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
    var presentInteractionStates: [FluidProgressState] = []

    init(transitionStyle: FluidTransitionStyle = .slide(direction: .fromRight),
         allowInteractivePresent: Bool = true) {
        self.transitionStyle = transitionStyle
        self.allowInteractivePresent = allowInteractivePresent
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
}

private final class CoreTestTransitionDestinationDelegate: NSObject, FluidTransitionDestinationViewControllerDelegate {
    var allowInteractiveDismiss: Bool
    var observedScrollViews: [UIScrollView]?
    var presentInteractionStates: [FluidProgressState] = []

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
                                           observedScrollViews: [UIScrollView]? = nil) -> CoreTestTransitionFixture {
    let container = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
    let sourceViewController = CoreTestFluidViewController()
    let destinationViewController = CoreTestFluidViewController()
    let sourceDelegate = CoreTestTransitionSourceDelegate(transitionStyle: style,
                                                          allowInteractivePresent: allowInteractivePresent)
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
    container.addSubview(sourceViewController.view)

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
