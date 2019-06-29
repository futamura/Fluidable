//
//  FluidTransitionType.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/** The enumerations that indicates the transition type. */
public enum FluidDriverType {
    /** The view is presenting. */
    case present
    /** The view is dismissing. */
    case dismiss
}

extension FluidDriverType {
    public var isPresent: Bool { return self == .present }
    public var isDismiss: Bool { return self == .dismiss }
}

extension FluidDriverType: CustomStringConvertible {
    /** The description. */
    public var description: String {
        switch self {
        case .present: return "present"
        case .dismiss: return "dismiss"
        }
    }
}