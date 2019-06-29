//
//  FluidDismissDriverCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal protocol FluidDismissDriverCompatible: FluidDriverCompatible {
    func dismissViewController()
}