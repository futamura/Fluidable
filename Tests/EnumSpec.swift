//
//  EnumSpec.swift
//  FluidableTests
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class EnumSpec: QuickSpec {

    override func spec() {
        describe("Spec Enumeration") {
            describe("Spec FluidAnimationType") {
                let present: FluidAnimationType = FluidAnimationType.present
                let dismiss: FluidAnimationType = FluidAnimationType.dismiss
                let rotate: FluidAnimationType = FluidAnimationType.rotate
                it("Equatable") {
                    expect(present).to(equal(FluidAnimationType.present))
                    expect(present).notTo(equal(FluidAnimationType.dismiss))
                    expect(present).notTo(equal(FluidAnimationType.rotate))
                    expect(dismiss).notTo(equal(FluidAnimationType.present))
                    expect(dismiss).to(equal(FluidAnimationType.dismiss))
                    expect(dismiss).notTo(equal(FluidAnimationType.rotate))
                    expect(rotate).notTo(equal(FluidAnimationType.present))
                    expect(rotate).notTo(equal(FluidAnimationType.dismiss))
                    expect(rotate).to(equal(FluidAnimationType.rotate))
                }
                it("Condition") {
                    expect(present.isPresent).to(equal(true))
                    expect(present.isDismiss).to(equal(false))
                    expect(present.isRotate).to(equal(false))
                    expect(dismiss.isPresent).to(equal(false))
                    expect(dismiss.isDismiss).to(equal(true))
                    expect(dismiss.isRotate).to(equal(false))
                    expect(rotate.isPresent).to(equal(false))
                    expect(rotate.isDismiss).to(equal(false))
                    expect(rotate.isRotate).to(equal(true))
                }
                it("Description") {
                    expect(String(describing: present)).to(match("present"))
                    expect(String(describing: dismiss)).to(match("dismiss"))
                    expect(String(describing: rotate)).to(match("rotate"))
                }
            }
            describe("Spec FluidBackgroundStyle") {
                let blurStyleLeft: FluidBackgroundStyle = .blur(radius: 8.0, color: .clear, alpha: 1.0)
                let dimStyleLeft: FluidBackgroundStyle = .dim(color: UIColor.black.withAlphaComponent(0.8))
                let noneStyleLeft: FluidBackgroundStyle = .none
                it("Equatable") {
                    let blurStyleRight: FluidBackgroundStyle = .blur(radius: 8.0, color: .clear, alpha: 1.0)
                    let dimStyleRight: FluidBackgroundStyle = .dim(color: UIColor.black.withAlphaComponent(0.8))
                    let noneStyleRight: FluidBackgroundStyle = .none
                    expect(blurStyleLeft).to(equal(blurStyleRight))
                    expect(dimStyleLeft).to(equal(dimStyleRight))
                    expect(noneStyleLeft).to(equal(noneStyleRight))
                }
                it("Description") {
                    expect(String(describing: blurStyleLeft)).to(beginWith("blur"))
                    expect(String(describing: dimStyleLeft)).to(beginWith("dim"))
                    expect(String(describing: noneStyleLeft)).to(beginWith("none"))
                }
            }
            describe("Spec FluidDriverInteractionType") {
                let normalDefault: FluidDriverInteractionType = .normal
                let fluidDefault: FluidDriverInteractionType = .fluid
                let normalCustom: FluidDriverInteractionType = .init(for: .slide(direction: .fromRight), with: .present)
                let fluidCustom: FluidDriverInteractionType = .init(for: .fluid(behavior: .all), with: .present)
                let none: FluidDriverInteractionType = .none
                it("Equatable") {
                    expect(normalDefault.isNormal).to(equal(true))
                    expect(normalDefault.isFluid).to(equal(false))
                    expect(normalDefault.isNone).to(equal(false))
                    expect(fluidDefault.isNormal).to(equal(false))
                    expect(fluidDefault.isFluid).to(equal(true))
                    expect(fluidDefault.isNone).to(equal(false))
                    expect(normalCustom.isNormal).to(equal(true))
                    expect(normalCustom.isFluid).to(equal(false))
                    expect(normalCustom.isNone).to(equal(false))
                    expect(fluidCustom.isNormal).to(equal(false))
                    expect(fluidCustom.isFluid).to(equal(true))
                    expect(fluidCustom.isNone).to(equal(false))
                    expect(none.isNormal).to(equal(false))
                    expect(none.isFluid).to(equal(false))
                    expect(none.isNone).to(equal(true))
                }
                it("UIRectEdge") {
                    expect(normalDefault.edges).to(equal(UIRectEdge(arrayLiteral: [])))
                    expect(fluidDefault.edges).to(equal(UIRectEdge(arrayLiteral: [])))
                    expect(normalCustom.edges).to(equal(UIRectEdge.left))
                    expect(fluidCustom.edges).to(equal(UIRectEdge.left))
                    expect(none.edges).to(equal(UIRectEdge(arrayLiteral: [])))
                }
                it("Description") {
                    expect(String(describing: normalDefault)).to(beginWith("normal"))
                    expect(String(describing: fluidDefault)).to(beginWith("fluid"))
                    expect(String(describing: normalCustom)).to(beginWith("normal"))
                    expect(String(describing: fluidCustom)).to(beginWith("fluid"))
                    expect(String(describing: none)).to(beginWith("notInteracting"))
                }
            }
        }
    }
}
