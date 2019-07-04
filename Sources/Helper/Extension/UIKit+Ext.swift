//
//  UIKit+Ext.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

internal extension UIView {
    var numberOfSuperview: Int {
        var count: Int = 0
        var current: UIView? = self
        while current?.superview != nil {
            current = current?.superview
            count += 1
        }
        return count
    }

    static func mostTopView(_ views: UIView...) -> (index: Int, view: UIView?) {
        return mostTopView(views)
    }

    static func mostTopView(_ views: [UIView]) -> (index: Int, view: UIView?) {
        var counts: [Int] = .init(repeating: 0, count: views.count)
        for (i, elm): (Int, UIView) in views.enumerated() { counts[i] = elm.numberOfSuperview }
        guard let minViewCount: Int = counts.min(),
              let topViewIndex: Int = counts.firstIndex(where: { $0 == minViewCount }) else { return (index: 0, view: views.first) }
        guard let view: UIView = views[safe: topViewIndex] else { return (index: 0, view: views.first) }
        return (index: topViewIndex, view: view)
    }

//    func commonSuperviews(between lhs: UIView, and rhs: UIView) -> [UIView] {
//        func getSuperviews(for view: UIView) -> [UIView] {
//            guard let superview: UIView = view.superview else {
//                return []
//            }
//            return [superview] + getSuperviews(for: superview)
//        }
//        return Array(Set(getSuperviews(for: lhs)).intersection(Set(getSuperviews(for: rhs))))
//    }
//
//    func findCommonSuper(with view: UIView) -> UIView? {
//        var lhs: UIView? = self
//        var rhs: UIView? = view
//        var superSet = Set<UIView>()
//        while lhs != nil || rhs != nil {
//
//            if let lhsSuper: UIView = lhs {
//                if !superSet.contains(lhsSuper) { superSet.insert(lhsSuper) } else { return lhsSuper }
//            }
//            if let rhsSuper: UIView = rhs {
//                if !superSet.contains(rhsSuper) { superSet.insert(rhsSuper) } else { return rhsSuper }
//            }
//            lhs = lhs?.superview
//            rhs = rhs?.superview
//        }
//        return nil
//    }
}

extension UIView {
    var firstViewController: UIViewController? {
        let firstViewController = sequence(first: self, next: { $0.next }).first(where: { $0 is UIViewController })
        return firstViewController as? UIViewController
    }
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension UINavigationBar {
    weak var navigationController: UINavigationController? { return self.parentViewController as? UINavigationController }
    weak var contentView: UIView? { return self.subviews.first(where: { NSStringFromClass($0.classForCoder).contains("UINavigationBarContentView") }) }
    weak var backgroundView: UIView? { return self.subviews.first(where: { NSStringFromClass($0.classForCoder).contains("UIBarBackground") }) }
}

/**
 Constraint
 */
internal extension UIView {
    func constraint(for attribute: NSLayoutConstraint.Attribute, prefix: String) -> NSLayoutConstraint? {
        return self.constraints.filter { $0.identifier?.hasPrefix(prefix) ?? false && $0.firstAttribute == attribute }.first
    }

    func updateConstraintsImmediately() {
        self.setNeedsUpdateConstraints()
        self.updateConstraintsIfNeeded()
    }

    func updateLayoutImmediately() {
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }

    func updateConstraintsAndLayoutImmediately() {
        self.updateConstraintsImmediately()
        self.updateLayoutImmediately()
    }

    func setNeedsUpdateConstraintsAndLayout() {
        self.setNeedsUpdateConstraints()
        self.setNeedsLayout()
    }

    func updateConstraintsAndLayoutIfNeeded() {
        self.updateConstraintsIfNeeded()
        self.layoutIfNeeded()
    }
}

internal extension NSLayoutConstraint {
    func named(for attribute: NSLayoutConstraint.Attribute, prefix: String = FluidConst.constraintIdentifierPrefix) -> NSLayoutConstraint {
        self.identifier = prefix + attribute.description
        return self
    }
}

internal extension NSLayoutConstraint {
    @discardableResult
    func activate() -> Self {
        self.isActive = true
        return self
    }

    @discardableResult
    func deactivate() -> Self {
        self.isActive = false
        return self
    }

