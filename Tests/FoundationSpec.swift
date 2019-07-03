//
//  FoundationSpec.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
@testable import Fluidable

class FoundationSpec: QuickSpec {
    override func spec() {
        describe("Foundation") {
            describe("String") {
                it("Description") {
                    var str: String? = nil
                    expect(String(debug: str)).to(match("nil"))
                    str = "str"
                    expect(String(debug: str)).to(beginWith("str"))
                }
            }
            describe("Array") {
                it("Subscript") {
                    let numbers: [CGFloat] = [1.0, 2.0, 3.0, 4.0]
                    expect(numbers[safe: 0]).to(equal(1.0))
                    expect(numbers[safe: 4]).to(beNil())
                }
                it("Distance") {
                    let numbers: [CGFloat] = [1.0, 2.0, 3.0, 4.0]
                    expect(numbers.nearest(to: 3.5)?.index).to(equal(2))
                    expect(numbers.nearest(to: 4.5)?.index).to(equal(3))
                    let points: [CGPoint] = [CGPoint(x: 0, y: 0), CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 3)]
                    expect(points.nearest(to: CGPoint(x: 1.5, y: 1.5))?.index).to(equal(1))
                    expect(points.nearest(to: CGPoint(x: 3.5, y: 3.5))?.index).to(equal(3))
                    let vectors: [CGVector] = [CGVector(dx: 0, dy: 0), CGVector(dx: 1, dy: 1), CGVector(dx: 2, dy: 2), CGVector(dx: 3, dy: 3)]
                    expect(vectors.nearest(to: CGVector(dx: 1.5, dy: 1.5))?.index).to(equal(1))
                    expect(vectors.nearest(to: CGVector(dx: 3.5, dy: 3.5))?.index).to(equal(3))
                }
                it("Calculation") {
                    expect([1.0, 2.0, 3.0, 4.0].sum).to(equal(10))
                    expect([-1.0, -2.0, -3.0, -4.0].sum).to(equal(-10))
                    expect([1.0, 2.0, 3.0, 4.0].average).to(equal(2.5))
                    expect([-1.0, -2.0, -3.0, -4.0].average).to(equal(-2.5))

                    expect([Int(1), Int(2), Int(3), Int(4)].sum).to(equal(10))
                    expect([Int(-1), Int(-2), Int(-3), Int(-4)].sum).to(equal(-10))
                    expect([Int(1), Int(2), Int(3), Int(4)].average).to(equal(2.5))
                    expect([Int(-1), Int(-2), Int(-3), Int(-4)].average).to(equal(-2.5))

                    expect([CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 4)].sum).to(equal(CGPoint(x: 10, y: 10)))
                    expect([CGPoint(x: -1, y: -1), CGPoint(x: -2, y: -2), CGPoint(x: -3, y: -3), CGPoint(x: -4, y: -4)].sum).to(equal(CGPoint(x: -10, y: -10)))
                    expect([CGPoint(x: 1, y: 1), CGPoint(x: 2, y: 2), CGPoint(x: 3, y: 3), CGPoint(x: 4, y: 4)].average).to(equal(CGPoint(x: 2.5, y: 2.5)))
                    expect([CGPoint(x: -1, y: -1), CGPoint(x: -2, y: -2), CGPoint(x: -3, y: -3), CGPoint(x: -4, y: -4)].average).to(equal(CGPoint(x: -2.5, y: -2.5)))

                }
            }
        }
    }
}
