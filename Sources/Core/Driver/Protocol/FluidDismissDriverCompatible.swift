//
//  FluidDismissDriverCompatible.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

@MainActor internal protocol FluidDismissDriverCompatible: FluidDriverCompatible {
    func dismissViewController()
}
