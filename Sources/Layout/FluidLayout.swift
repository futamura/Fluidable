//
//  FluidLayout.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

public struct FluidLayout {
    enum FluidPresentationType: CustomStringConvertible {
        case navigation, transition
        var description: String {
            switch self {
            case .navigation: return "navigation"
            case .transition: return "transition"
            }
        }
    }

    var style: FluidPresentationStyle
    var type: FluidPresentationType

    var trait: UITraitCollection

    weak var container: UIView!
    weak var content: UIView!

    /** Constraints for system default */
    var midX: NSLayoutConstraint! = nil
    var midY: NSLayoutConstraint! = nil
    var width: NSLayoutConstraint! = nil
    var height: NSLayoutConstraint! = nil

    /** Constraints for animated transition */
    var top: NSLayoutConstraint! = nil
    var bottom: NSLayoutConstraint! = nil
    var left: NSLayoutConstraint! = nil
    var right: NSLayoutConstraint! = nil

    var isFullScreen: Bool {
        switch self.type {
        case .navigation: return true
        case .transition: return self.top.constant.rounded() == 0 && self.bottom.constant.rounded() == 0 &&
                                 self.left.constant.rounded() == 0 && self.right.constant.rounded() == 0
        }
    }

    init(for presentationStyle: FluidPresentationStyle, presentationType: FluidPresentationType,
         container: UIView, content: UIView,
         containerSize: CGSize, contentSize: CGSize?) {
        Logger()?.log("✂️🛠", [
            "presentationStyle:".lpad() + String(describing: presentationStyle),
            "mode:".lpad() + String(describing: presentationType),
            "container:".lpad() + String(describing: container),
            "content:".lpad() + String(describing: content),
            "containerSize:".lpad() + String(describing: containerSize),
            "contentSize:".lpad() + String(describing: contentSize),
        ])
        self.style = presentationStyle
        self.type = presentationType
        self.container = container
        self.content = content
        let idiom: UIUserInterfaceIdiom = UIDevice.current.userInterfaceIdiom == .phone ? .phone : .pad
        let attributeIdiom: Idiom = idiom == .phone ? Idiom.phone : Idiom.pad
        self.trait = UITraitCollection(attributes: [attributeIdiom])
        let contentSize: CGSize = contentSize ?? FluidLayout.sizeConstant(for: presentationStyle, containerSize: containerSize, idiom: idiom, isInitial: false)
        switch self.type {
        case .navigation:
//            let fullScreenConstraint: FluidLayoutCenteredFullScreenConstraint = FluidLayout.centeredFullScreenAnchors(container, content)
//            self.midX = fullScreenConstraint.midX
//            self.midY = fullScreenConstraint.midY
//            self.width = fullScreenConstraint.width
//            self.height = fullScreenConstraint.height
            break
        case .transition:
            let edgeConstraint: FluidLayoutEdgeConstraint = {
                switch presentationStyle {
                case .scale, .slide: return FluidLayout.allEdgesAnchors(container, content, contentSize, containerSize)
                case .fluid: return FluidLayout.allEdgesAnchors(container, content, contentSize, containerSize)
                case .drawer(let position):
                    switch position {
                    case .top:    return FluidLayout.topEdgeDrawerAnchors(container, content, contentSize, containerSize)
                    case .bottom: return FluidLayout.bottomEdgeDrawerAnchors(container, content, contentSize, containerSize)
                    case .left:   return FluidLayout.leftEdgeDrawerAnchors(container, content, contentSize, containerSize)
                    case .right:  return FluidLayout.rightEdgeDrawerAnchors(container, content, contentSize, containerSize)
                    }
                }
            }()
            self.top = edgeConstraint.top
            self.bottom = edgeConstraint.bottom
            self.left = edgeConstraint.left
            self.right = edgeConstraint.right
        }
    }

    /* TODO: Support adaptive layout */
//    init(for attributes: [AdaptiveAttribute], constrain: @escaping ConstraintBlock) {
//        self.trait = UITraitCollection(attributes: attributes)
//        self.constrainBlock = constrain
//    }

//    init(for trait: UITraitCollection, constrain: @escaping ConstraintBlock) {
//        self.trait = trait
//        self.constrainBlock = constrain
//    }

//    init(for trait: UITraitCollection, constraints: [NSLayoutConstraint]) {
//        self.trait = trait
//        self.constraints = constraints
//    }
}

extension FluidLayout {
    mutating func activate(type: FluidPresentationType) {
        Logger()?.log("✂️🎬", [
            "mode:".lpad(64) + String(describing: type),
            "container:".lpad(64) + String(describing: container),
            "content:".lpad(64) + String(describing: content),
            "container.translatesAutoresizingMaskIntoConstraints:".lpad(64) + String(describing: container.translatesAutoresizingMaskIntoConstraints),
            "content.translatesAutoresizingMaskIntoConstraints:".lpad(64) + String(describing: content.translatesAutoresizingMaskIntoConstraints),
        ])
        switch type {
        case .navigation:
//            self.midX?.activate()
//            self.midY?.activate()
//            self.width?.activate()
//            self.height?.activate()
//            self.content.translatesAutoresizingMaskIntoConstraints = true
            break
        case .transition:
//            self.content.translatesAutoresizingMaskIntoConstraints = false
            self.top?.activate()
            self.bottom?.activate()
            self.left?.activate()
            self.right?.activate()
        }
    }

    func deactivate(type: FluidPresentationType) {
        Logger()?.log("✂️🎬", [
            "mode:".lpad(64) + String(describing: type),
            "container:".lpad(64) + String(describing: container),
            "content:".lpad(64) + String(describing: content),
            "container.translatesAutoresizingMaskIntoConstraints:".lpad(64) + String(describing: container.translatesAutoresizingMaskIntoConstraints),
            "content.translatesAutoresizingMaskIntoConstraints:".lpad(64) + String(describing: content.translatesAutoresizingMaskIntoConstraints),
        ])
        switch type {
        case .navigation:
//            self.midX?.deactivate()
//            self.midY?.deactivate()
//            self.width?.deactivate()
//            self.height?.deactivate()
            break
        case .transition:
            self.top?.deactivate()
            self.bottom?.deactivate()
            self.left?.deactivate()
            self.right?.deactivate()
        }
    }
}

extension FluidLayout {
    func apply(top: CGFloat? = nil, bottom: CGFloat? = nil, left: CGFloat? = nil, right: CGFloat? = nil) {
//        Logger()?.log("✂️🎬", [
//            "top:".lpad() + String(describing: top),
//            "bottom:".lpad() + String(describing: bottom),
//            "left:".lpad() + String(describing: left),
//            "right:".lpad() + String(describing: right),
//        ])
        if let value: CGFloat = top { self.top.constant = value }
        if let value: CGFloat = bottom { self.bottom.constant = value }
        if let value: CGFloat = left { self.left.constant = value }
        if let value: CGFloat = right { self.right.constant = value }
    }

    func apply(edges: FluidLayoutEdgeConstant) {
//        Logger()?.log("✂️🎬", [
//            "edges:".lpad() + String(describing: edges),
//        ])
        self.top?.constant = edges.top
        self.bottom?.constant = edges.bottom
        self.left?.constant = edges.left
        self.right?.constant = edges.right
    }
}
