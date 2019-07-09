//
//  RootModel.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

enum RootModel: Int, CustomStringConvertible, CaseIterable {
    case navigationFluidModal = 0
    case navigationFluidFullScreen

    case navigationDrawerTop
    case navigationDrawerBottom
    case navigationDrawerLeft
    case navigationDrawerRight

    case navigationSlideTop
    case navigationSlideBottom
    case navigationSlideLeft
    case navigationSlideRight

    case transitionFluidModal
    case transitionFluidFullScreen

    case transitionDrawerTop
    case transitionDrawerBottom
    case transitionDrawerLeft
    case transitionDrawerRight

    case transitionSlideTop
    case transitionSlideBottom
    case transitionSlideLeft
    case transitionSlideRight
}

extension RootModel {
    var classType: UIViewController.Type {
        switch self {
        case .navigationFluidModal:      return NavigationScrollViewController.self
        case .navigationFluidFullScreen: return NavigationTableViewController.self

        case .navigationDrawerTop:       return NavigationScrollViewController.self
        case .navigationDrawerBottom:    return NavigationTableViewController.self
        case .navigationDrawerLeft:      return NavigationCollectionViewController.self
        case .navigationDrawerRight:     return NavigationMultiCollectionViewController.self

        case .navigationSlideTop:        return NavigationScrollViewController.self
        case .navigationSlideBottom:     return NavigationTableViewController.self
        case .navigationSlideLeft:       return NavigationCollectionViewController.self
        case .navigationSlideRight:      return NavigationMultiCollectionViewController.self

        case .transitionFluidModal:      return TransitionScrollViewController.self
        case .transitionFluidFullScreen: return TransitionTableViewController.self

        case .transitionDrawerLeft:      return TransitionScrollViewController.self
        case .transitionDrawerRight:     return TransitionTableViewController.self
        case .transitionDrawerTop:       return TransitionCollectionViewController.self
        case .transitionDrawerBottom:    return TransitionMultiCollectionViewController.self

        case .transitionSlideTop:        return TransitionScrollViewController.self
        case .transitionSlideBottom:     return TransitionTableViewController.self
        case .transitionSlideLeft:       return TransitionCollectionViewController.self
        case .transitionSlideRight:      return TransitionMultiCollectionViewController.self
        }
    }

    var className: String {
        return self.classType.className
    }

    func instantiate() -> UIViewController {
        switch self.presentationType {
        case .navigation:
            let nc: NavigationRootNavigationController = UINib.instantiate(nibName: NavigationRootNavigationController.className)
            let vc: RootModelReceivable & UIViewController = UINib.instantiate(nibName: self.classType.className)
            nc.configure(modelIndex: self.rawValue)
            nc.pushViewController(vc, animated: false)
            vc.configure(modelIndex: self.rawValue)
            return nc
        case .transition:
            let vc: RootModelReceivable & UIViewController = UINib.instantiate(nibName: self.classType.className)
            vc.configure(modelIndex: self.rawValue)
            return vc
        }
    }
}

extension RootModel {
    var presentationType: RootPresentationType {
        switch self {
        case .navigationFluidModal, .navigationFluidFullScreen,
             .navigationDrawerTop, .navigationDrawerBottom,
             .navigationDrawerLeft, .navigationDrawerRight,
             .navigationSlideTop, .navigationSlideBottom,
             .navigationSlideLeft, .navigationSlideRight: return .navigation
        case .transitionFluidModal, .transitionFluidFullScreen,
             .transitionDrawerTop, .transitionDrawerBottom,
             .transitionDrawerLeft, .transitionDrawerRight,
             .transitionSlideTop, .transitionSlideBottom,
             .transitionSlideLeft, .transitionSlideRight: return .transition
        }
    }

    var cellType: RootCellType {
        switch self {
        case .navigationFluidModal:      return .image
        case .navigationFluidFullScreen: return .table

        case .navigationDrawerTop:       return .imageText
        case .navigationDrawerBottom:    return .table
        case .navigationDrawerLeft:      return .image
        case .navigationDrawerRight:     return .image

        case .navigationSlideTop:        return .imageText
        case .navigationSlideBottom:     return .table
        case .navigationSlideLeft:       return .image
        case .navigationSlideRight:      return .image

        case .transitionFluidModal:      return .image
        case .transitionFluidFullScreen: return .table

        case .transitionDrawerTop:       return .imageText
        case .transitionDrawerBottom:    return .table
        case .transitionDrawerLeft:      return .image
        case .transitionDrawerRight:     return .image

        case .transitionSlideTop:        return .imageText
        case .transitionSlideBottom:     return .table
        case .transitionSlideLeft:       return .image
        case .transitionSlideRight:      return .image
        }
    }

