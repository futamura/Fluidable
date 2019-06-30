//
//  FluidFrameDimension.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

public protocol FluidTransformConvertible {
    static var identity: Self { get }
    func toCATransform3D() -> CATransform3D
    func toCGAffineTransform() -> CGAffineTransform
}

extension CATransform3D: FluidTransformConvertible {
    public func toCATransform3D() -> CATransform3D { return self }
    public func toCGAffineTransform() -> CGAffineTransform { return self.affineTransform ?? .identity }
}

extension CGAffineTransform: FluidTransformConvertible {
    public func toCATransform3D() -> CATransform3D { return CATransform3D(with: self) }
    public func toCGAffineTransform() -> CGAffineTransform { return self }
}

/**
 The protocol that compatibles to `FluidInitialFrameDimension` amd `FluidFinalFrameDimension`.
 */
public protocol FluidFrameDimensionCompatible {
    func frame(for containerSize: CGSize?) -> CGRect
    func transform(for containerSize: CGSize?) -> CATransform3D
}

/**
 The initial frame dimension that conforms to the `FluidFrameDimensionCompatible` protocol.
 */
public struct FluidInitialFrameDimension: FluidFrameDimensionCompatible {
    /** A `CGRect` value that determines a frame dimension. */
    private var frame: CGRect { return CGRect(origin: self.origin ?? .zero, size: self.size ?? .zero) }
    /** A `CGPoint` value that determines a frame origin. */
    private var origin: CGPoint!
    /** A `CGSize` value that determines a frame size. */
    private var size: CGSize!
    /** A `CATransform3D` value that determines a transform. */
    private var transform: CATransform3D = .identity

    internal init() {}

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter presentationStyle: The `FluidPresentationStyle` value of the transition.
     - parameter origin: The position value of the destination frame when the transition starts.
     - parameter size: The size value of the destination frame when the transition starts.
     */
    internal init<T: FluidTransformConvertible>(for presentationStyle: FluidPresentationStyle,
                                                containerSize: CGSize? = nil, contentOrigin: CGPoint, contentSize: CGSize, contentTransform: T = T.identity) {
        let idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        let containerSize: CGSize = containerSize ?? UIApplication.shared.keyWindow?.frame.size ?? UIScreen.main.bounds.size
        let frame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                    containerSize: containerSize, contentOrigin: contentOrigin, contentSize: contentSize,
                                                    idiom: idiom, isInitial: true)
        self.origin = frame.origin
        self.size = frame.size
        self.transform = contentTransform.toCATransform3D()
    }

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter navigationStyle: The `FluidNavigationStyle` value of the navigation.
     - parameter origin: The position value of the destination frame when the transition starts.
     - parameter size: The size value of the destination frame when the transition starts.
     */
    public init<T: FluidTransformConvertible>(for navigationStyle: FluidNavigationStyle, containerSize: CGSize? = nil, contentOrigin: CGPoint, contentSize: CGSize, contentTransform: T = T.identity) {
        self.init(for: .init(fromNavigation: navigationStyle), containerSize: containerSize, contentOrigin: contentOrigin, contentSize: contentSize, contentTransform: contentTransform)
    }

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter transitionStyle: The `FluidTransitionStyle` value of the transition.
     - parameter origin: The position value of the destination frame when the transition starts.
     - parameter size: The size value of the destination frame when the transition starts.
     */
    public init<T: FluidTransformConvertible>(for transitionStyle: FluidTransitionStyle, containerSize: CGSize? = nil, contentOrigin: CGPoint, contentSize: CGSize, contentTransform: T = T.identity) {
        self.init(for: .init(fromTransition: transitionStyle), containerSize: containerSize, contentOrigin: contentOrigin, contentSize: contentSize, contentTransform: contentTransform)
    }
}

extension FluidInitialFrameDimension {
    /**
     The function that returns initial frame for an orientation.

     - parameter orientation: The `UIInterfaceOrientation` value.
     - returns: The `CATransform3D` value.
     */
    public func frame(for containerSize: CGSize? = nil) -> CGRect {
        return self.frame
    }

    /**
     The function that returns final transform for an orientation.

     - parameter orientation: The `UIInterfaceOrientation` value.
     - returns: The `CATransform3D` value.
     */
    public func transform(for containerSize: CGSize? = nil) -> CATransform3D {
        return self.transform
    }
}

