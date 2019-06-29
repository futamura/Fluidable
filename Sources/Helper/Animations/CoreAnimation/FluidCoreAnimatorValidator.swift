//
//  FluidCoreAnimatorValidator.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import QuartzCore

internal class FluidCoreAnimatorValidator {
    private init() {}

    static func validate(layer: CALayer?, id: String) throws -> CALayer? {
        guard layer != nil else {
            let error: FluidCoreAnimatorError = FluidCoreAnimatorError.layerIsNil(id: id)
            FluidCoreAnimatorLogger.log(error.description, .warn)
            throw error
        }
        return layer
    }

    static func validate(isCompleted: Bool, state: FluidAnimatorState, id: String) throws -> Bool {
        guard !isCompleted else { return true }
        let error: FluidCoreAnimatorError = FluidCoreAnimatorError.alreadyCompleted(id: id, state: state)
        FluidCoreAnimatorLogger.log(error.description, .warn)
        throw error
    }

    static func validate(count: Int, id: String) throws -> Bool {
        guard count > 0 else {
            let error: FluidCoreAnimatorError = FluidCoreAnimatorError.animationsIsEmpty(id: id)
            FluidCoreAnimatorLogger.log(error.description, .warn)
            throw error
        }
        return true
    }

    static func validate<T: FluidCoreAnimatorKeyCompatible>(layer: CALayer?, keyPath: FluidCoreAnimatorPath<T>, from: T?, to: T?, id: String) throws -> (from: T, to: T) {
        guard let layer: CALayer = layer else {
            let error: FluidCoreAnimatorError = FluidCoreAnimatorError.layerIsNil(id: id)
            FluidCoreAnimatorLogger.log(error.description, .warn)
            throw error
        }
        guard let fromValue: T = from ?? layer.value(forKeyPath: keyPath.rawValue) as? T, let toValue: T = to else {
            let error: FluidCoreAnimatorError = FluidCoreAnimatorError.invalidArgument(id: id, key: keyPath.rawValue, from: from, to: to)
            FluidCoreAnimatorLogger.log(error.description, .warn)
            throw error
        }
        return (from: fromValue, to: toValue)
    }
}

internal class FluidCoreAnimatorLogger {
    enum Level {
        case info, warn, error
    }

    static var suppress: Bool = false

    static func log(_ message: String, _ level: Level = .warn) {
        guard !self.suppress else { return }
        #if DEBUG
        let icon: String = {
            switch level {
            case .info:  return "ℹ️"
            case .warn:  return "⚠️"
            case .error: return "❌"
            }
        }()
        print("\(icon) [FluidCoreAnimator]", message)
        #endif
    }
}
