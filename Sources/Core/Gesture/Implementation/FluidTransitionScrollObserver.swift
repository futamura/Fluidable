//
//  FluidTransitionScrollObserver.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** An `UIScrollView` observer to be monitored its touching state. */
internal class FluidTransitionScrollObserver: NSObject, FluidScrollObservable {
    /** Type Aliases */
    typealias Parameters = FluidTransitionParameters
    typealias ControllerDelegate = FluidViewControllerTransitioningDelegate
    typealias RootNavigationControllerDelegate = FluidTransitionRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidTransitionSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidTransitionDestinationViewControllerDelegate

    /** The `FluidTransitionParameters` object. */
    var parameters: Parameters!

    /** The reference to `UIScrollView` to be observed its content offset. */
    weak var scrollView: UIScrollView?

    /** An `NSKeyValueObservation` object. */
    var offsetObservation: NSKeyValueObservation!
    /** An `UIPanGestureRecognizer` object. */
    var panGestureRecognizer: UIPanGestureRecognizer!
    /** The current gesture direction. */
    var gestureDirection: FluidGestureDirection = .none
    /** The current gesture state. */
    var gestureState: UIGestureRecognizer.State? = .none

    /** The `Bool` value that indicates whether the scroll view is at the most top. */
    var isMostTop: Bool = false

    /** The `Bool` value that indicates whether the scroll indicator is disabled. */
    var isScrollIndicatorDisabled: Bool = false
    /** The `FluidTransitionInteractionState` value. */
    var interactionState: FluidDriverInteractionState = .none
    /** The `Bool` value that indicates whether the view is transitioning. */
    var isTransitioning: Bool = false

    /** The `Boolean` value that stores a default `UIScrollView.contentOffset` value. */
    var lockedContentOffset: CGPoint? = nil
    /** The `Boolean` value that stores default interaction state. */
    var defaultIsUserInteractionEnabled: Bool = true
    /** The `Boolean` value that stores default isScrollEnabled value. */
    var defaultIsScrollEnabled: Bool = true
    /** The `Boolean` value that stores default scroll indicators state. */
    var defaultShowsVerticalScrollIndicator: Bool = true
    var defaultShowsHorizontalScrollIndicator: Bool = true

    /** Instantiate ScrollViewObserver */
    required init(view: UIScrollView) {
        super.init()
        self.scrollView = view
    }

    deinit { Logger()?.log("↕️🧹🧹🧹", []) }
}

/**
 Observing
 */
extension FluidTransitionScrollObserver {
    func startObserving() {
        guard let sv: UIScrollView = self.scrollView else { return }
        Logger()?.log("↕️🛠", [])
        if self.panGestureRecognizer == nil {
            self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
            self.panGestureRecognizer.cancelsTouchesInView = false
            self.panGestureRecognizer.delegate = self
            sv.addGestureRecognizer(self.panGestureRecognizer)
        }
        if self.offsetObservation == nil {
            self.offsetObservation = sv.observe(\.contentOffset, options: [.old]) { [weak self] (scrollView, change) in
                guard let oldValue: CGPoint = change.oldValue else { return }
                self?.contentOffsetDidChange(oldValue: oldValue)
            }
        }
    }

    func stopObserving() {
        Logger()?.log("↕️🗑🗑🗑", [], true, self.panGestureRecognizer != nil)
        if let recognizer: UIGestureRecognizer = self.panGestureRecognizer { self.scrollView?.removeGestureRecognizer(recognizer) }
        self.panGestureRecognizer = nil
        self.offsetObservation?.invalidate()
        self.offsetObservation = nil
    }
}

/**
 Gesture
 */
extension FluidTransitionScrollObserver {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool { return true }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool { return gestureRecognizer.view === self.scrollView }
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool { return true }
    @objc func panGestureHandler(gesture: UIPanGestureRecognizer) { self.handlePanGesture(gesture: gesture) }
}

/**
 Debugging
 */
extension FluidTransitionScrollObserver {
    override public var description: String {
        guard let sv: UIScrollView = self.scrollView else { return super.description }
        return """
               FluidScrollObservable(
               - \("isTransitioning".lpad(36)): \(String(debug: self.isTransitioning))
               - \("isDragging".lpad(36)): \(String(debug: sv.isDragging))
               - \("isTracking".lpad(36)): \(String(debug: sv.isTracking))
               - \("effectiveContentInset".lpad(36)): \(String(debug: sv.effectiveContentInset))
               - \("normalizedContentOffset".lpad(36)): \(String(debug: sv.normalizedContentOffset))
               - \("bounds".lpad(36)): \(String(debug: sv.bounds))
               - \("contentInset".lpad(36)): \(String(debug: sv.contentInset))
               - \("contentSize".lpad(36)): \(String(debug: sv.contentSize))
               - \("contentOffset".lpad(36)): \(String(debug: sv.contentOffset))
               - \("minScrollableX".lpad(36)): \(String(debug: sv.minScrollableX))
               - \("minScrollableY".lpad(36)): \(String(debug: sv.minScrollableY))
               - \("maxScrollableX".lpad(36)): \(String(debug: sv.maxScrollableX))
               - \("maxScrollableY".lpad(36)): \(String(debug: sv.maxScrollableY))
               - \("layoutContainerView.frame".lpad(36)): \(String(debug: self.layoutContainerView.frame))
               - \("destinationViewController.view.frame".lpad(36)): \(String(debug: self.destinationViewController.view.frame))
               )
               """
    }
}