extension FluidInitialFrameDimension {
    internal mutating func validate(for presentationStyle: FluidPresentationStyle, finalDimension: FluidFinalFrameDimension?, containerSize: CGSize?) -> FluidInitialFrameDimension {
        let idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        let contentSize: CGSize? = {
            if let size: CGSize = self.size { return size }
            if presentationStyle.isSlide || presentationStyle.isDrawer { return finalDimension?.frame().size }
            return nil
        }()
        let containerSize: CGSize = containerSize ?? UIApplication.shared.keyWindow?.frame.size ?? UIScreen.main.bounds.size
        let contentFrame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                           containerSize: containerSize, contentOrigin: origin, contentSize: contentSize,
                                                           idiom: idiom, isInitial: true)
        self.origin = contentFrame.origin
        self.size = contentFrame.size
        return self
    }
}

/**
 The final frame dimension that conforms to the `FluidFrameDimensionCompatible` protocol.
 */
public struct FluidFinalFrameDimension: FluidFrameDimensionCompatible {
    /** A `CGRect` value that determines a portrait frame. */
    private var portraitFrame: CGRect { return CGRect(origin: self.portraitOrigin ?? .zero, size: self.portraitSize ?? .zero) }
    /** A `CGPoint` value that determines a portrait origin. */
    private var portraitOrigin: CGPoint!
    /** A `CGSize` value that determines a portrait size. */
    private var portraitSize: CGSize!
    /** A `CGRect` value that determines a landscape frame. */
    private var landscapeFrame: CGRect { return CGRect(origin: self.landscapeOrigin ?? .zero, size: self.landscapeSize ?? .zero) }
    /** A `CGPoint` value that determines a landscape origin. */
    private var landscapeOrigin: CGPoint!
    /** A `CGSize` value that determines a landscape size. */
    private var landscapeSize: CGSize!
    /** A `CATransform3D` value that determines a portrait transform. */
    private var portraitTransform: CATransform3D = .identity
    /** A `CATransform3D` value that determines a landscape transform. */
    private var landscapeTransform: CATransform3D = .identity

    internal init() {}

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter presentationStyle: The `FluidPresentationStyle` value of the transition.
     - parameter origin: The position value of the destination frame when the transition ends.
     - parameter size: The size value of the destination frame when the transition ends.
     */
    internal init<T: FluidTransformConvertible>(for presentationStyle: FluidPresentationStyle,
                                                portraitContainerSize: CGSize? = nil, landscapeContainerSize: CGSize? = nil,
                                                portraitContentOrigin: CGPoint? = nil, portraitContentSize: CGSize? = nil,
                                                landscapeContentOrigin: CGPoint? = nil, landscapeContentSize: CGSize? = nil,
                                                portraitContentTransform: T = .identity, landscapeContentTransform: T = .identity) {
        let containerSize: CGSize = UIApplication.shared.keyWindow?.frame.size ?? UIScreen.main.bounds.size
        let minLength: CGFloat = min(containerSize.width, containerSize.height)
        let maxLength: CGFloat = max(containerSize.width, containerSize.height)
        let portraitContainerSize: CGSize = portraitContainerSize ?? CGSize(width: minLength, height: maxLength)
        let landscapeContainerSize: CGSize = landscapeContainerSize ?? CGSize(width: maxLength, height: minLength)
//        Logger()?.log("📐️🛠", [
//            "presentationStyle:".lpad() + String(describing: presentationStyle),
//            "portraitContainerSize:".lpad() + String(describing: portraitContainerSize),
//            "landscapeContainerSize:".lpad() + String(describing: landscapeContainerSize),
//            "portraitContentOrigin:".lpad() + String(describing: portraitContentOrigin),
//            "portraitContentSize:".lpad() + String(describing: portraitContentSize),
//            "landscapeContentOrigin:".lpad() + String(describing: landscapeContentOrigin),
//            "landscapeContentSize:".lpad() + String(describing: landscapeContentSize),
//            "portraitContentTransform:".lpad() + String(describing: portraitContentTransform),
//        ])
        let idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        let portraitFrame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                            containerSize: portraitContainerSize, contentOrigin: portraitContentOrigin, contentSize: portraitContentSize,
                                                            idiom: idiom, isInitial: false)
        let landscapeFrame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                             containerSize: landscapeContainerSize, contentOrigin: landscapeContentOrigin, contentSize: landscapeContentSize,
                                                             idiom: idiom, isInitial: false)
        self.portraitOrigin = portraitFrame.origin
        self.portraitSize = portraitFrame.size
        self.landscapeOrigin = landscapeFrame.origin
        self.landscapeSize = landscapeFrame.size
        self.portraitTransform = portraitContentTransform.toCATransform3D()
        self.landscapeTransform = landscapeContentTransform.toCATransform3D()
    }

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter navigationStyle: The `FluidNavigationStyle` value of the navigation.
     - parameter origin: The position value of the destination frame when the transition ends.
     - parameter size: The size value of the destination frame when the transition ends.
     */
    public init<T: FluidTransformConvertible>(for navigationStyle: FluidNavigationStyle,
                                              portraitContainerSize: CGSize? = nil, landscapeContainerSize: CGSize? = nil,
                                              portraitContentOrigin: CGPoint? = nil, portraitContentSize: CGSize? = nil,
                                              landscapeContentOrigin: CGPoint? = nil, landscapeContentSize: CGSize? = nil,
                                              portraitContentTransform: T = .identity, landscapeContentTransform: T = .identity) {
        self.init(for: .init(fromNavigation: navigationStyle),
                  portraitContainerSize: portraitContainerSize, landscapeContainerSize: landscapeContainerSize,
                  portraitContentOrigin: portraitContentOrigin, portraitContentSize: portraitContentSize,
                  landscapeContentOrigin: landscapeContentOrigin, landscapeContentSize: landscapeContentSize,
                  portraitContentTransform: portraitContentTransform, landscapeContentTransform: landscapeContentTransform)
    }

    /**
     The initializer that instantiates a `FluidInitialFrameDimension` object.

     - parameter transitionStyle: The `FluidTransitionStyle` value of the transition.
     - parameter origin: The position value of the destination frame when the transition ends.
     - parameter size: The size value of the destination frame when the transition ends.
     */
    public init<T: FluidTransformConvertible>(for transitionStyle: FluidTransitionStyle,
                                              portraitContainerSize: CGSize? = nil, landscapeContainerSize: CGSize? = nil,
                                              portraitContentOrigin: CGPoint? = nil, portraitContentSize: CGSize? = nil,
                                              landscapeContentOrigin: CGPoint? = nil, landscapeContentSize: CGSize? = nil,
                                              portraitContentTransform: T = .identity, landscapeContentTransform: T = .identity) {
        self.init(for: .init(fromTransition: transitionStyle),
                  portraitContainerSize: portraitContainerSize, landscapeContainerSize: landscapeContainerSize,
                  portraitContentOrigin: portraitContentOrigin, portraitContentSize: portraitContentSize,
                  landscapeContentOrigin: landscapeContentOrigin, landscapeContentSize: landscapeContentSize,
                  portraitContentTransform: portraitContentTransform, landscapeContentTransform: landscapeContentTransform)
    }
}

