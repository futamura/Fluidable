//
//  FluidViewAnimatorCompatible.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** Obj-C association key */
private struct AssociationKey {
    static let parameters: UnsafeMutablePointer<UInt> = UnsafeMutablePointer<UInt>.allocate(capacity: 1)
}

/**
 The protocol that compatibles to transition animator.
 */
internal protocol FluidViewAnimatorCompatible: FluidParametersAccessible {
    /** The duration of the current animation. */
    var activeDuration: TimeInterval { get }
    /** The easing type of the current animation. */
    var activeEasing: FluidAnimatorEasing { get }

    /** The `CGFloat` value that indicates the current transition progress. */
    var animationProgress: CGFloat { get }
    var pausedAnimationProgress: CGFloat { get set }

    /** Variables for interaction */
    var interactionProgress: CGFloat { get set }
    var pausedInteractionProgress: CGFloat { get set }
    var resizePosition: CGFloat { get set }
    var pausedGestureInfo: FluidGestureInfo? { get set }
    var currentGestureInfo: FluidGestureInfo? { get set }

    /** The `FluidAnimatorState` value that indicates the current animation state. */
    var state: FluidAnimatorState { get }

    /** The `Bool` value that indicates whether the animation is not running. */
    var isNotRunning: Bool { get }

    /** The frame and style variables to reduce computational load */
    var storedFromFrame: CGRect! { get set }
    var storedToFrame: CGRect! { get set }
    var storedFromStyle: FluidFrameStyleCompatible! { get set }
    var storedToStyle: FluidFrameStyleCompatible! { get set }

    /** Base layout constants for resizing */
    var baseConstants: FluidLayoutEdgeConstant! { get set }

    /* The display timer for fluid interaction. */
    var animationTimer: FluidViewAnimatorTimer? { get set }

    /**
     The function that gets called before the transition starts. You need to configure animators conforming to the `FluidAnimatorCompatible` protocol in this function.
     */
    func animationWillStart(isReversed: Bool) -> [FluidAnimatorCompatible]?

    /**
     The function that gets called when the animation did start.
     */
    func animationDidStart()

    /**
     The function that gets called when the animation updates.

     - parameter progress: The `CGFloat` value that indicates the animation progress.
     */
    func animationDidUpdate(progress: CGFloat)

    /**
     The function that gets called when the animation is finished.

     - parameter isCancelled: The `Bool` value that indicates whether the transition is cancelled.
     */
    func animationDidFinish(isCancelled: Bool)

    /**
     The function that gets called after all animators are invalidated. You need to remove the views you added in this function.

     - parameter willRemoveContainer: The `Bool` value that indicates whether the dismiss transition is finished and the container view will be removed.<br/>
                                       - When a present transition is finished and reached to its ending, the value will set to `false`.<br/>
                                       - When a present transition is cancelled and reached to its beginning, the value will set to `true`.<br/>
                                       - When a dismiss transition is finished and reached to its ending, the value will set to `true`.<br/>
                                       - When a dismiss transition is cancelled and reached to its beginning, the value will set to `false`.
     */
    func animationWillInvalidate(willRemoveContainer: Bool)

    /**
     The function that gets called when the interactive transition is started.

     - parameter progress: The `CGFloat` value that indicates the interaction progress.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` value that contains the gesture information.
     */
    func interactionDidStart(progress: CGFloat, position: CGFloat, info: FluidGestureInfo)

    /**
     The function that gets called when the interactive transition is updated.

     - parameter progress: The `CGFloat` value that indicates the interaction progress.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` value that contains the gesture information.
     */
    func interactionDidUpdate(progress: CGFloat, position: CGFloat, info: FluidGestureInfo)

    /**
     The function that gets called when the interactive transition is finished.

     - parameter isReversed: The `Bool` value that indicates whether the interactive transition is cancelled and reversing.
     - parameter progress: The `CGFloat` value that indicates the interaction progress.
     - parameter position: The progress value of the resizing position.
     - parameter info: The `FluidGestureInfo` value that contains the gesture information.
     */
    func interactionDidFinish(isReversed: Bool, progress: CGFloat, position: CGFloat, info: FluidGestureInfo)
}

extension FluidViewAnimatorCompatible {
    internal var parameters: Parameters! {
        get { return AssociatedObject.get(self, AssociationKey.parameters) }
        set { AssociatedObject.set(self, AssociationKey.parameters, newValue, .copy_nonatomic) }
    }

    public var activeDuration: TimeInterval { return self.parameters.activeDuration }
    public var activeEasing: FluidAnimatorEasing { return self.parameters.activeEasing }

    public var animationProgress: CGFloat { return CGFloat(self.progressAnimator?.layer?.presentation()?.opacity ?? 0) }
    public var state: FluidAnimatorState { return self.progressAnimator?.animatorState ?? .ready }
    public var isNotRunning: Bool { return self.progressAnimator?.isCompleted ?? false || self.progressAnimator?.isReady ?? false }
}
