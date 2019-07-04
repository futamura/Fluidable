//
//  UIKitSpec.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class UIKitSpec: QuickSpec {
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

    override func spec() {
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