    var transitionStyle: FluidTransitionStyle {
        switch self {
        case .navigationFluidModal,
             .transitionFluidModal:      return .fluid(behavior: .all)
        case .navigationFluidFullScreen,
             .transitionFluidFullScreen: return .fluid(behavior: .scale)
        case .navigationDrawerTop,
             .transitionDrawerTop:       return .drawer(position: .top)
        case .navigationDrawerBottom,
             .transitionDrawerBottom:    return .drawer(position: .bottom)
        case .navigationDrawerLeft,
             .transitionDrawerLeft:      return .drawer(position: .left)
        case .navigationDrawerRight,
             .transitionDrawerRight:     return .drawer(position: .right)
        case .navigationSlideTop,
             .transitionSlideTop:        return .slide(direction: .fromTop)
        case .navigationSlideBottom,
             .transitionSlideBottom:     return .slide(direction: .fromBottom)
        case .navigationSlideLeft,
             .transitionSlideLeft:       return .slide(direction: .fromLeft)
        case .navigationSlideRight,
             .transitionSlideRight:      return .slide(direction: .fromRight)
        }
    }

    var backgroundStyle: FluidBackgroundStyle {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return .blur(radius: 12, color: .clear, alpha: 1.0)
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return .dim(color: UIColor.black.withAlphaComponent(0.5))
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return .none
        case .transitionSlideTop, .navigationSlideTop, .transitionSlideBottom, .navigationSlideBottom,
             .transitionSlideLeft, .navigationSlideLeft, .transitionSlideRight, .navigationSlideRight:
            return .dim(color: UIColor.black.withAlphaComponent(0.5))
        }
    }

    var initialFrameStyle: FluidInitialFrameStyle? {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return FluidInitialFrameStyle(cornerRadius: ExampleConst.cornerRadius,
                                          shadowOpacity: ExampleConst.shadowOpacity,
                                          shadowRadius: ExampleConst.shadowRadius,
                                          shadowOffset: ExampleConst.shadowOffset)
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return FluidInitialFrameStyle(cornerRadius: ExampleConst.cornerRadius,
                                          shadowOpacity: ExampleConst.shadowOpacity,
                                          shadowRadius: ExampleConst.shadowRadius,
                                          shadowOffset: ExampleConst.shadowOffset)
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return .none
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return .none
        }
    }

    var finalFrameStyle: FluidFinalFrameStyle? {
        let mult: CGFloat = UIDevice.current.isPhone ? 1 : 2
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return FluidFinalFrameStyle(cornerRadius: ExampleConst.cornerRadius * mult,
                                        shadowOpacity: ExampleConst.shadowOpacity * 2,
                                        shadowRadius: ExampleConst.shadowRadius,
                                        shadowOffset: ExampleConst.shadowOffset)
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return FluidFinalFrameStyle(cornerRadius: ExampleConst.cornerRadius * 0,
                                        shadowOpacity: ExampleConst.shadowOpacity * 2,
                                        shadowRadius: ExampleConst.shadowRadius,
                                        shadowOffset: ExampleConst.shadowOffset)
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return FluidFinalFrameStyle(cornerRadius: ExampleConst.cornerRadius * mult,
                                        shadowOpacity: ExampleConst.shadowOpacity * 2,
                                        shadowRadius: ExampleConst.shadowRadius,
                                        shadowOffset: ExampleConst.shadowOffset)
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return FluidFinalFrameStyle(cornerRadius: ExampleConst.cornerRadius * 0,
                                        shadowOpacity: ExampleConst.shadowOpacity * 0,
                                        shadowRadius: ExampleConst.shadowRadius,
                                        shadowOffset: ExampleConst.shadowOffset)
        }
    }

    var presentEasing: FluidAnimatorEasing? {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return nil
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return nil
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return nil
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return nil
        }
    }

    var dismissEasing: FluidAnimatorEasing? {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return nil
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return nil
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return nil
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return nil
        }
    }

    var presentDuration: TimeInterval? {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return nil
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return nil
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return nil
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return nil
        }
    }

    var dismissDuration: TimeInterval? {
        switch self {
        case .navigationFluidModal, .transitionFluidModal:
            return nil
        case .navigationFluidFullScreen, .transitionFluidFullScreen:
            return nil
        case .navigationDrawerTop, .navigationDrawerBottom, .navigationDrawerLeft, .navigationDrawerRight,
             .transitionDrawerTop, .transitionDrawerBottom, .transitionDrawerLeft, .transitionDrawerRight:
            return nil
        case .navigationSlideTop, .navigationSlideBottom, .navigationSlideLeft, .navigationSlideRight,
             .transitionSlideTop, .transitionSlideBottom, .transitionSlideLeft, .transitionSlideRight:
            return nil
        }
    }
}

