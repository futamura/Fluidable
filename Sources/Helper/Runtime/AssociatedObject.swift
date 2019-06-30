//
//  AssociatedObject.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal struct AssociatedObject {
    enum Policy {
        case retain, retain_nonatomic
        case assign
        case copy, copy_nonatomic

        var value: objc_AssociationPolicy {
            switch self {
            case .retain:           return .OBJC_ASSOCIATION_RETAIN
            case .retain_nonatomic: return .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            case .assign:           return .OBJC_ASSOCIATION_ASSIGN
            case .copy:             return .OBJC_ASSOCIATION_COPY
            case .copy_nonatomic:   return .OBJC_ASSOCIATION_COPY_NONATOMIC
            }
        }
    }

    static func get<T>(_ object: Any, _ key: UnsafeRawPointer) -> T? {
        return objc_getAssociatedObject(object, key) as? T
    }

    static func set<T>(_ object: Any, _ key: UnsafeRawPointer, _ value: T, _ policy: Policy) {
        objc_setAssociatedObject(object, key, value, policy.value)
    }

    static func remove(_ object: Any) {
        objc_removeAssociatedObjects(object)
    }
}
