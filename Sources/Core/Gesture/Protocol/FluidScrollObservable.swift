//
//  FluidScrollObservable.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

protocol FluidScrollObservable: FluidParametersAccessible, UIGestureRecognizerDelegate {
    /** The reference to `UIScrollView` to be observed its content offset. */
    var scrollView: UIScrollView? { get set }

    /** An `NSKeyValueObservation` object. */
    var offsetObservation: NSKeyValueObservation! { get set }
    /** An `UIPanGestureRecognizer` object. */
    var panGestureRecognizer: UIPanGestureRecognizer! { get set }
    /** The current gesture direction. */
    var gestureDirection: FluidGestureDirection { get set }
    /** The current gesture state. */
    var gestureState: UIGestureRecognizer.State? { get set }

    /** The `Bool` value that indicates whether the scroll view is at the most top. */
    var isMostTop: Bool { get set }

    /** The `Bool` value that indicates whether the scroll indicator is disabled. */
    var isScrollIndicatorDisabled: Bool { get set }
    /** The `FluidTransitionInteractionState` value. */
    var interactionState: FluidDriverInteractionState { get set }
    /** The `Bool` value that indicates whether the view is transitioning. */
    var isTransitioning: Bool { get set }

    /** The `Boolean` value that stores a default `UIScrollView.contentOffset` value. */
    var lockedContentOffset: CGPoint? { get set }
    /** The `Boolean` value that stores default interaction state. */
    var defaultIsUserInteractionEnabled: Bool { get set }
    /** The `Boolean` value that stores default isScrollEnabled value. */
    var defaultIsScrollEnabled: Bool { get set }
    /** The `Boolean` value that stores default scroll indicators state. */
    var defaultShowsVerticalScrollIndicator: Bool { get set }
    var defaultShowsHorizontalScrollIndicator: Bool { get set }

    /** The function that start observing gestures. */
    func startObserving()
    /** The function that stop observing gestures. */
    func stopObserving()

    /** Instantiate ScrollViewObserver */
    init(view: UIScrollView)
}

/**
 Content offset
 */
extension FluidScrollObservable {
    /**
     The function that locks the content offset.
     */
    func contentOffsetDidChange(oldValue: CGPoint) {
        guard let sv: UIScrollView = self.scrollView, self.allowInteractiveDismiss else { return }
//        Logger()?.log("↕️🚩", [
//            "description:\n" + String(describing: self)
//        ])
        guard self.isTransitioning else { return }
        guard let lockedOffset: CGPoint = self.lockedContentOffset else { return }
        guard let targetOffset: CGPoint = {
            switch self.presentationStyle {
            case .fluid where self.isTransitioning || oldValue.y < sv.minScrollableY,
                 .scale where self.isTransitioning || oldValue.y < sv.minScrollableY:
                return CGPoint(x: lockedOffset.x, y: sv.minScrollableY)
            case .slide(let direction):
                switch direction {
                case .fromTop    where self.isTransitioning || oldValue.y > sv.maxScrollableY:
//                    return CGPoint(x: lockedOffset.x, y: sv.maxScrollableY)
                    return lockedOffset
                case .fromBottom where self.isTransitioning || oldValue.y < sv.minScrollableY:
//                    return CGPoint(x: lockedOffset.x, y: sv.minScrollableY)
                    return lockedOffset
                case .fromLeft   where self.isTransitioning || oldValue.x > sv.maxScrollableX:
//                    return CGPoint(x: sv.maxScrollableX, y: lockedOffset.y)
                    return lockedOffset
                case .fromRight  where self.isTransitioning || oldValue.x < sv.minScrollableX:
//                    return CGPoint(x: sv.minScrollableX, y: lockedOffset.y)
                    return lockedOffset
                default: return nil
                }
            case .drawer(let drawerPosition):
                switch drawerPosition {
                case .top    where self.isTransitioning || oldValue.y > sv.maxScrollableY:
//                    return CGPoint(x: lockedOffset.x, y: sv.maxScrollableY)
                    return lockedOffset
                case .bottom where self.isTransitioning || oldValue.y < sv.minScrollableY:
//                    return CGPoint(x: lockedOffset.x, y: sv.minScrollableY)
                    return lockedOffset
                case .left   where self.isTransitioning || oldValue.x > sv.maxScrollableX:
//                    return CGPoint(x: sv.maxScrollableX, y: lockedOffset.y)
                    return lockedOffset
                case .right  where self.isTransitioning || oldValue.x < sv.minScrollableX:
//                    return CGPoint(x: sv.minScrollableX, y: lockedOffset.y)
                    return lockedOffset
                default: return nil
                }
            default: return nil
            }
        }() else { return }
        sv.setContentOffset(targetOffset, animated: false)
    }
}