extension RootModel {
    var headerPosition: RootHeaderPosition {
        switch self {
        case .navigationFluidModal:      return .bottom
        case .navigationFluidFullScreen: return .top

        case .navigationDrawerTop:       return .bottom
        case .navigationDrawerBottom:    return .bottom
        case .navigationDrawerLeft:      return .top
        case .navigationDrawerRight:     return .top

        case .navigationSlideTop:        return .bottom
        case .navigationSlideBottom:     return .top
        case .navigationSlideLeft:       return .top
        case .navigationSlideRight:      return .bottom

        case .transitionFluidModal:      return .top
        case .transitionFluidFullScreen: return .top

        case .transitionDrawerTop:       return .bottom
        case .transitionDrawerBottom:    return .bottom
        case .transitionDrawerLeft:      return .top
        case .transitionDrawerRight:     return .top

        case .transitionSlideTop:        return .bottom
        case .transitionSlideBottom:     return .top
        case .transitionSlideLeft:       return .top
        case .transitionSlideRight:      return .bottom
        }
    }

    var title: String {
        switch self.transitionStyle {
        case .fluid(_):
            return "Fluid"
        case .scale:
            return "Scale"
        case .drawer(let position):
            return "Drawer " + position.description.capitalized
        case .slide(let direction):
            return "Slide " + direction.description.replacingOccurrences(of: "from", with: "")
        }
    }

    var caption: String {
        let presentationString: String = self.presentationType.description.capitalized
        let backgroundString: String = self.backgroundStyle.description.replacingOccurrences(of: "(\\w+)\\(.*", with: "$1", options: .regularExpression).capitalized
        let styleString: String = self.finalFrameStyle?.cornerRadius ?? 0 > 0 ? "Rounded Corner" : "None"
        return "\(presentationString) / \(backgroundString) / \(styleString)"
    }

    var description: String {
        switch self {
        case .navigationFluidModal:      return "navigationFluidModal"
        case .navigationFluidFullScreen: return "navigationFluidFullScreen"

        case .navigationDrawerTop:       return "navigationDrawerTop"
        case .navigationDrawerBottom:    return "navigationDrawerBottom"
        case .navigationDrawerLeft:      return "navigationDrawerLeft"
        case .navigationDrawerRight:     return "navigationDrawerRight"

        case .navigationSlideTop:        return "navigationSlideTop"
        case .navigationSlideBottom:     return "navigationSlideBottom"
        case .navigationSlideLeft:       return "navigationSlideLeft"
        case .navigationSlideRight:      return "navigationSlideRight"

        case .transitionFluidModal:      return "transitionFluidModal"
        case .transitionFluidFullScreen: return "transitionFluidFullScreen"

        case .transitionDrawerTop:       return "transitionDrawerTop"
        case .transitionDrawerBottom:    return "transitionDrawerBottom"
        case .transitionDrawerLeft:      return "transitionDrawerLeft"
        case .transitionDrawerRight:     return "transitionDrawerRight"
        case .transitionSlideTop:        return "transitionSlideTop"
        case .transitionSlideBottom:     return "transitionSlideBottom"
        case .transitionSlideLeft:       return "transitionSlideLeft"
        case .transitionSlideRight:      return "transitionSlideRight"
        }
    }
}

