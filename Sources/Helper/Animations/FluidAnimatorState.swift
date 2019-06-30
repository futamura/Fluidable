//
//  FluidAnimatorState.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The enumerations for `FluidAnimatorState`.
 */
public enum FluidAnimatorState {
    /** The animation is ready and wait for running. */
    case ready
    /** The animation is running. */
    case running
    /** The animation is paused. */
    case paused
    /** The animation is canceled. */
    case cancelled
    /** The animation is failed. */
    case failed
    /** The animation is finished. */
    case finished
}

extension FluidAnimatorState: CustomStringConvertible {
    /** The description. */
    public var description: String {
        switch self {
        case .ready:     return "ready"
        case .running:   return "running"
        case .paused:    return "paused"
        case .cancelled: return "cancelled"
        case .failed:    return "failed"
        case .finished:  return "finished"
        }
    }
}
