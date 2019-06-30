//
//  FluidConst.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal struct FluidConst {
    /* For debugging */
    static var isNewerSystemVersion: Bool { if #available(iOS 11, *) { return true } else { return false } }

    /** Tag */
    static let interruptibleViewTag: Int = 77
    static let progressViewTag: Int = 78
    static let shadowViewTag: Int = 79
    static let backgroundViewTag: Int = 80

    /** Constraint identifier */
    static let constraintIdentifierPrefix: String = "Fluid-"

    /** Default duration [Human processor model](https://en.wikipedia.org/wiki/Human_processor_model) */
    static let defaultPresentDuration: TimeInterval = 0.34
    static let defaultDismissDuration: TimeInterval = 0.24

    /** Background animation */
    static let fluidInteractionReverseDuration: TimeInterval = 0.24

    /** Dismiss interaction (normal and fluid) */
    static let dismissVelocityBeginThreshold: CGFloat = 10
    static let dismissTranslationBeginThreshold: CGFloat = 10000
    static let dismissVelocityFinishThreshold: CGFloat = 1000
    /** Normal interaction */
    static let normalProgressFinishThreshold: CGFloat = 0.33
    /** Fluid interaction */
    static let fluidProgressFinishThreshold: CGFloat = 0.33
    static let fluidProgressReverseThreshold: CGFloat = 0.66
    /** Resize interaction */
    static let resizeVelocityBeginThreshold: CGFloat = 10
    static let forbidResizingConstantRange: CGFloat = 96

    /** Spring parameter for transition */
    static let springDampingRatio: CGFloat = 0.70
    static let springFrequencyResponse: CGFloat = 0.50
}
