//
//  FluidCoreAnimatorKeyPath.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The protocol that compatible to a keyPath property for `CAAnimation`.
 <h4>Available Properties</h4>
 `Array`, `Bool`, `CALayer`, `CATransform3D`, `CGColor`, `CGFloat`, `Float`, `CGPath`, `CGPoint`, `CGRect`, `CGSize`, `CIFilter`
 */
public protocol FluidCoreAnimatorKeyCompatible {}
extension Array: FluidCoreAnimatorKeyCompatible {}
extension Bool: FluidCoreAnimatorKeyCompatible {}
extension CALayer: FluidCoreAnimatorKeyCompatible {}
extension CATransform3D: FluidCoreAnimatorKeyCompatible {}
extension CGColor: FluidCoreAnimatorKeyCompatible {}
extension CGFloat: FluidCoreAnimatorKeyCompatible {}
extension Float: FluidCoreAnimatorKeyCompatible {}
extension CGPath: FluidCoreAnimatorKeyCompatible {}
extension CGPoint: FluidCoreAnimatorKeyCompatible {}
extension CGRect: FluidCoreAnimatorKeyCompatible {}
extension CGSize: FluidCoreAnimatorKeyCompatible {}
extension CIFilter: FluidCoreAnimatorKeyCompatible {}

/**
 The class that stores keyPath property for `CAAnimation` conforming to `FluidCoreAnimatorKey` protocol. Please read [the official docs](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html) for animatable properties.
 */
public final class FluidCoreAnimatorPath<ValueType: FluidCoreAnimatorKeyCompatible>: FluidCoreAnimatorKey {
    var rawValue: String
    init(keyPath: String) { self.rawValue = keyPath }
}

/**
 The class that declares `CALayer` keyPath information.

 <h4>Available Keys</h4>
 `anchorPoint`, `anchorPointX`, `anchorPointy`, `backgroundColor`, `borderColor`, `borderWidth`, `bounds`, `boundsOrigin`, `boundsOriginX`, `boundsOriginY`, `boundsSize`, `boundsSizeWidth`, `boundsSizeHeight`, `contents`, `contentsRect`, `contentsRectOrigin`, `contentsRectOriginX`, `contentsRectOriginY`, `contentsRectSize`, `contentsRectSizeWidth`, `contentsRectSizeHeight`, `cornerRadius`, `filters`, `frame`, `frameOrigin`, `frameOriginX`, `frameOriginY`, `frameSize`, `frameSizeWidth`, `frameSizeHeight`, `hidden`, `mask`, `masksToBounds`, `opacity`, `path`, `position`, `positionX`, `positionY`, `shadowColor`, `shadowOffset`, `shadowOffsetWidth`, `shadowOffsetHeight`, `shadowOpacity`, `shadowPath`, `shadowRadius`, `sublayers`, `sublayerTransform`, `sublayerTransformRotationX`, `sublayerTransformRotationY`, `sublayerTransformRotationZ`, `sublayerTransformScaleX`, `sublayerTransformScaleY`, `sublayerTransformScaleZ`, `sublayerTransformTranslationX`, `sublayerTransformTranslationY`, `sublayerTransformTranslationZ`, `transform`, `transformRotationX`, `transformRotationY`, `transformRotationZ`, `transformScaleX`, `transformScaleY`, `transformScaleZ`, `transformTranslationX`, `transformTranslationY`, `transformTranslationZ`, `zPosition`
 */
open class FluidCoreAnimatorKey {
    fileprivate init() {}
}