/**
 Condition
 */
extension FluidScrollObservable {
    /**
     The function that indicates whether the scroll view allows to begin dismiss transition.

     - returns: The `Boolean` value
     */
    func isDismissAllowed() -> Bool {
        guard let sv: UIScrollView = self.scrollView else { return true }
        /* NOTE: Is scrolling not activated */
        if !sv.isTracking || !sv.isScrollEnabled { return true }
//        Logger()?.log("↕️🚩", [
//            "transitionStyle:".lpad(48) + String(describing: self.transitionStyle),
//            "isApproxBottom:".lpad(48) + String(describing: self.gestureDirection.isApproxBottom),
//            "isApproxLeft:".lpad(48) + String(describing: self.gestureDirection.isApproxLeft),
//            "sv.contentOffset.y:".lpad(48) + String(describing: sv.contentOffset.y),
//            "sv.minScrollableY:".lpad(48) + String(describing: sv.minScrollableY),
//        ])
        /* NOTE: Is the content offset is valid to resize */
        switch self.presentationStyle {
        case .fluid where self.gestureDirection.isApproxBottom,
             .scale where self.gestureDirection.isApproxBottom: return sv.contentOffset.y <= sv.minScrollableY
        case .fluid where self.gestureDirection.isNarrowLeft,
             .scale where self.gestureDirection.isNarrowLeft:   return sv.contentOffset.y <= sv.minScrollableY && sv.contentOffset.x <= sv.minScrollableX
        case .slide(let direction):
            switch direction {
            case .fromTop    where self.gestureDirection.isApproxTop:    return sv.contentOffset.y >= sv.maxScrollableY
            case .fromBottom where self.gestureDirection.isApproxBottom: return sv.contentOffset.y <= sv.minScrollableY
            case .fromLeft   where self.gestureDirection.isApproxLeft:   return sv.contentOffset.x >= sv.maxScrollableX
            case .fromRight  where self.gestureDirection.isApproxRight:  return sv.contentOffset.x <= sv.minScrollableX
            default: return false
            }
        case .drawer(let position):
            switch position {
            case .top    where self.gestureDirection.isApproxTop:    return sv.contentOffset.y >= sv.maxScrollableY
            case .bottom where self.gestureDirection.isApproxBottom: return sv.contentOffset.y <= sv.minScrollableY
            case .left   where self.gestureDirection.isApproxLeft:   return sv.contentOffset.x >= sv.maxScrollableX
            case .right  where self.gestureDirection.isApproxRight:  return sv.contentOffset.x <= sv.minScrollableX
            default: return false
            }
        default:
            return false
        }
    }

    /**
     The function that indicates whether the scroll view allows to begin resize interaction.

     - returns: The `Boolean` value
     */
    func isResizeAllowed() -> Bool {
        guard let sv: UIScrollView = self.scrollView,
              let drawerPosition: FluidDrawerPosition = self.presentationStyle.drawerPosition else { return false }
        guard drawerPosition.isBottom else { return false } /* IMPORTANT: The resizing interaction is available for only the bottom drawer on the current version */
        /* NOTE: Is scrolling not activated */
        if !sv.isTracking || !sv.isScrollEnabled { return true }
        /* NOTE: Is the content size greater than or equal to its frame size */
//        if (drawerPosition.isVertical && sv.frame.height >= sv.contentSize.height) ||
//           (drawerPosition.isHorizontal && sv.frame.width >= sv.contentSize.width) { return false }
        /* NOTE: Is the content offset valid to resize */
        switch drawerPosition {
        case .top:    return sv.maxScrollableY <= sv.contentOffset.y || sv.frame.height >= sv.contentSize.height
        case .bottom: return sv.contentOffset.y <= sv.minScrollableY || sv.frame.height >= sv.contentSize.height
        case .left:   return sv.maxScrollableX <= sv.contentOffset.x || sv.frame.width >= sv.contentSize.width
        case .right:  return sv.contentOffset.x <= sv.minScrollableX || sv.frame.width >= sv.contentSize.width
//        default: return false
        }
    }
}

