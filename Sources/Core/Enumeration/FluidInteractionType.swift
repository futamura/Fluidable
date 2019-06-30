//
//  FluidTransitionInteractionType.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

public enum FluidDriverInteractionType {
    case normal(edges: UIRectEdge)
    case fluid(edges: UIRectEdge)
    case none

    static var normal: FluidDriverInteractionType { return .normal(edges: []) }
    static var fluid: FluidDriverInteractionType { return .fluid(edges: []) }

    init(for presentationStyle: FluidPresentationStyle, with animationType: FluidAnimationType) {
        let edges: UIRectEdge = {
            switch presentationStyle {
            case .fluid: return .left
            case .scale: return .left
            case .slide(let direction):
                switch direction {
                case .fromTop:    return .bottom
                case .fromBottom: return .top
                case .fromLeft:   return .right
                case .fromRight:  return .left
                }
            case .drawer:
                return []
            }
        }()
        switch animationType {
        case .present:
            switch presentationStyle {
            case .fluid: self = .fluid(edges: edges)
            case .scale, .slide, .drawer: self = .normal(edges: edges)
            }
        case .dismiss, .rotate:
            switch presentationStyle {
            case .fluid: self = .fluid(edges: edges)
            case .scale, .slide, .drawer: self = .normal(edges: edges)
            }
        }
    }
}

extension FluidDriverInteractionType {
    public var isNormal: Bool {
        return {
            switch self {
            case .normal: return false
            case .fluid:  return true
            case .none:   return false
            }
        }()
    }
    public var isFluid: Bool {
        return {
            switch self {
            case .normal: return false
            case .fluid:  return true
            case .none:   return false
            }
        }()
    }
    public var isNone: Bool {
        return {
            switch self {
            case .normal: return false
            case .fluid:  return false
            case .none:   return true
            }
        }()
    }

    public var edges: UIRectEdge {
        return {
            switch self {
            case .normal(let edges): return edges
            case .fluid(let edges):  return edges
            case .none: return []
            }
        }()
    }
    public var isEdgePanEnabled: Bool {
        return {
            switch self {
            case .normal(let edges): return !edges.isEmpty
            case .fluid(let edges):  return !edges.isEmpty
            case .none: return false
            }
        }()
    }
}

extension FluidDriverInteractionType: CustomStringConvertible {
    public var description: String {
        switch self {
        case .normal: return "normal"
        case .fluid: return "fluid"
        case .none: return "notInteracting"
        }
    }
}

public enum FluidDriverInteractionState {
    case presenting
    case dismissing
    case resizing
    case none
}

extension FluidDriverInteractionState: CustomStringConvertible {
    public var description: String {
        switch self {
        case .presenting: return "presenting"
        case .dismissing: return "dismissing"
        case .resizing: return "resizing"
        case .none: return "none"
        }
    }
}
