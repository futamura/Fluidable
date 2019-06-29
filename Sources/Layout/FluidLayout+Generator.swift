//
//  FluidLayout.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

extension FluidLayout {
    static func createFrame(for style: FluidPresentationStyle,
                            containerSize: CGSize, contentOrigin: CGPoint?, contentSize: CGSize?,
                            idiom: UIUserInterfaceIdiom, isInitial: Bool) -> CGRect {
        let contentSize: CGSize = contentSize ?? sizeConstant(for: style, containerSize: containerSize, idiom: idiom, isInitial: isInitial)
        let contentOrigin: CGPoint = contentOrigin ?? positionConstant(for: style, containerSize: containerSize, contentSize: contentSize, isInitial: isInitial)
        return CGRect(origin: contentOrigin, size: contentSize)
    }
}

extension FluidLayout {
    static func allEdgesAnchors(_ container: UIView, _ view: UIView, _ containerSize: CGSize, _ contentSize: CGSize) -> FluidLayoutEdgeConstraint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        let horizontalMargin: CGFloat = (containerWidth - contentSize.width) / 2
        let verticalMargin: CGFloat = (containerHeight - contentSize.height) / 2
        return .init(topAnchor(container, view, constant: verticalMargin),
                     bottomAnchor(container, view, constant: verticalMargin),
                     leftAnchor(container, view, constant: horizontalMargin),
                     rightAnchor(container, view, constant: horizontalMargin))
    }

    static func topEdgeDrawerAnchors(_ container: UIView, _ view: UIView, _ containerSize: CGSize, _ contentSize: CGSize) -> FluidLayoutEdgeConstraint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        let horizontalMargin: CGFloat = (containerWidth - contentSize.width) / 2
        let verticalMargin: CGFloat = (containerHeight - contentSize.height)
        return .init(topAnchor(container, view, constant: 0),
                     bottomAnchor(container, view, constant: verticalMargin),
                     leftAnchor(container, view, constant: horizontalMargin),
                     rightAnchor(container, view, constant: horizontalMargin))
    }

    static func bottomEdgeDrawerAnchors(_ container: UIView, _ view: UIView, _ containerSize: CGSize, _ contentSize: CGSize) -> FluidLayoutEdgeConstraint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        let horizontalMargin: CGFloat = (containerWidth - contentSize.width) / 2
        let verticalMargin: CGFloat = (containerHeight - contentSize.height)
        return .init(topAnchor(container, view, constant: verticalMargin),
                     bottomAnchor(container, view, constant: 0),
                     leftAnchor(container, view, constant: horizontalMargin),
                     rightAnchor(container, view, constant: horizontalMargin))
    }

    static func leftEdgeDrawerAnchors(_ container: UIView, _ view: UIView, _ containerSize: CGSize, _ contentSize: CGSize) -> FluidLayoutEdgeConstraint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        let horizontalMargin: CGFloat = (containerWidth - contentSize.width)
        let verticalMargin: CGFloat = (containerHeight - contentSize.height) / 2
        return .init(topAnchor(container, view, constant: verticalMargin),
                     bottomAnchor(container, view, constant: verticalMargin),
                     leftAnchor(container, view, constant: 0),
                     rightAnchor(container, view, constant: horizontalMargin))
    }

    static func rightEdgeDrawerAnchors(_ container: UIView, _ view: UIView, _ containerSize: CGSize, _ contentSize: CGSize) -> FluidLayoutEdgeConstraint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        let horizontalMargin: CGFloat = (containerWidth - contentSize.width)
        let verticalMargin: CGFloat = (containerHeight - contentSize.height) / 2
        return .init(topAnchor(container, view, constant: verticalMargin),
                     bottomAnchor(container, view, constant: verticalMargin),
                     leftAnchor(container, view, constant: horizontalMargin),
                     rightAnchor(container, view, constant: 0))
    }

    static func centeredFullScreenAnchors(_ container: UIView, _ content: UIView) -> FluidLayoutCenteredFullScreenConstraint {
        container.constraints.forEach {
            print($0)
        }
        print()
        content.constraints.forEach {
            print($0)
        }
        print()
        return .init(centerXAnchor(container, content, constant: 0),
                     centerYAnchor(container, content, constant: 0),
                     widthAnchor(container, content, constant: 0),
                     heightAnchor(container, content, constant: 0))
    }
}

extension FluidLayout {
    static func topAnchor(_ container: UIView, _ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .top, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.topAnchor.constraint(equalTo: container.topAnchor, constant: constant).named(for: .top)
        }
        return constraint
    }

    static func bottomAnchor(_ container: UIView, _ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .bottom, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: constant).named(for: .bottom)
        }
        return constraint
    }

    static func leftAnchor(_ container: UIView, _ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .left, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.leftAnchor.constraint(equalTo: container.leftAnchor, constant: constant).named(for: .left)
        }
        return constraint
    }

    static func rightAnchor(_ container: UIView, _ view: UIView, constant: CGFloat) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .right, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.rightAnchor.constraint(equalTo: container.rightAnchor, constant: constant).named(for: .right)
        }
        return constraint
    }

    static func centerXAnchor(_ container: UIView, _ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .centerX, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.centerXAnchor.constraint(equalTo: container.centerXAnchor, constant: constant).named(for: .centerX)
        }
        return constraint
    }

    static func centerYAnchor(_ container: UIView, _ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .centerY, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.centerYAnchor.constraint(equalTo: container.centerYAnchor, constant: constant).named(for: .centerY)
        }
        return constraint
    }

    static func widthAnchor(_ container: UIView, _ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .width, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.widthAnchor.constraint(equalTo: container.widthAnchor, constant: constant).named(for: .width)
        }
        return constraint
    }

    static func heightAnchor(_ container: UIView, _ view: UIView, constant: CGFloat = 0) -> NSLayoutConstraint {
        guard let constraint: NSLayoutConstraint = container.constraint(for: .height, prefix: FluidConst.constraintIdentifierPrefix) else {
            return view.heightAnchor.constraint(equalTo: container.heightAnchor, constant: constant).named(for: .height)
        }
        return constraint
    }
}