    @discardableResult
    func toggle() -> Self {
        self.isActive.toggle()
        return self
    }
}

extension NSLayoutConstraint.Attribute: CustomStringConvertible {
    public var description: String {
        switch self {
        case .left:                 return "left"
        case .right:                return "right"
        case .top:                  return "top"
        case .bottom:               return "bottom"
        case .leading:              return "leading"
        case .trailing:             return "trailing"
        case .width:                return "width"
        case .height:               return "height"
        case .centerX:              return "centerX"
        case .centerY:              return "centerY"
        case .lastBaseline:         return "lastBaseline"
        case .firstBaseline:        return "firstBaseline"
        case .leftMargin:           return "leftMargin"
        case .rightMargin:          return "rightMargin"
        case .topMargin:            return "topMargin"
        case .bottomMargin:         return "bottomMargin"
        case .leadingMargin:        return "leadingMargin"
        case .trailingMargin:       return "trailingMargin"
        case .centerXWithinMargins: return "centerXWithinMargins"
        case .centerYWithinMargins: return "centerYWithinMargins"
        case .notAnAttribute:       return "notAnAttribute"
        }
    }
}

/**
 Interaction
 */
extension UIGestureRecognizer {
    public var isEdgePan: Bool { return self is UIScreenEdgePanGestureRecognizer }
    public var isNormalPan: Bool { return self is UIPanGestureRecognizer && !(self is UIScreenEdgePanGestureRecognizer) }
}

extension UIGestureRecognizer.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .possible:  return "possible"
        case .began:     return "began"
        case .changed:   return "changed"
        case .ended:     return "ended"
        case .cancelled: return "cancelled"
        case .failed:    return "failed"
        }
    }
}

/**
 Orientation
 */
extension UIInterfaceOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .portrait:           return "portrait"
        case .portraitUpsideDown: return "portraitUpsideDown"
        case .landscapeRight:     return "landscapeRight"
        case .landscapeLeft:      return "landscapeLeft"
        case .unknown:            return "unknown"
        }
    }
}

extension UIDeviceOrientation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .portrait:           return "portrait"
        case .portraitUpsideDown: return "portraitUpsideDown"
        case .landscapeRight:     return "landscapeRight"
        case .landscapeLeft:      return "landscapeLeft"
        case .faceUp:             return "faceUp"
        case .faceDown:           return "faceDown"
        case .unknown:            return "unknown"
        }
    }
}

/**
 Transition
 */
extension UIModalPresentationStyle: CustomStringConvertible {
    public var description: String {
        switch self {
        case .fullScreen:         return "fullScreen"
        case .pageSheet:          return "pageSheet"
        case .formSheet:          return "formSheet"
        case .currentContext:     return "currentContext"
        case .custom:             return "custom"
        case .overFullScreen:     return "overFullScreen"
        case .overCurrentContext: return "overCurrentContext"
        case .popover:            return "popover"
        case .none:               return "none"
        }
    }
}

/**
 Idiom
 */
internal extension UIUserInterfaceIdiom {
    var isPhone: Bool { return self == .phone }
    var isPad: Bool { return self == .pad }
}

extension UIUserInterfaceIdiom: CustomStringConvertible {
    public var description: String {
        switch self {
        case .phone:       return "phone"
        case .pad:         return "pad"
        case .carPlay:     return "carPlay"
        case .tv:          return "tv"
        case .unspecified: return "unspecified"
        }
    }
}

/**
 Animation
 */
public extension UIViewPropertyAnimator {
    convenience init(duration: TimeInterval, easing: FluidAnimatorEasing) {
        self.init(duration: duration, timingParameters: easing.timingParameters)
    }
}

public extension UICubicTimingParameters {
    convenience init(_ c1x: CGFloat, _ c1y: CGFloat, _ c2x: CGFloat, _ c2y: CGFloat) {
        self.init(controlPoint1: CGPoint(x: c1x, y: c1y), controlPoint2: CGPoint(x: c2x, y: c2y))
    }
}

public extension UISpringTimingParameters {
    typealias SpringParameters = (mass: CGFloat, stiffness: CGFloat, damping: CGFloat, velocity: CGVector)

    convenience init(dampingRatio: CGFloat, frequencyResponse: CGFloat) {
        precondition(dampingRatio >= 0)
        precondition(frequencyResponse > 0)
        let params: SpringParameters = UISpringTimingParameters.parameters(dampingRatio: dampingRatio, frequencyResponse: frequencyResponse)
        self.init(mass: params.mass, stiffness: params.stiffness, damping: params.damping, initialVelocity: params.velocity)
    }

    /** https://github.com/jenox/UIKit-Playground/tree/master/01-Demystifying-UIKit-Spring-Animations */
    static func parameters(dampingRatio: CGFloat, frequencyResponse: CGFloat) -> SpringParameters {
        let mass: CGFloat = 1
        let stiffness: CGFloat = pow(2 * .pi / frequencyResponse, 2) * mass
        let damping: CGFloat = 4 * .pi * dampingRatio * mass / frequencyResponse
        let velocity: CGVector = .zero
        return (mass: mass,
                stiffness: stiffness,
                damping: damping,
                velocity: velocity)
    }

