//
//  VectorMathSpec.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/03.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Quick
import Nimble
import UIKit
@testable import Fluidable

final class VectorMathSpec: QuickSpec {
    override class func spec() {
        describe("VectorMath") {
            describe("Scalar") {
                it("compares nearby values") {
                    let scalar0: Scalar = 0.00000
                    let scalar1: Scalar = 0.00001
                    let scalar2: Scalar = 0.00100

                    expect(scalar0 ~= scalar1).to(beTrue())
                    expect(scalar0 ~= scalar2).to(beFalse())
                    expect(Scalar.degreesPerRadian * Scalar.radiansPerDegree).to(beCloseTo(1, within: 0.001))
                }
            }

            describe("Vector2") {
                it("calculates geometry and applies matrix transforms") {
                    let vector = Vector2(3, 4)
                    let other = Vector2([1, 2])
                    let translation = Matrix3(translation: Vector2(2, 3))
                    let scale = Matrix3(scale: Vector2(2, 3))

                    expect(Set([Vector2.x, Vector2.y]).contains(Vector2.x)).to(beTrue())
                    expect(Vector2.zero.toArray()).to(equal([0, 0]))
                    expect(vector.lengthSquared).to(equal(25))
                    expect(vector.length).to(equal(5))
                    expect(vector.inverse).to(equal(Vector2(-3, -4)))
                    expect(other.toArray()).to(equal([1, 2]))
                    expect(vector.dot(other)).to(equal(11))
                    expect(vector.cross(other)).to(equal(2))
                    expect(Vector2.zero.normalized()).to(equal(Vector2.zero))
                    expect(Vector2.x.normalized()).to(equal(Vector2.x))
                    expect(Vector2(3, 4).normalized() ~= Vector2(0.6, 0.8)).to(beTrue())
                    expect(Vector2.x.rotated(by: .halfPi) ~= Vector2(0, 1)).to(beTrue())
                    expect(Vector2(2, 1).rotated(by: .halfPi, around: Vector2(1, 1)) ~= Vector2(1, 2)).to(beTrue())
                    expect(Vector2.x.angle(with: Vector2.x)).to(equal(0))
                    expect(Vector2.x.angle(with: Vector2.y)).to(beCloseTo(.halfPi, within: 0.001))
                    expect(Vector2.zero.interpolated(with: Vector2(10, 20), by: 0.25)).to(equal(Vector2(2.5, 5)))
                    expect(-other).to(equal(Vector2(-1, -2)))
                    expect(vector + other).to(equal(Vector2(4, 6)))
                    expect(vector - other).to(equal(Vector2(2, 2)))
                    expect(vector * other).to(equal(Vector2(3, 8)))
                    expect(other * 2).to(equal(Vector2(2, 4)))
                    expect(vector / Vector2(3, 2)).to(equal(Vector2(1, 2)))
                    expect(vector / 2).to(equal(Vector2(1.5, 2)))
                    expect(Vector2(1, 1) * translation).to(equal(Vector2(3, 4)))
                    expect(scale * Vector2(2, 3)).to(equal(Vector2(4, 9)))
                    expect(Vector2(2, 3) ~= Vector2(2.00001, 2.99999)).to(beTrue())
                }
            }

            describe("Vector3") {
                it("calculates vector products and component views") {
                    var vector = Vector3(1, 2, 3)
                    let other = Vector3([4, 5, 6])
                    let matrix3 = Matrix3(scale: Vector2(2, 3))
                    let matrix4 = Matrix4(translation: Vector3(10, 20, 30))
                    let quaternion = Quaternion(axisAngle: Vector4(0, 0, 1, .halfPi))

                    expect(Set([Vector3.x, Vector3.y, Vector3.z]).contains(Vector3.z)).to(beTrue())
                    expect(Vector3.zero.toArray()).to(equal([0, 0, 0]))
                    expect(vector.lengthSquared).to(equal(14))
                    expect(vector.length).to(beCloseTo(sqrt(14), within: 0.001))
                    expect(vector.inverse).to(equal(Vector3(-1, -2, -3)))
                    expect(vector.xy).to(equal(Vector2(1, 2)))
                    expect(vector.xz).to(equal(Vector2(1, 3)))
                    expect(vector.yz).to(equal(Vector2(2, 3)))

                    vector.xy = Vector2(7, 8)
                    vector.xz = Vector2(9, 10)
                    vector.yz = Vector2(11, 12)

                    expect(vector).to(equal(Vector3(9, 11, 12)))
                    expect(other.toArray()).to(equal([4, 5, 6]))
                    expect(vector.dot(other)).to(equal(163))
                    expect(Vector3.x.cross(Vector3.y)).to(equal(Vector3.z))
                    expect(Vector3.zero.normalized()).to(equal(Vector3.zero))
                    expect(Vector3.x.normalized()).to(equal(Vector3.x))
                    expect(Vector3(2, 0, 0).normalized()).to(equal(Vector3.x))
                    expect(Vector3.zero.interpolated(with: Vector3(10, 20, 30), by: 0.5)).to(equal(Vector3(5, 10, 15)))
                    expect(-other).to(equal(Vector3(-4, -5, -6)))
                    expect(other + Vector3(1, 1, 1)).to(equal(Vector3(5, 6, 7)))
                    expect(other - Vector3(1, 2, 3)).to(equal(Vector3(3, 3, 3)))
                    expect(other * Vector3(2, 3, 4)).to(equal(Vector3(8, 15, 24)))
                    expect(other * 2).to(equal(Vector3(8, 10, 12)))
                    expect(Vector3(1, 1, 1) * matrix3).to(equal(Vector3(2, 3, 1)))
                    expect(Vector3(1, 1, 1) * matrix4).to(equal(Vector3(11, 21, 31)))
                    expect((Vector3.x * quaternion) ~= Vector3(0, 1, 0)).to(beTrue())
                    expect(other / Vector3(2, 5, 3)).to(equal(Vector3(2, 1, 2)))
                    expect(other / 2).to(equal(Vector3(2, 2.5, 3)))
                    expect(Vector3(1, 2, 3) ~= Vector3(1.00001, 2.00001, 2.99999)).to(beTrue())
                }
            }

            describe("Vector4") {
                it("calculates homogeneous vectors and transforms") {
                    var vector = Vector4(1, 2, 3, 2)
                    let other = Vector4([4, 5, 6, 7])
                    let matrix = Matrix4(translation: Vector3(10, 20, 30))

                    expect(Set([Vector4.x, Vector4.y, Vector4.z, Vector4.w]).contains(Vector4.w)).to(beTrue())
                    expect(Vector4.zero.toArray()).to(equal([0, 0, 0, 0]))
                    expect(vector.lengthSquared).to(equal(18))
                    expect(vector.length).to(beCloseTo(sqrt(18), within: 0.001))
                    expect(vector.inverse).to(equal(Vector4(-1, -2, -3, -2)))
                    expect(vector.xyz).to(equal(Vector3(1, 2, 3)))
                    expect(vector.xy).to(equal(Vector2(1, 2)))
                    expect(vector.xz).to(equal(Vector2(1, 3)))
                    expect(vector.yz).to(equal(Vector2(2, 3)))

                    vector.xyz = Vector3(7, 8, 9)
                    vector.xy = Vector2(10, 11)
                    vector.xz = Vector2(12, 13)
                    vector.yz = Vector2(14, 15)

                    expect(vector).to(equal(Vector4(12, 14, 15, 2)))
                    expect(Vector4(Vector3(1, 2, 3), w: 4).toArray()).to(equal([1, 2, 3, 4]))
                    expect(Vector4(2, 4, 6, 2).toVector3()).to(equal(Vector3(1, 2, 3)))
                    expect(Vector4(2, 4, 6, 0).toVector3()).to(equal(Vector3(2, 4, 6)))
                    expect(other.dot(Vector4(1, 1, 1, 1))).to(equal(22))
                    expect(Vector4.zero.normalized()).to(equal(Vector4.zero))
                    expect(Vector4.x.normalized()).to(equal(Vector4.x))
                    expect(Vector4(2, 0, 0, 0).normalized()).to(equal(Vector4.x))
                    expect(Vector4.zero.interpolated(with: Vector4(10, 20, 30, 40), by: 0.5)).to(equal(Vector4(5, 10, 15, 20)))
                    expect(-other).to(equal(Vector4(-4, -5, -6, -7)))
                    expect(other + Vector4(1, 1, 1, 1)).to(equal(Vector4(5, 6, 7, 8)))
                    expect(other - Vector4(1, 2, 3, 4)).to(equal(Vector4(3, 3, 3, 3)))
                    expect(other * Vector4(2, 3, 4, 5)).to(equal(Vector4(8, 15, 24, 35)))
                    expect(other * 2).to(equal(Vector4(8, 10, 12, 14)))
                    expect(Vector4(1, 2, 3, 1) * matrix).to(equal(Vector4(11, 22, 33, 1)))
                    expect(other / Vector4(2, 5, 3, 7)).to(equal(Vector4(2, 1, 2, 1)))
                    expect(other / 2).to(equal(Vector4(2, 2.5, 3, 3.5)))
                    expect(Vector4(1, 2, 3, 4) ~= Vector4(1.00001, 2.00001, 2.99999, 4.00001)).to(beTrue())
                }
            }

            describe("Matrix3") {
                it("builds, interpolates, and inverts affine matrices") {
                    let matrix = Matrix3([1, 2, 3, 0, 1, 4, 5, 6, 0])
                    let scale = Matrix3(scale: Vector2(2, 3))
                    let translation = Matrix3(translation: Vector2(4, 5))
                    let rotation = Matrix3(rotation: .halfPi)

                    expect(Set([Matrix3.identity]).contains(Matrix3.identity)).to(beTrue())
                    expect(matrix.toArray()).to(equal([1, 2, 3, 0, 1, 4, 5, 6, 0]))
                    expect(scale.toArray()).to(equal([2, 0, 0, 0, 3, 0, 0, 0, 1]))
                    expect(translation.toArray()).to(equal([1, 0, 0, 0, 1, 0, 4, 5, 1]))
                    expect((Vector2.x * rotation) ~= Vector2(0, 1)).to(beTrue())
                    expect(matrix.adjugate.toArray()).notTo(beEmpty())
                    expect(matrix.determinant).to(equal(1))
                    expect(matrix.transpose.transpose).to(equal(matrix))
                    expect((matrix * matrix.inverse) ~= Matrix3.identity).to(beTrue())
                    expect(matrix.interpolated(with: Matrix3.identity, by: 0).toArray()).to(equal(matrix.toArray()))
                    expect(-matrix ~= matrix.inverse).to(beTrue())
                    expect((translation * scale).toArray()).notTo(beEmpty())
                    expect(Matrix3.identity * Vector3(1, 2, 3)).to(equal(Vector3(1, 2, 3)))
                    expect((matrix * 2).toArray()).to(equal([2, 4, 6, 0, 2, 8, 10, 12, 0]))
                    expect(matrix == Matrix3.identity).to(beFalse())
                    expect(matrix ~= Matrix3([1.00001, 2, 3, 0, 1, 4, 5, 6, 0])).to(beTrue())
                }
            }

            describe("Matrix4") {
                it("builds projection and transform matrices") {
                    let matrix = Matrix4([1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 4, 5, 6, 1])
                    let scale = Matrix4(scale: Vector3(2, 3, 4))
                    let translation = Matrix4(translation: Vector3(10, 20, 30))
                    let rotation = Matrix4(rotation: Vector4(0, 0, 1, .halfPi))
                    let quaternion = Matrix4(quaternion: Quaternion(axisAngle: Vector4(0, 0, 1, .halfPi)))
                    let perspectiveXy = Matrix4(fovx: 1, fovy: 1, near: 1, far: 10)
                    let perspectiveAspectX = Matrix4(fovx: 1, aspect: 1, near: 1, far: 10)
                    let perspectiveAspectY = Matrix4(fovy: 1, aspect: 1, near: 1, far: 10)
                    let orthographic = Matrix4(top: 1, right: 1, bottom: -1, left: -1, near: 1, far: 10)

                    expect(Set([Matrix4.identity]).contains(Matrix4.identity)).to(beTrue())
                    expect(matrix.toArray()).to(equal([1, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 4, 5, 6, 1]))
                    expect(scale.toArray()).to(equal([2, 0, 0, 0, 0, 3, 0, 0, 0, 0, 4, 0, 0, 0, 0, 1]))
                    expect(translation.toArray()).to(equal([1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 10, 20, 30, 1]))
                    expect((Vector3.x * rotation) ~= Vector3(0, 1, 0)).to(beTrue())
                    expect((Vector3.x * quaternion) ~= Vector3(0, 1, 0)).to(beTrue())
                    expect(perspectiveXy.toArray()).notTo(beEmpty())
                    expect(perspectiveAspectX.toArray()).to(equal(perspectiveAspectY.toArray()))
                    expect(orthographic.toArray()).notTo(beEmpty())
                    expect(matrix.adjugate.toArray()).notTo(beEmpty())
                    expect(matrix.determinant).to(equal(6))
                    expect(matrix.transpose.transpose).to(equal(matrix))
                    expect((matrix * matrix.inverse) ~= Matrix4.identity).to(beTrue())
                    expect(-matrix ~= matrix.inverse).to(beTrue())
                    expect((translation * scale).toArray()).notTo(beEmpty())
                    expect(Matrix4.identity * Vector3(1, 2, 3)).to(equal(Vector3(1, 2, 3)))
                    expect(Matrix4.identity * Vector4(1, 2, 3, 4)).to(equal(Vector4(1, 2, 3, 4)))
                    expect((matrix * 2).toArray()).to(equal([2, 0, 0, 0, 0, 4, 0, 0, 0, 0, 6, 0, 8, 10, 12, 2]))
                    expect(matrix == Matrix4.identity).to(beFalse())
                    expect(matrix ~= Matrix4([1.00001, 0, 0, 0, 0, 2, 0, 0, 0, 0, 3, 0, 4, 5, 6, 1])).to(beTrue())
                }
            }

            describe("Quaternion") {
                it("converts between rotations and interpolates") {
                    var quaternion = Quaternion(1, 2, 3, 4)
                    let axisAngle = Vector4(0, 0, 1, .halfPi)
                    let rotation = Quaternion(axisAngle: axisAngle)
                    let euler = Quaternion(pitch: 0.2, yaw: 0.3, roll: 0.4)
                    let fromMatrix = Quaternion(rotationMatrix: Matrix4(rotation: axisAngle))
                    let fromArray = Quaternion([1, 2, 3, 4])

                    expect(Set([Quaternion.identity, Quaternion.zero]).contains(Quaternion.identity)).to(beTrue())
                    expect(quaternion.lengthSquared).to(equal(30))
                    expect(quaternion.length).to(beCloseTo(sqrt(30), within: 0.001))
                    expect(quaternion.inverse).to(equal(Quaternion(-1, -2, -3, 4)))
                    expect(quaternion.xyz).to(equal(Vector3(1, 2, 3)))

                    quaternion.xyz = Vector3(5, 6, 7)

                    expect(quaternion).to(equal(Quaternion(5, 6, 7, 4)))
                    expect(euler.pitch).to(beCloseTo(0.2, within: 0.001))
                    expect(euler.yaw).to(beCloseTo(0.3, within: 0.001))
                    expect(euler.roll).to(beCloseTo(0.4, within: 0.001))
                    expect(fromMatrix.toArray()).notTo(beEmpty())
                    expect(fromArray.toArray()).to(equal([1, 2, 3, 4]))
                    expect(rotation.toAxisAngle() ~= axisAngle).to(beTrue())
                    expect(Quaternion.identity.toAxisAngle()).to(equal(Vector4.z))
                    expect(euler.toPitchYawRoll().pitch).to(beCloseTo(0.2, within: 0.001))
                    expect(Quaternion.identity.dot(Quaternion.identity)).to(equal(1))
                    expect(Quaternion.zero.normalized()).to(equal(Quaternion.zero))
                    expect(Quaternion.identity.normalized()).to(equal(Quaternion.identity))
                    expect(Quaternion(2, 0, 0, 0).normalized()).to(equal(Quaternion(1, 0, 0, 0)))
                    expect(Quaternion.identity.interpolated(with: Quaternion.identity, by: 0.5)).to(equal(Quaternion.identity))
                    expect(Quaternion.identity.interpolated(with: rotation, by: 0.5).length).to(beCloseTo(1, within: 0.001))
                    expect(-rotation ~= Quaternion(0, 0, -rotation.z, rotation.w)).to(beTrue())
                    expect(rotation + Quaternion.identity).to(equal(Quaternion(rotation.x, rotation.y, rotation.z, rotation.w + 1)))
                    expect(rotation - Quaternion.identity).to(equal(Quaternion(rotation.x, rotation.y, rotation.z, rotation.w - 1)))
                    expect((rotation * Quaternion.identity) ~= rotation).to(beTrue())
                    expect((rotation * Vector3.x) ~= Vector3(0, 1, 0)).to(beTrue())
                    expect((rotation * 2).toArray()).to(equal([rotation.x * 2, rotation.y * 2, rotation.z * 2, rotation.w * 2]))
                    expect((rotation / 2).toArray()).to(equal([rotation.x / 2, rotation.y / 2, rotation.z / 2, rotation.w / 2]))
                    expect(rotation ~= Quaternion(rotation.x, rotation.y, rotation.z, rotation.w + 0.00001)).to(beTrue())
                }
            }
        }
    }
}
