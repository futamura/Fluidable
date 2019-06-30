//
//  FluidCoreAnimatorError.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The enumerations for `FluidCoreAnimatorError`.
 */
public enum FluidCoreAnimatorError: Swift.Error {
    /** The error raised if the layer is nil. */
    case layerIsNil(id: String)
    /** The error raised if the animation is already invalidated. */
    case animationsIsEmpty(id: String)
    /** The error raised if the animation is already completed. */
    case alreadyCompleted(id: String, state: FluidAnimatorState)
    /** The error raised if the argument is invalid. */
    case invalidArgument(id: String, key: String, from: Any?, to: Any?)

    /** The description. */
    var description: String {
        switch self {
        case .layerIsNil(let id):
            return "[\(id)] The layer or view is already invalidated. The animation will never be executed."
        case .animationsIsEmpty(let id):
            return "[\(id)] The animation object could not be created. The animation will never be executed."
        case .alreadyCompleted(let id, let state):
            return "[\(id)] The animation (state: \(state)) is already completed."
        case .invalidArgument(let id, let key, let from, let to):
            return "[\(id)] Invalid argument for `from: \(String(describing: from))` or `to: \(String(describing: to))`. The animation (\(key)) will never be executed."
        }
    }
}
