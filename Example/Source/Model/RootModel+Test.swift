//
//  RootModel+Test.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/11.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

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
            ]
        case false:
            return [
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
        }
    }

    var rootCellAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_CollectionCell"
    }

    var navigationBarAccessibilityIdentifier: String {
        return "NavigationBar"
    }

    var navigationCloseButtonAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_NavigationCloseButton"
    }

    var overlayCloseButtonAccessibilityIdentifier: String {
        return self.description.capitalizingFirstLetter() + "_OverlayCloseButton"
    }

    var rootNextButtonAccessibilityIdentifier: String {
        return "RootNextButton"
    }

    var childNextButtonAccessibilityIdentifier: String {
        return "ChildNextButton"
    }

    var navigationContainerViewAccessibilityIdentifier: String {
        return "NavigationContainerView"
    }

    var transitionContainerViewAccessibilityIdentifier: String {
        return "TransitionContainerView"
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
