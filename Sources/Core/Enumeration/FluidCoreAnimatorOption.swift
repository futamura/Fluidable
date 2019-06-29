//
//  FluidTransitionCoreAnimatorOption.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Option for Core Animation
 */
internal struct FluidCoreAnimatorOption {
    var isRemovedGroup: Bool
    var fillModeGroup: CAMediaTimingFillMode
    var isRemovedChild: Bool
    var fillModeChild: CAMediaTimingFillMode

    init(_ animationType: FluidAnimationType, _ isReversed: Bool = false) {
        switch animationType {
        case .present where !isReversed:
            self.isRemovedGroup = false
            self.fillModeGroup = .both
            self.isRemovedChild = false
            self.fillModeChild = .both
        case .present:
            self.isRemovedGroup = true
            self.fillModeGroup = .removed
            self.isRemovedChild = true
            self.fillModeChild = .removed
        case .dismiss where !isReversed:
            self.isRemovedGroup = false
            self.fillModeGroup = .both
            self.isRemovedChild = false
            self.fillModeChild = .both
        case .dismiss:
            self.isRemovedGroup = true
            self.fillModeGroup = .removed
            self.isRemovedChild = true
            self.fillModeChild = .removed
        case .rotate:
            self.isRemovedGroup = false
            self.fillModeGroup = .both
            self.isRemovedChild = false
            self.fillModeChild = .both
        }
    }
}