extension FluidCoreAnimatorKey {
    public static var anchorPoint: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: #keyPath(CALayer.anchorPoint)) }
    public static var backgroundColor: FluidCoreAnimatorPath<CGColor> { return FluidCoreAnimatorPath<CGColor>(keyPath: #keyPath(CALayer.backgroundColor)) }
    public static var borderColor: FluidCoreAnimatorPath<CGColor> { return FluidCoreAnimatorPath<CGColor>(keyPath: #keyPath(CALayer.borderColor)) }
    public static var borderWidth: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: #keyPath(CALayer.borderWidth)) }
    public static var bounds: FluidCoreAnimatorPath<CGRect> { return FluidCoreAnimatorPath<CGRect>(keyPath: #keyPath(CALayer.bounds)) }
    public static var contents: FluidCoreAnimatorPath<[Any]> { return FluidCoreAnimatorPath<[Any]>(keyPath: #keyPath(CALayer.contents)) }
    public static var contentsRect: FluidCoreAnimatorPath<CGRect> { return FluidCoreAnimatorPath<CGRect>(keyPath: #keyPath(CALayer.contentsRect)) }
    public static var cornerRadius: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: #keyPath(CALayer.cornerRadius)) }
    public static var filters: FluidCoreAnimatorPath<[CIFilter]> { return FluidCoreAnimatorPath<[CIFilter]>(keyPath: #keyPath(CALayer.filters)) }
    public static var frame: FluidCoreAnimatorPath<CGRect> { return FluidCoreAnimatorPath<CGRect>(keyPath: #keyPath(CALayer.frame)) }
    public static var hidden: FluidCoreAnimatorPath<Bool> { return FluidCoreAnimatorPath<Bool>(keyPath: #keyPath(CALayer.hidden)) }
    public static var mask: FluidCoreAnimatorPath<CALayer> { return FluidCoreAnimatorPath<CALayer>(keyPath: #keyPath(CALayer.mask)) }
    public static var masksToBounds: FluidCoreAnimatorPath<Bool> { return FluidCoreAnimatorPath<Bool>(keyPath: #keyPath(CALayer.masksToBounds)) }
    public static var opacity: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: #keyPath(CALayer.opacity)) }
    public static var path: FluidCoreAnimatorPath<CGPath> { return FluidCoreAnimatorPath<CGPath>(keyPath: #keyPath(CAShapeLayer.path)) }
    public static var position: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: #keyPath(CALayer.position)) }
    public static var shadowColor: FluidCoreAnimatorPath<CGColor> { return FluidCoreAnimatorPath<CGColor>(keyPath: #keyPath(CALayer.shadowColor)) }
    public static var shadowOffset: FluidCoreAnimatorPath<CGSize> { return FluidCoreAnimatorPath<CGSize>(keyPath: #keyPath(CALayer.shadowOffset)) }
    public static var shadowOpacity: FluidCoreAnimatorPath<Float> { return FluidCoreAnimatorPath<Float>(keyPath: #keyPath(CALayer.shadowOpacity)) }
    public static var shadowPath: FluidCoreAnimatorPath<CGPath> { return FluidCoreAnimatorPath<CGPath>(keyPath: #keyPath(CALayer.shadowPath)) }
    public static var shadowRadius: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: #keyPath(CALayer.shadowRadius)) }
    public static var sublayers: FluidCoreAnimatorPath<[CALayer]> { return FluidCoreAnimatorPath<[CALayer]>(keyPath: #keyPath(CALayer.sublayers)) }
    public static var sublayerTransform: FluidCoreAnimatorPath<CATransform3D> { return FluidCoreAnimatorPath<CATransform3D>(keyPath: #keyPath(CALayer.sublayerTransform)) }
    public static var transform: FluidCoreAnimatorPath<CATransform3D> { return FluidCoreAnimatorPath<CATransform3D>(keyPath: #keyPath(CALayer.transform)) }
    public static var zPosition: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: #keyPath(CALayer.zPosition)) }
}

extension FluidCoreAnimatorKey {
    public static var anchorPointX: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: "\(#keyPath(CALayer.anchorPoint)).x") }
    public static var anchorPointy: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: "\(#keyPath(CALayer.anchorPoint)).y") }
}

extension FluidCoreAnimatorKey {
    public static var boundsOrigin: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: "\(#keyPath(CALayer.bounds)).origin") }
    public static var boundsOriginX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.bounds)).origin.x") }
    public static var boundsOriginY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.bounds)).origin.y") }
    public static var boundsSize: FluidCoreAnimatorPath<CGSize> { return FluidCoreAnimatorPath<CGSize>(keyPath: "\(#keyPath(CALayer.bounds)).size") }
    public static var boundsSizeWidth: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.bounds)).size.width") }
    public static var boundsSizeHeight: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.bounds)).size.height") }
}

extension FluidCoreAnimatorKey {
    public static var contentsRectOrigin: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: "\(#keyPath(CALayer.contentsRect)).origin") }
    public static var contentsRectOriginX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.contentsRect)).origin.x") }
    public static var contentsRectOriginY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.contentsRect)).origin.y") }
    public static var contentsRectSize: FluidCoreAnimatorPath<CGSize> { return FluidCoreAnimatorPath<CGSize>(keyPath: "\(#keyPath(CALayer.contentsRect)).size") }
    public static var contentsRectSizeWidth: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.contentsRect)).size.width") }
    public static var contentsRectSizeHeight: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.contentsRect)).size.height") }
}

extension FluidCoreAnimatorKey {
    public static var frameOrigin: FluidCoreAnimatorPath<CGPoint> { return FluidCoreAnimatorPath<CGPoint>(keyPath: "\(#keyPath(CALayer.frame)).origin") }
    public static var frameOriginX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.frame)).origin.x") }
    public static var frameOriginY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.frame)).origin.y") }
    public static var frameSize: FluidCoreAnimatorPath<CGSize> { return FluidCoreAnimatorPath<CGSize>(keyPath: "\(#keyPath(CALayer.frame)).size") }
    public static var frameSizeWidth: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.frame)).size.width") }
    public static var frameSizeHeight: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.frame)).size.height") }
}

extension FluidCoreAnimatorKey {
    public static var positionX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.position)).x") }
    public static var positionY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.position)).y") }
}

extension FluidCoreAnimatorKey {
    public static var shadowOffsetWidth: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.shadowOffset)).width") }
    public static var shadowOffsetHeight: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.shadowOffset)).height") }
}

extension FluidCoreAnimatorKey {
    public static var sublayerTransformRotationX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).rotation.x") }
    public static var sublayerTransformRotationY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).rotation.y") }
    public static var sublayerTransformRotationZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).rotation.z") }
    public static var sublayerTransformScaleX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).scale.x") }
    public static var sublayerTransformScaleY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).scale.y") }
    public static var sublayerTransformScaleZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).scale.z") }
    public static var sublayerTransformTranslationX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).translation.x") }
    public static var sublayerTransformTranslationY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).translation.y") }
    public static var sublayerTransformTranslationZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.sublayerTransform)).translation.z") }
}

extension FluidCoreAnimatorKey {
    public static var transformRotationX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).rotation.x") }
    public static var transformRotationY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).rotation.y") }
    public static var transformRotationZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).rotation.z") }
    public static var transformScaleX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).scale.x") }
    public static var transformScaleY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).scale.y") }
    public static var transformScaleZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).scale.z") }
    public static var transformTranslationX: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).translation.x") }
    public static var transformTranslationY: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).translation.y") }
    public static var transformTranslationZ: FluidCoreAnimatorPath<CGFloat> { return FluidCoreAnimatorPath<CGFloat>(keyPath: "\(#keyPath(CALayer.transform)).translation.z") }
}
