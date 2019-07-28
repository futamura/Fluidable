//
//  FluidResizableDelegate.swift
//  Fluidable
//
//  Created by kojirof on 2019/07/28.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 The `FluidResizableDelegate` protocol. The delegates will be invoked if you only specify the presentation style to .drawer(position: top) or  .drawer(position: bottom)
 */
public protocol FluidResizableTransitionDelegate: NSObjectProtocol {
    /**
     The function that determines whether the view should perform resize interaction.

     - returns: The `Bool` value.
     */
    func transitionShouldPerformResizing() -> Bool

    /**
     The function that determines minimum vertical margin for resizing.

     - returns: The `Bool` value.
     */
    func transitionMinimumMarginForResizing() -> CGFloat

    /**
     The function that determines the positions that the panning view should be snapped to after interaction end.

     - returns: The `Array` object containing `CGFloat` values. The range of values should be 1.0 to 0.0. If it contains out-of-range or duplicate values, those values are ignored.
     */
    func transitionSnapPositionsForResizing() -> [CGFloat]?

    /**
     The function that is invoked when an interactive resize transition updates.

     - parameter state: The `FluidInteractiveTransitionState` value indicating the current state of the resizing interaction.
     - parameter position: The `CGFloat` value indicating the percentage of the current position. The range of values is 1.0 to 0.0.
     - parameter info: The `FluidGestureInfo` object that contains the gesture information.
     */
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo)
}

extension FluidResizableTransitionDelegate {
    func transitionShouldPerformResizing() -> Bool { return true }
    func transitionMinimumMarginForResizing() -> CGFloat { return 64 }
    func transitionSnapPositionsForResizing() -> [CGFloat]? { return nil }
    func transitionInteractiveResizeDidProgress(state: FluidProgressState, position: CGFloat, info: FluidGestureInfo) {}
}
