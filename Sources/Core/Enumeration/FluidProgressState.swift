//
//  FluidProgressState.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

public enum FluidProgressState {
    /** The transition begins. */
    case begin
    /** The transition updates. */
    case update
    /** The transition cancelled. */
    case cancel
    /** The transition ended. */
    case end
}

extension FluidProgressState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .begin:  return "begin"
        case .update: return "update"
        case .cancel: return "cancel"
        case .end:    return "end"
        }
    }
}
