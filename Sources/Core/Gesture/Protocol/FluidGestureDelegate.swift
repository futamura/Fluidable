//
//  FluidGestureDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The delegate for receiving gesture actions.
 */
internal protocol FluidGestureDelegate: NSObjectProtocol {
    func tapGestureDidUpdate(gesture: UITapGestureRecognizer)
    func panGestureDidUpdate(gesture: UIPanGestureRecognizer)
    func edgePanGestureDidUpdate(gesture: UIScreenEdgePanGestureRecognizer)
}

extension FluidGestureDelegate {
    func edgePanGestureDidUpdate(gesture: UIScreenEdgePanGestureRecognizer) {}
}
