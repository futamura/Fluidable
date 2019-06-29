//
//  UIViewAnimating+Extension.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/**
 The alias for `UIViewAnimatingState`. The `UIViewAnimatingState` sometimes returns the wrong value (rawValue = 5) under the specific condition. This enumeration is the workaround for its bug.
 <h4>Available Types</h4>
 `inactive`, `active`, `stopped`, `none`
 */
public enum UIViewAnimatingStateEx: Int, CustomStringConvertible, Equatable {
    case inactive, active, stopped, none

    /**
     The function that convert the `UIViewAnimatingStateEx` value to `UIViewAnimatingStateEx`.

     - parameter state: The `UIViewAnimatingState` value.
     - returns: The `UIViewAnimatingStateEx` value.
     */
    public static func convert(from state: UIViewAnimatingState) -> UIViewAnimatingStateEx {
        switch state.rawValue {
        case 0:  return .inactive
        case 1:  return .active
        case 2:  return .stopped
        default: return .none
        }
    }

    /** The description. */
    public var description: String {
        switch self {
        case .inactive: return "inactive"
        case .active:   return "active"
        case .stopped:  return "stopped"
        case .none:     return "none"
        }
    }

    /** The function that conforms to `Equatable`. */
    public static func == (lhs: UIViewAnimatingStateEx, rhs: UIViewAnimatingStateEx) -> Bool {
        return lhs.description == rhs.description
    }
}

extension UIViewAnimating {
    /** The `UIViewAnimatingStateEx` value that avoids crash cased by `UIViewAnimatingState` bug. */
    var stateEx: UIViewAnimatingStateEx { return UIViewAnimatingStateEx.convert(from: self.state) }

    /** The `Bool` value that indicates whether the animation is not running. */
    var isNotRunning: Bool {
        return !self.isRunning || self.stateEx == .inactive || self.stateEx == .none
    }

    func invalidate() {}
}
