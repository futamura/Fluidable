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
        }
    }
}