    static func duration(dampingRatio: CGFloat, frequencyResponse: CGFloat) -> TimeInterval {
        let params = UISpringTimingParameters.parameters(dampingRatio: dampingRatio, frequencyResponse: frequencyResponse)
        return duration(mass: params.mass, stiffness: params.stiffness, damping: params.damping, velocity: params.velocity)
    }

    static func duration(mass: CGFloat, stiffness: CGFloat, damping: CGFloat, velocity: CGVector) -> TimeInterval {
        let animation: CASpringAnimation = .init()
        animation.mass = mass
        animation.stiffness = stiffness
        animation.damping = damping
        animation.initialVelocity = velocity.length()
        return animation.settlingDuration
    }
}

extension UITimingCurveType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .builtin:  return "builtin"
        case .cubic:    return "cubic"
        case .spring:   return "spring"
        case .composed: return "composed"
        }
    }
}

extension UIViewAnimatingPosition: CustomStringConvertible {
    public var description: String {
        switch self {
        case .end:     return "end"
        case .start:   return "start"
        case .current: return "current"
        }
    }
}

extension UIViewAnimatingState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .active:   return "active"
        case .inactive: return "inactive"
        case .stopped:  return "stopped"
        default:        return "nil"
        }
    }
}

/**
 Views
 */
internal extension UIViewController {
    /** A `Boolean` value that indicates whether the view controller is a root view controller or placed at top of view controllers. */
    var isRootViewController: Bool {
        guard let nc: UINavigationController = (self as? UINavigationController)
                                               ?? self.navigationController else { return true }
        return nc.viewControllers.count <= 1
    }
}

extension UINavigationController.Operation: CustomStringConvertible {
    public var description: String {
        switch self {
        case .none: return "none"
        case .push: return "push"
        case .pop:  return "pop"
        }
    }
}

extension UIBarPosition: CustomStringConvertible {
    public var description: String {
        switch self {
        case .any: return "any"
        case .bottom: return "bottom"
        case .top:  return "top"
        case .topAttached:  return "topAttached"
        }
    }
}

internal extension UIScrollView {
    /** A `CGFloat` indicating a scrollable height. */
    var minScrollableX: CGFloat { return -self.effectiveContentInset.left }
    var maxScrollableX: CGFloat { return self.contentSize.width - self.bounds.width - self.effectiveContentInset.right }
    /** A `CGFloat` indicating a scrollable width. */
    var minScrollableY: CGFloat { return -self.effectiveContentInset.top }
    var maxScrollableY: CGFloat { return self.contentSize.height - self.bounds.height - self.effectiveContentInset.bottom }

    /** A CGPoint value indicating a normalized content offset depending on the effectiveContentInset value. */
    var normalizedContentOffset: CGPoint {
        return self.contentOffset.normalize(from: self.effectiveContentInset)
    }

    /** A UIEdgeInsets value indicating a effective content offset depending on the contentInsetAdjustmentBehavior value. */
    var effectiveContentInset: UIEdgeInsets {
        if #available(iOS 11, *) { return self.adjustedContentInset } else { return self.contentInset }
    }
}

/** An `UIBezierPath` extension to avoid animation glitches. */
internal extension UIBezierPath {
    convenience init(bounds: CGRect, cornerRadius: CGFloat, roundingCorners: UIRectCorner?) {
        let path: UIBezierPath = {
            if let roundingCorners: UIRectCorner = roundingCorners {
                /* NOTE: Set a magic number to avoid a bug in the drawing of the path that occurs when the value is zero */
                let radius: CGFloat = cornerRadius == 0 ? 0.00001 : cornerRadius
                return UIBezierPath(roundedRect: bounds, byRoundingCorners: roundingCorners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            } else {
                return UIBezierPath(rect: bounds)
            }
        }()
        self.init(cgPath: path.cgPath)
    }
}

extension UIRectCorner: CustomStringConvertible {
    /** The description. */
    public var description: String {
        var options: [String] = [String]()
        if self.contains(.topLeft) { options.append("topLeft") }
        if self.contains(.topRight) { options.append("topRight") }
        if self.contains(.bottomLeft) { options.append("bottomLeft") }
        if self.contains(.bottomRight) { options.append("bottomRight") }
        if self.contains(.allCorners) { options.append("allCorners") }
        guard options.count > 0 else { return "none" }
        return options.joined(separator: ", ")
    }
}

extension UIRectEdge: CustomStringConvertible {
    /** The description. */
    public var description: String {
        var options: [String] = [String]()
        if self.contains(.top) { options.append("top") }
        if self.contains(.right) { options.append("right") }
        if self.contains(.bottom) { options.append("bottom") }
        if self.contains(.left) { options.append("left") }
        if self.contains(.all) { options.append("all") }
        guard options.count > 0 else { return "none" }
        return options.joined(separator: ", ")
    }
}
