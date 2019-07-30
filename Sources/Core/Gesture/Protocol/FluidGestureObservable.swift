//
//  FluidGestureObservable.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

protocol FluidGestureObservable: FluidParametersAccessible, UIGestureRecognizerDelegate {
    var maxTranslationCount: Int { get }

    /** The `FluidGestureDelegate` object. */
    var gestureDelegate: FluidGestureDelegate? { get set }

    /** The base frame when the view is placed in the default position. */
    var baseFrame: CGRect { get set }
    /** The base location value at the start of gesture. */
    var initialLocation: CGPoint? { get set }
    /** The current location value of the gesture. */
    var currentLocation: CGPoint? { get set }
    /** The previous location value of the gesture. */
    var previousLocation: CGPoint? { get set }
    /** The average translation value of the gesture. */
    var averageLocation: CGPoint { get }
    /** The translation history of the gesture. */
    var locationHistory: [CGPoint] { get set }
    /** The initial translation value of the gesture. */
    var initialTranslation: CGPoint? { get set }
    /** The current translation value of the gesture. */
    var currentTranslation: CGPoint? { get set }
    /** The previous translation value of the gesture. */
    var previousTranslation: CGPoint? { get set }
    /** The average translation value of the gesture. */
    var averageTranslation: CGPoint { get }
    /** The translation history of the gesture. */
    var translationHistory: [CGPoint] { get set }
    /** The current velocity value of the gesture. */
    var currentVelocity: CGVector? { get set }

    /** The initial translation direction. */
    var currentTranslationDirection: FluidGestureDirection { get }
    /** The initial gesture direction. */
    var initialGestureDirection: FluidGestureDirection { get }
    /** The current gesture direction. */
    var currentGestureDirection: FluidGestureDirection { get }
    /** The average gesture direction. */
    var averageGestureDirection: FluidGestureDirection { get }
    /** The current gesture state. */
    var gestureState: UIGestureRecognizer.State? { get set }

    /** Tap gesture */
    var tapGestureView: UIView? { get set }
    var tapGestureRecognizer: UITapGestureRecognizer? { get set }
    /** Pan gesture */
    var panGestureView: UIView? { get set }
    var panGestureRecognizer: UIGestureRecognizer! { get set }
    /** Edge pan gesture */
    var edgePanGestureView: UIView? { get set }
    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer? { get set }

    /** The function that instantiates objects. */
    init(delegate: FluidGestureDelegate)

    /** The function that start observing gestures. */
    func startObserving()
    /** The function that stop observing gestures. */
    func stopObserving()
    /** The function that abort observing gestures. */
    func abortGesture()

    /** The function that returns gesture information. */
    func currentGestureInfo() -> FluidGestureInfo
    /** The function that updates current parameters. */
    func updateCurrentParameters(gesture: UIGestureRecognizer)
    /** The function that updates previous parameters. */
    func updatePreviousParameters()
    /** The function that snapshots parameters. */
    func snapshotBaseParameters()
    /** The function that resets parameters.  */
    func resetParameters()

    /** The function that handles a tap gesture.  */
    func tapGestureHandler(gesture: UITapGestureRecognizer)
    /** The function that handles a pan gesture.  */
    func panGestureHandler(gesture: UIPanGestureRecognizer)
    /** The function that handles an edge pan gesture. */
    func edgePanGestureHandler(gesture: UIScreenEdgePanGestureRecognizer)
}

extension FluidGestureObservable {
    var maxTranslationCount: Int { return 3 }
}

extension FluidGestureObservable {
    /** The function that returns gesture information. */
    func currentGestureInfo() -> FluidGestureInfo {
        guard let window: UIWindow = UIApplication.shared.keyWindow,
              let currentLocation: CGPoint = self.currentLocation,
              let currentTranslation: CGPoint = self.currentTranslation,
              let currentVelocity: CGVector = self.currentVelocity else { return .init() }
        return FluidGestureInfo(locationLocal: currentLocation,
                                locationGlobal: window.convert(currentLocation, from: self.transitionContainerView),
                                translation: currentTranslation,
                                velocity: currentVelocity,
                                direction: self.averageGestureDirection)
    }
}

extension FluidGestureObservable {
    func updateCurrentParameters(gesture: UIGestureRecognizer) {
        /* NOTE: Update location */
        self.currentLocation = gesture.location(in: self.transitionContainerView)
        if self.initialLocation == nil { self.initialLocation = self.currentLocation }
        self.locationHistory.insert(self.currentLocation!, at: 0)
        if self.locationHistory.count > self.maxTranslationCount { self.locationHistory.removeLast() }
        /* NOTE: Update translation */
        if let panGesture: UIPanGestureRecognizer = gesture as? UIPanGestureRecognizer {
            self.currentTranslation = panGesture.translation(in: self.transitionContainerView)
            self.currentVelocity = CGVector(point: panGesture.velocity(in: self.transitionContainerView))
            if self.initialTranslation == nil { self.initialTranslation = self.currentTranslation }
            self.translationHistory.insert(self.currentTranslation!, at: 0)
            if self.translationHistory.count > self.maxTranslationCount { self.translationHistory.removeLast() }
        }
        self.gestureState = gesture.state
    }

    func updatePreviousParameters() {
        self.previousTranslation = self.currentTranslation
        self.previousLocation = self.currentLocation
    }

