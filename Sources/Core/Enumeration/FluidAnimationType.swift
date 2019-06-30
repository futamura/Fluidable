//
// Created by kojirof on 2019-03-03.
// Copyright (c) 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations that indicates the transition mode of `FluidTransitionAnimator`.
 */
public enum FluidAnimationType {
    /** The view is presenting. */
    case present
    /** The view is dismissing. */
    case dismiss
    /** The view is rotating. */
    case rotate
}

extension FluidAnimationType {
    public var isPresent: Bool { return self == .present }
    public var isDismiss: Bool { return self == .dismiss }
    public var isRotate: Bool { return self == .rotate }
}

extension FluidAnimationType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .present: return "present"
        case .dismiss: return "dismiss"
        case .rotate:  return "rotate"
        }
    }
}
