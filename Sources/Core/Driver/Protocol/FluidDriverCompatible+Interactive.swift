//
//  FluidDriverCompatible+Interactive.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

/**
 Variable
 */
extension FluidDriverCompatible {
    var interactionType: FluidDriverInteractionType { return self.observingGesture?.interactionType ?? .none }
    var clampedInteractionProgress: CGFloat { return self.currentInteractionProgress?.clamped(0, 1) ?? 0 }
    var clampedResizePosition: CGFloat { return self.shouldPerformResizing ? self.currentResizePosition.clamped(0, CGFloat.greatestFiniteMagnitude) : 0 }
}

/**
 Observing
 */
extension FluidDriverCompatible {
    func startObservingGestures() {
        guard let destinationViewControllerDelegate: FluidTransitionDestinationViewControllerDelegate = self.parameters?.destinationViewControllerDelegate as? FluidTransitionDestinationViewControllerDelegate,
              let sourceViewController: FluidSourceViewController = self.parameters?.sourceViewController,
              let destinationViewController: FluidDestinationViewController = self.parameters?.destinationViewController else { return }
        Logger()?.log("🐮🛠", [
        ])
        /* NOTE: Gesture */
        if self.observingGesture == nil { self.observingGesture = .init(delegate: self) }
        self.observingGesture?.registerParameters(parameters: parameters)
        self.observingGesture?.startObserving()
        /* NOTE: Scroll Views */
        if self.observingScrolls == nil { self.observingScrolls = [ScrollObserver]() }
        let scrollViews = destinationViewControllerDelegate
                                  .transitionObservesScrollViews(from: destinationViewController, to: sourceViewController, with: self.parameters?.rootNavigationController) ?? []
        for view in scrollViews {
            if !(self.observingScrolls?.contains(where: { $0.scrollView === view }) ?? false) {
                self.observingScrolls?.append(ScrollObserver(view: view))
            }
        }
        self.mostTopObservingScroll = {
            guard let observings: [ScrollObserver] = self.observingScrolls else { return nil }
            if observings.count == 0 { return nil } else if observings.count == 1 { return observings.first }
            let observingViews: [UIScrollView] = observings.filter { $0.scrollView != nil }.map { $0.scrollView! }
            let mostTopIndex: Int = UIView.mostTopView(observingViews).index
            for (i, elm): (Int, ScrollObserver) in observings.enumerated() { elm.isMostTop = i == mostTopIndex }
            return observings[safe: mostTopIndex]
        }()
        self.observingScrolls?.forEach {
            $0.registerParameters(parameters: parameters)
            $0.startObserving()
        }
    }

    func stopObservingGestures() {
        Logger()?.log("🐮🛠", [
        ])
        /* NOTE: Gesture */
        self.observingGesture?.stopObserving()
        self.observingGesture = nil
        /* NOTE: Scroll Views */
        self.observingScrolls?.forEach { $0.stopObserving() }
        self.observingScrolls?.removeAll()
        self.observingScrolls = nil
        self.mostTopObservingScroll = nil
    }
}

/**
 Gestures
 */
extension FluidDriverCompatible {
    func abortGesture() { self.observingGesture?.abortGesture() }
}

/**
 Scrolls
 */
extension FluidDriverCompatible {
    func updateScrolls(progress: CGFloat, position: CGFloat, state: FluidDriverInteractionState) { self.observingScrolls?.forEach { $0.updateScroll(progress: progress, position: position, state: state) } }
    func lockScrolls() { self.observingScrolls?.forEach { $0.lockScroll() } }
    func unlockScroll() { self.observingScrolls?.forEach { $0.unlockScroll() } }
    func abortScrolls() { self.observingScrolls?.forEach { $0.abortScroll() } }

    func disableScrollsInteraction() { self.observingScrolls?.forEach { $0.disableInteraction() } }
    func enableScrollsInteraction() { self.observingScrolls?.forEach { $0.enableInteraction() } }
}

/**
 Shared - Parameters
 */
extension FluidDriverCompatible {
    func updateInteractionState() {
        guard let currentInteractionProgress: CGFloat = self.currentInteractionProgress else {
            self.interactionState = .none
            return
        }
        if 0 < currentInteractionProgress {
            self.interactionState = .dismissing
        } else if self.shouldPerformResizing && 0 < currentResizePosition && currentResizePosition < 1 {
            self.interactionState = .resizing
        } else {
            self.interactionState = .none
        }
    }

    func resetInteractionState() {
        Logger()?.log("🐮🛠", [
            "resetInteractionState:".lpad() + String(debug: self.isInteractionCancelled)
        ])
        self.isInteracting = false
        self.isInteractionCancelled = false
        self.interactionState = .none
        self.pausedInterruptibleFractionComplete = 0

        self.currentInteractionProgress = nil
        self.previousInteractionProgress = nil

        self.currentResizePosition = self.snapPositionsForResizing.nearest(to: self.currentResizePosition)?.element ?? 0
        self.previousResizePosition = nil

        self.observingGesture?.resetParameters()
    }
}

extension FluidDriverCompatible {
    /** A function that calculates a interaction progress.  */
    func calculateInteractionProgress() -> CGFloat {
        guard let baseLocation: CGPoint = self.observingGesture?.initialLocation,
              let currentLocation: CGPoint = self.observingGesture?.currentLocation else { return 0 }
        let pausedProgress: CGFloat = self.pausedInterruptibleFractionComplete
        let finalFrame: CGRect = self.finalDimension.frame()
        guard let value: (diff: CGFloat, length: CGFloat) = {
            switch presentationStyle.dismissAxis() {
            case .positiveX: return (baseLocation.x - currentLocation.x, finalFrame.width)
            case .negativeX: return (currentLocation.x - baseLocation.x, finalFrame.width)
            case .positiveY: return (baseLocation.y - currentLocation.y, finalFrame.height)
            case .negativeY: return (currentLocation.y - baseLocation.y, finalFrame.height)
            default: return .none
            }
        }() else { return self.pausedInterruptibleFractionComplete }
        let panRatio: CGFloat = value.diff / value.length
        let progress: CGFloat = pausedProgress + panRatio
        return progress.clamped(0.0, 1.0)
    }
}