extension FluidFinalFrameDimension {
    /**
     The function that returns final frame for an orientation.

     - parameter orientation: The `UIInterfaceOrientation` value.
     - returns: The `CGRect` value.
     */
    public func frame(for containerSize: CGSize? = nil) -> CGRect {
        let orientation: UIInterfaceOrientation = containerSize?.orientation ?? UIApplication.shared.keyWindow?.bounds.size.orientation ?? UIApplication.shared.statusBarOrientation
        return orientation.isPortrait ? self.portraitFrame : self.landscapeFrame
    }

    /**
     The function that returns final transform for an orientation.

     - parameter orientation: The `UIInterfaceOrientation` value.
     - returns: The `CATransform3D` value.
     */
    public func transform(for containerSize: CGSize? = nil) -> CATransform3D {
        let orientation: UIInterfaceOrientation = containerSize?.orientation ?? UIApplication.shared.keyWindow?.bounds.size.orientation ?? UIApplication.shared.statusBarOrientation
        return orientation.isPortrait ? self.portraitTransform : self.landscapeTransform
    }
}

extension FluidFinalFrameDimension {
    internal mutating func validate(for presentationStyle: FluidPresentationStyle, containerSize: CGSize) -> FluidFinalFrameDimension {
        let idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        let portraitFrame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                            containerSize: containerSize, contentOrigin: self.portraitOrigin, contentSize: self.portraitSize,
                                                            idiom: idiom, isInitial: false)
        let landscapeFrame: CGRect = FluidLayout.createFrame(for: presentationStyle,
                                                             containerSize: containerSize, contentOrigin: self.landscapeOrigin, contentSize: self.landscapeSize,
                                                             idiom: idiom, isInitial: false)
        self.portraitOrigin = portraitFrame.origin
        self.portraitSize = portraitFrame.size
        self.landscapeOrigin = landscapeFrame.origin
        self.landscapeSize = landscapeFrame.size
        return self
    }
}