extension FluidLayout {
    static func positionConstant(for style: FluidPresentationStyle, containerSize: CGSize, contentSize: CGSize, isInitial: Bool) -> CGPoint {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        switch style {
        case .fluid:
            return CGPoint(x: (containerWidth - contentSize.width) / 2, y: (containerHeight - contentSize.height) / 2)
        case .scale:
            return CGPoint(x: (containerWidth - contentSize.width) / 2, y: (containerHeight - contentSize.height) / 2)
        case .slide(let direction):
            var contentOrigin: CGPoint = .zero
            if isInitial {
                switch direction {
                case .fromTop:    contentOrigin.y = -contentSize.height
                case .fromBottom: contentOrigin.y = contentSize.height
                case .fromLeft:   contentOrigin.x = -contentSize.width
                case .fromRight:  contentOrigin.x = contentSize.width
                }
            }
            return contentOrigin
        case .drawer(let position):
            var contentOrigin: CGPoint = .zero
            switch position {
            case .top, .bottom:
                contentOrigin.x = ((containerWidth - contentSize.width) / 2).rounded()
                switch position {
                case .top    where isInitial:  contentOrigin.y = -contentSize.height
                case .top    where !isInitial: contentOrigin.y = 0
                case .bottom where isInitial:  contentOrigin.y = containerHeight
                case .bottom where !isInitial: contentOrigin.y = containerHeight - contentSize.height
                default: break
                }
            case .left, .right:
                contentOrigin.y = ((containerHeight - contentSize.height) / 2).rounded()
                switch position {
                case .left  where isInitial:  contentOrigin.x = -contentSize.width
                case .left  where !isInitial: contentOrigin.x = 0
                case .right where isInitial:  contentOrigin.x = containerWidth
                case .right where !isInitial: contentOrigin.x = containerWidth - contentSize.width
                default: break
                }
            }
            return contentOrigin
        }
    }

    static func sizeConstant(for style: FluidPresentationStyle, containerSize: CGSize, idiom: UIUserInterfaceIdiom, isInitial: Bool) -> CGSize {
        let containerWidth: CGFloat = containerSize.width
        let containerHeight: CGFloat = containerSize.height
        switch style {
        case .fluid:
            let contentSize: CGSize = {
                switch idiom {
                case .phone where containerSize.isPortrait:  return CGSize(width: (containerWidth * 0.6).rounded(), height: (containerHeight * 0.8).rounded())
                case .phone where !containerSize.isPortrait: return CGSize(width: (containerWidth * 0.6).rounded(), height: (containerHeight * 0.8).rounded())
                case .pad   where containerSize.isPortrait:  return CGSize(width: (containerWidth * 0.6).rounded(), height: (containerHeight * 0.8).rounded())
                case .pad   where !containerSize.isPortrait: return CGSize(width: (containerWidth * 0.6).rounded(), height: (containerHeight * 0.8).rounded())
                default: return .zero
                }
            }()
            switch isInitial {
            case true:  return CGSize(width: (contentSize.width * 0.9).rounded(), height: (contentSize.height * 0.9).rounded())
            case false: return CGSize(width: containerWidth, height: containerHeight)
            }
        case .scale:
            let contentSize: CGSize = CGSize(width: containerWidth, height: containerHeight)
            switch isInitial {
            case true:  return CGSize(width: (contentSize.width * 0.9).rounded(), height: (contentSize.height * 0.9).rounded())
            case false: return contentSize
            }
        case .slide:
            return CGSize(width: containerWidth, height: containerHeight)
        case .drawer(let position):
            switch position {
            case .top, .bottom:
                switch idiom {
                case .phone where containerSize.isPortrait:  return CGSize(width: containerWidth, height: (containerHeight * 0.75).rounded())
                case .phone where !containerSize.isPortrait: return CGSize(width: containerHeight, height: containerHeight)
                case .pad   where containerSize.isPortrait:  return CGSize(width: containerWidth, height: (containerHeight * 0.75).rounded())
                case .pad   where !containerSize.isPortrait: return CGSize(width: containerHeight, height: containerHeight)
                default: return .zero
                }
            case .left, .right:
                switch idiom {
                case .phone where containerSize.isPortrait:  return CGSize(width: (containerWidth - 92.0).rounded(), height: containerHeight)
                case .phone where !containerSize.isPortrait: return CGSize(width: containerHeight, height: containerHeight)
                case .pad   where containerSize.isPortrait:  return CGSize(width: (containerWidth * 0.50).rounded(), height: containerHeight)
                case .pad   where !containerSize.isPortrait: return CGSize(width: (containerWidth * 0.33).rounded(), height: containerHeight)
                default: return .zero
                }
            }
        }
    }
}

extension FluidLayout {
    static func trait(for size: CGSize) -> UITraitCollection {
        let idiom: Idiom = UIDevice.current.userInterfaceIdiom == .phone ? Idiom.phone : Idiom.pad
        switch size.width < size.height {
        case true:  return UITraitCollection(attributes: [idiom, SizeClass.horizontalCompact, SizeClass.verticalRegular])
        case false: return UITraitCollection(attributes: [idiom, SizeClass.horizontalRegular, SizeClass.verticalCompact])
        }
    }
}