    func snapshotBaseParameters() {
        guard let currentFrame: CGRect = self.panGestureView?.frame,
              let currentLocation: CGPoint = self.currentLocation else {
            self.initialLocation = nil
            return
        }
        let diffFrame: CGRect = self.baseFrame - currentFrame
        if let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition {
            switch drawerPosition {
            case .top:    self.initialLocation = currentLocation - CGPoint(x: 0, y: diffFrame.height)
            case .bottom: self.initialLocation = currentLocation + diffFrame.origin
            case .left:   self.initialLocation = currentLocation - CGPoint(x: diffFrame.width, y: 0)
            case .right:  self.initialLocation = currentLocation + diffFrame.origin
            }
        } else {
            self.initialLocation = currentLocation + diffFrame.origin
        }
    }

    func resetParameters() {
        self.initialLocation = nil
        self.currentLocation = nil
        self.previousLocation = nil
        self.locationHistory = [CGPoint]()
        self.initialTranslation = nil
        self.currentTranslation = nil
        self.previousTranslation = nil
        self.currentVelocity = nil
        self.translationHistory = [CGPoint]()
        self.gestureState = .none
    }
}

/**
 Manage gesture
 */
extension FluidGestureObservable {
    /**
     The function that abort gestures.
     */
    func abortGesture() {
        Logger()?.log("💘⏩", [])
        let defaultIsPanGestureEnabled: Bool = self.panGestureRecognizer.isEnabled
        let defaultIsEdgePanGestureEnabled: Bool = self.edgePanGestureRecognizer?.isEnabled ?? false
        self.panGestureRecognizer.isEnabled = false
        self.edgePanGestureRecognizer?.isEnabled = false
        self.panGestureRecognizer.isEnabled = defaultIsPanGestureEnabled
        self.edgePanGestureRecognizer?.isEnabled = defaultIsEdgePanGestureEnabled
    }
}

extension FluidGestureObservable {
    func handleGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location: CGPoint = touch.location(in: self.transitionContainerView)
        let isTouchingDestination: Bool = {
            if let layer: CALayer = self.layoutContainerView.layer.presentation() {
                return layer.frame.contains(location)
            } else {
                return self.layoutContainerView.frame.bounds.contains(location)
            }
        }()
        switch gestureRecognizer {
        case is UITapGestureRecognizer where !isTouchingDestination,
             is UIPanGestureRecognizer where isTouchingDestination,
             is UIScreenEdgePanGestureRecognizer where isTouchingDestination: return true
        default: return false
        }
    }

    func handleGestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let location: CGPoint = gestureRecognizer.location(in: self.transitionContainerView)
        let isTouchingDestination: Bool = {
            if let layer: CALayer = self.layoutContainerView.layer.presentation() {
                return layer.frame.contains(location)
            } else {
                return self.layoutContainerView.frame.bounds.contains(location)
            }
        }()
        switch gestureRecognizer {
        case is UITapGestureRecognizer where !isTouchingDestination,
             is UIPanGestureRecognizer where isTouchingDestination,
             is UIScreenEdgePanGestureRecognizer where isTouchingDestination: return true
        default: return false
        }
    }

    func handleGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch gestureRecognizer {
        case is UIPanGestureRecognizer where otherGestureRecognizer is UIScreenEdgePanGestureRecognizer: return true
        default: return false
        }
    }

    func handleGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch gestureRecognizer {
        case is UIScreenEdgePanGestureRecognizer where otherGestureRecognizer is UIPanGestureRecognizer: return true
        default: return false
        }
    }

    func handleGestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        switch gestureRecognizer {
        case is UIScreenEdgePanGestureRecognizer where otherGestureRecognizer is UIPanGestureRecognizer: return false
        default: return true
        }
    }
}

extension FluidGestureObservable {
    func handleTapGesture(gesture: UITapGestureRecognizer) {
        /* NOTE: Set current value */
        self.updateCurrentParameters(gesture: gesture)
        /* NOTE: Invoke tap gesture */
        self.gestureDelegate?.tapGestureDidUpdate(gesture: gesture)
    }

    /** The function that handles a pan gesture.  */
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        /* NOTE: Set current value */
        self.updateCurrentParameters(gesture: gesture)
        /* NOTE: Invoke pan gesture */
        self.gestureDelegate?.panGestureDidUpdate(gesture: gesture)
        /* NOTE: Reset parameters */
        switch gesture.state {
        case .began, .changed: break
        case .possible, .ended, .failed, .cancelled: self.resetParameters()
        }
        /* NOTE: Set previous value */
        self.updatePreviousParameters()
    }

    /** The function that handles an edge pan gesture. */
    func handleEdgePanGesture(gesture: UIScreenEdgePanGestureRecognizer) {
        /* NOTE: Set current value */
        self.updateCurrentParameters(gesture: gesture)
        /* NOTE: Invoke pan gesture */
        self.gestureDelegate?.edgePanGestureDidUpdate(gesture: gesture)
        /* NOTE: Reset parameters */
        switch gesture.state {
        case .began, .changed: break
        case .possible, .ended, .failed, .cancelled: self.resetParameters()
        }
        /* NOTE: Set previous value */
        self.updatePreviousParameters()
    }
}