extension RootModel {
    static func testCases(for orientation: UIDeviceOrientation) -> [RootModel] {
        switch orientation.isPortrait {
        case true:
            return [
                .navigationFluidModal,
                .navigationFluidFullScreen,

                .navigationDrawerTop,
                .navigationDrawerBottom,
                .navigationDrawerLeft,
                .navigationDrawerRight,

                .navigationSlideTop,
                .navigationSlideBottom,
                .navigationSlideLeft,
                .navigationSlideRight,

                .transitionFluidModal,
                .transitionFluidFullScreen,

                .transitionDrawerTop,
                .transitionDrawerBottom,
                .transitionDrawerLeft,
                .transitionDrawerRight,

                .transitionSlideTop,
                .transitionSlideBottom,
                .transitionSlideLeft,
                .transitionSlideRight,
            ]
        case false:
            return [
//                .navigationFluidModal,
//                .navigationFluidFullScreen,
//
//                .navigationDrawerTop,
//                .navigationDrawerBottom,
//                .navigationDrawerLeft,
//                .navigationDrawerRight,
//
//                .navigationSlideTop,
//                .navigationSlideBottom,
//                .navigationSlideLeft,
//                .navigationSlideRight,
//
//                .transitionFluidModal,
//                .transitionFluidFullScreen,
//
//                .transitionDrawerTop,
//                .transitionDrawerBottom,
//                .transitionDrawerLeft,
//                .transitionDrawerRight,
//
//                .transitionSlideTop,
//                .transitionSlideBottom,
//                .transitionSlideLeft,
//                .transitionSlideRight,
            ]
        }
    }

    var rootCellAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_CollectionCell"
    }

    var navigationCloseButtonAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_NavigationCloseButton"
    }

    var overlayCloseButtonAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_OverlayCloseButton"
    }

    var visibleControllerViewAccessibilityIdentifier: String {
        return "VisibleControllerView"
    }

    var parentScrollViewAccessibilityIdentifier: String {
        return "ParentScrollView"
    }

    var parentScrollTopViewAccessibilityIdentifier: String {
        return "ScrollTopView"
    }

    var parentScrollBottomViewAccessibilityIdentifier: String {
        return "ScrollBottomView"
    }

    var parentTableViewAccessibilityIdentifier: String {
        return "ParentTableView"
    }

    var parentCollectionViewAccessibilityIdentifier: String {
        return "ParentCollectionView"
    }

    var childFirstCollectionViewAccessibilityIdentifier: String {
        return "ChildFirstCollectionView"
    }

    var childSecondCollectionViewAccessibilityIdentifier: String {
        return "ChildSecondCollectionView"
    }

    var childThirdCollectionViewAccessibilityIdentifier: String {
        return "ChildThirdCollectionView"
    }

    var childForthCollectionViewAccessibilityIdentifier: String {
        return "ChildForthCollectionView"
    }

    var childFifthCollectionViewAccessibilityIdentifier: String {
        return "ChildFifthCollectionView"
    }
}

enum RootPresentationType: CustomStringConvertible {
    case navigation, transition
    var description: String {
        switch self {
        case .navigation: return "navigation"
        case .transition: return "transition"
        }
    }
}

enum RootCellType {
    case image, imageText, table

    var size: CGSize {
        let numberOfColumns: CGFloat = CGFloat(ExampleConst.collectionNumberOfColumns)
        let width: CGFloat = {
            let screenWidth: CGFloat = UIApplication.shared.keyWindow!.bounds.width
            let contentWidth = screenWidth - ExampleConst.collectionLeftMargin + ExampleConst.collectionRightMargin
            return (contentWidth - ExampleConst.collectionLeftMargin * (numberOfColumns + 1)) / numberOfColumns
        }()
        switch self {
        case .image:
            return CGSize(width: width, height: width)
        case .imageText:
            return CGSize(width: width, height: width * 1.2)
        case .table:
            let headerHeight: CGFloat = ExampleConst.headerHeight
            let tableHeight: CGFloat = ExampleConst.tableCellHeight * 4 - 1
            let footerHeight: CGFloat = 20
            return CGSize(width: width, height: headerHeight + tableHeight + footerHeight)
        }
    }
}

enum RootHeaderPosition {
    case top, bottom, none
}

protocol RootModelReceivable: class {
    var modelIndex: Int { set get }
    var model: RootModel! { get }
    func configure(modelIndex: Int)
}

extension RootModelReceivable where Self: UIViewController {
    var model: RootModel! { return RootModel(rawValue: self.modelIndex) }
}
