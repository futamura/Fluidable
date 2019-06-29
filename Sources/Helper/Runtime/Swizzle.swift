//
//  Swizzle.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import ObjectiveC

/** Ported from [inamiy/Swizzle](https://github.com/inamiy/Swizzle) */
internal struct Swizzle {
    private static func _swizzleMethod(_ classRef: AnyClass,
                                       from selector1: Selector,
                                       to selector2: Selector,
                                       isClassMethod: Bool) {
        let c: AnyClass
        if isClassMethod {
            guard let c_ = object_getClass(classRef) else { return }
            c = c_
        } else {
            c = classRef
        }

        guard let method1: Method = class_getInstanceMethod(c, selector1),
              let method2: Method = class_getInstanceMethod(c, selector2) else {
            return
        }

        if class_addMethod(c, selector1,
                           method_getImplementation(method2),
                           method_getTypeEncoding(method2)) {
            class_replaceMethod(c, selector2,
                                method_getImplementation(method1),
                                method_getTypeEncoding(method1))
        } else {
            method_exchangeImplementations(method1, method2)
        }
    }

    /** Instance-method swizzling. */
    static func instanceMethod(_ classRef: AnyClass,
                               from selector1: Selector,
                               to selector2: Selector) {
        _swizzleMethod(classRef, from: selector1, to: selector2, isClassMethod: false)
    }

    /** Instance-method swizzling for unsafe raw-string.
        - Note: This is useful for non-`#selector`able methods e.g. `dealloc`, private ObjC methods. */
    static func instanceMethodString(_ classRef: AnyClass,
                                     from selector1: String,
                                     to selector2: String) {
        instanceMethod(classRef, from: Selector(selector1), to: Selector(selector2))
    }

    /** Class-method swizzling. */
    static func classMethod(_ classRef: AnyClass,
                            from selector1: Selector,
                            to selector2: Selector) {
        _swizzleMethod(classRef, from: selector1, to: selector2, isClassMethod: true)
    }

    /** Class-method swizzling for unsafe raw-string. */
    static func swizzleClassMethodString(_ classRef: AnyClass,
                                         from selector1: String,
                                         to selector2: String) {
        classMethod(classRef, from: Selector(selector1), to: Selector(selector2))
    }
}
