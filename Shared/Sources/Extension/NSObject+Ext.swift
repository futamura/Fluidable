//
//  NSObject+Ext.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

protocol ClassNameIdentifiable: NSObjectProtocol {
    static var className: String { get }
    var className: String { get }
}

extension ClassNameIdentifiable {
    internal static var className: String { return String(describing: self) }
    internal var className: String { return type(of: self).className }
}

extension NSObject: ClassNameIdentifiable {
}