/**
 Scroll lock
 */
extension FluidScrollObservable {
    func updateScroll(progress: CGFloat, position: CGFloat, state: FluidDriverInteractionState) {
//        Logger()?.log("↕️🎬", [
//            "progress:".lpad() + String(describing: progress),
//            "position:".lpad() + String(describing: position),
//            "state:".lpad() + String(describing: state),
//            "interactionState:".lpad() + String(describing: self.interactionState),
//        ])
        if self.interactionState != state {
            self.interactionState = state
            if state != .none {
                self.lockScroll()
            } else {
                self.unlockScroll()
            }
        }
    }

    func lockScroll() {
        Logger()?.log("↕️🎬", [])
        guard let sv: UIScrollView = self.scrollView else { return }
        self.isTransitioning = true
        self.defaultIsUserInteractionEnabled = sv.isUserInteractionEnabled
        if !self.presentationStyle.isDrawer { sv.isUserInteractionEnabled = false }
        self.lockedContentOffset = sv.contentOffset
        /* NOTE: Disable scroll indicator */
        guard !self.isScrollIndicatorDisabled else { return }
        self.defaultShowsVerticalScrollIndicator = sv.showsVerticalScrollIndicator
        self.defaultShowsHorizontalScrollIndicator = sv.showsHorizontalScrollIndicator
        sv.showsVerticalScrollIndicator = false
        sv.showsHorizontalScrollIndicator = false
        self.isScrollIndicatorDisabled = true
    }

    func unlockScroll() {
        Logger()?.log("↕️🎬", [])
        guard let sv: UIScrollView = self.scrollView else { return }
        self.isTransitioning = false
        if !self.presentationStyle.isDrawer { sv.isUserInteractionEnabled = self.defaultIsUserInteractionEnabled }
        self.lockedContentOffset = nil
        /* NOTE: Enable scroll indicator */
        guard self.isScrollIndicatorDisabled else { return }
        sv.showsVerticalScrollIndicator = defaultShowsVerticalScrollIndicator
        sv.showsHorizontalScrollIndicator = defaultShowsHorizontalScrollIndicator
        self.isScrollIndicatorDisabled = false
    }

    func abortScroll() {
        Logger()?.log("↕️🎬", [])
        let defaultIsScrollEnabled: Bool = self.scrollView?.isScrollEnabled ?? false
        self.scrollView?.isScrollEnabled = false
        self.scrollView?.isScrollEnabled = defaultIsScrollEnabled
    }

    func disableInteraction() {
        Logger()?.log("↕️🎬", [])
        guard let sv: UIScrollView = self.scrollView else { return }
        self.defaultIsUserInteractionEnabled = sv.isUserInteractionEnabled
        self.defaultIsScrollEnabled = sv.isScrollEnabled
        sv.isUserInteractionEnabled = false
        sv.isScrollEnabled = false
    }

    func enableInteraction() {
        Logger()?.log("↕️🎬", [])
        guard let sv: UIScrollView = self.scrollView else { return }
        sv.isUserInteractionEnabled = self.defaultIsUserInteractionEnabled
        sv.isScrollEnabled = self.defaultIsScrollEnabled
    }
}

extension FluidScrollObservable {
    func handlePanGesture(gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .possible, .began, .changed:
            self.gestureState = gesture.state
            self.gestureDirection = .init(point: gesture.translation(in: self.containerView))
        case .ended, .failed, .cancelled:
            self.gestureDirection = .none
            self.gestureState = .none
        }
    }
}
