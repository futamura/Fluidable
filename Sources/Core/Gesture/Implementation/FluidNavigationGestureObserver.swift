//
//  FluidNavigationGestureObserver.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal class FluidNavigationGestureObserver: NSObject, FluidGestureObservable {
    /** Type Aliases */
    typealias Parameters = FluidNavigationParameters
    typealias ControllerDelegate = FluidNavigationControllerDelegate
    typealias RootNavigationControllerDelegate = FluidNavigationRootNavigationControllerDelegate
    typealias SourceViewControllerDelegate = FluidNavigationSourceViewControllerDelegate
    typealias DestinationViewControllerDelegate = FluidNavigationDestinationViewControllerDelegate

    /** The `FluidNavigationParameters` object. */
    var parameters: Parameters!

    /** The `FluidGestureDelegate` object. */
    weak var gestureDelegate: FluidGestureDelegate?

    /** The base frame when the view is placed in the default position. */
    var baseFrame: CGRect = .zero
    /** The base location value at the start of gesture. */
    var initialLocation: CGPoint?
    /** The current location value of the gesture. */
    var currentLocation: CGPoint?
    /** The previous location value of the gesture. */
    var previousLocation: CGPoint?
    /** The average translation value of the gesture. */
    internal var averageLocation: CGPoint { return locationHistory.count >= self.maxTranslationCount ? locationHistory.average : .zero }
    /** The translation history of the gesture. */
    var locationHistory: [CGPoint] = [CGPoint]()
    /** The initial translation value of the gesture. */
    var initialTranslation: CGPoint?
    /** The current translation value of the gesture. */
    var currentTranslation: CGPoint?
    /** The previous translation value of the gesture. */
    var previousTranslation: CGPoint?
    /** The average translation value of the gesture. */
    internal var averageTranslation: CGPoint { return translationHistory.count >= self.maxTranslationCount ? translationHistory.average : .zero }
    /** The translation history of the gesture. */
    var translationHistory: [CGPoint] = [CGPoint]()
    /** The current velocity value of the gesture. */
    var currentVelocity: CGVector?

    /** The initial translation direction. */
    var currentTranslationDirection: FluidGestureDirection { return .init(point: self.currentTranslation) }
    /** The initial gesture direction. */
    var initialGestureDirection: FluidGestureDirection { return .init(point: self.initialTranslation) }
    /** The current gesture direction. */
    var currentGestureDirection: FluidGestureDirection {
        guard let previous: CGPoint = self.previousTranslation, let current: CGPoint = self.currentTranslation else { return .none }
        return .init(point: current - previous)
    }
    /** The average gesture direction. */
//    internal var averageGestureDirection: FluidGestureDirection { return .init(point: self.averageTranslation) }
    var averageGestureDirection: FluidGestureDirection {
        let translations: [CGPoint] = self.translationHistory
                .enumerated()
                .map { (i: Int, current: CGPoint) in
                    guard let previous: CGPoint = self.translationHistory[safe: i - 1] else { return nil }
                    return previous - current
                }
                .filter { $0 != nil }
                .map { $0! }
        let average: CGPoint = translations.average
        return .init(point: average)
    }
    /** The current gesture state. */
    var gestureState: UIGestureRecognizer.State? = .none

    /** Tap gesture */
    weak var tapGestureView: UIView?
    var tapGestureRecognizer: UITapGestureRecognizer?
    /** Pan gesture */
    weak var panGestureView: UIView?
    var panGestureRecognizer: UIGestureRecognizer!
    /** Edge pan gesture */
    weak var edgePanGestureView: UIView?
    var edgePanGestureRecognizer: UIScreenEdgePanGestureRecognizer?

    required init(delegate: FluidGestureDelegate) {
        super.init()
        self.gestureDelegate = delegate
        Logger()?.log("👋🛠", [
            "delegate:".lpad() + String(debug: delegate)
        ])
    }

    deinit { Logger()?.log("👋🧹🧹🧹", []) }
}

extension FluidNavigationGestureObserver {
    func startObserving() {
        self.baseFrame = self.finalDimension.frame()
        /* NOTE: Start observing tap gesture */
//        if self.tapGestureRecognizer == nil {
//            self.tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandler))
//            self.tapGestureRecognizer?.cancelsTouchesInView = false
//            self.tapGestureRecognizer?.delegate = self
//            self.tapGestureView = self.containerView
//            self.tapGestureView?.addGestureRecognizer(self.tapGestureRecognizer!)
//            self.tapGestureRecognizer?.isEnabled = self.shouldDismissWhenTapBackground
//        }
        /* NOTE: Start observing pan gesture */
//        if self.panGestureRecognizer == nil {
//            self.panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandler))
//            self.panGestureRecognizer.cancelsTouchesInView = false
//            self.panGestureRecognizer.delegate = self
//            self.panGestureView = self.animationView
//            self.panGestureView?.addGestureRecognizer(self.panGestureRecognizer)
//        }
        /* NOTE: Start observing edge pan gesture */
//        if self.edgePanGestureRecognizer == nil && !self.presentationStyle.isDrawer && self.driverType.isDismiss {
//            self.edgePanGestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(edgePanGestureHandler))
//            self.edgePanGestureRecognizer?.edges = self.interactionType.edges
//            self.edgePanGestureRecognizer?.cancelsTouchesInView = false
//            self.edgePanGestureRecognizer?.delegate = self
//            self.edgePanGestureView = self.animationView
//            self.edgePanGestureView?.addGestureRecognizer(self.edgePanGestureRecognizer!)
//        }
        Logger()?.log("👋🛠", [
            "allowDismissWhenTapBackground: " + String(debug: self.allowDismissWhenTapBackground),
            "tapGestureView: " + String(debug: self.tapGestureView),
            "panGestureView: " + String(debug: self.panGestureView),
            "edgePanGestureView: " + String(debug: self.edgePanGestureView),
        ])
    }

    func stopObserving() {
        Logger()?.log("👋🗑🗑🗑", [])
        /* NOTE: Stop observing tap gesture */
        if let recognizer: UIGestureRecognizer = self.tapGestureRecognizer {
            self.tapGestureRecognizer?.removeTarget(self, action: #selector(tapGestureHandler))
            self.tapGestureView?.removeGestureRecognizer(recognizer)
        }
        self.tapGestureRecognizer = nil
        self.tapGestureView = nil
        /* NOTE: Stop observing pan gesture */
        if let recognizer: UIGestureRecognizer = self.panGestureRecognizer {
            self.panGestureRecognizer.removeTarget(self, action: #selector(panGestureHandler))
            self.panGestureView?.removeGestureRecognizer(recognizer)
        }
        self.panGestureRecognizer = nil
        self.panGestureView = nil
        /* NOTE: Stop observing edge pan gesture */
        if let recognizer: UIGestureRecognizer = self.edgePanGestureRecognizer {
            self.edgePanGestureRecognizer?.removeTarget(self, action: #selector(edgePanGestureHandler))
            self.edgePanGestureView?.removeGestureRecognizer(recognizer)
        }
        self.edgePanGestureRecognizer = nil
        self.edgePanGestureView = nil
        /* NOTE: Reset parameters */
        self.resetParameters()
    }
}

extension FluidNavigationGestureObserver {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return self.handleGestureRecognizer(gestureRecognizer, shouldReceive: touch)
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.handleGestureRecognizerShouldBegin(gestureRecognizer)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.handleGestureRecognizer(gestureRecognizer, shouldRequireFailureOf: otherGestureRecognizer)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.handleGestureRecognizer(gestureRecognizer, shouldBeRequiredToFailBy: otherGestureRecognizer)
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.handleGestureRecognizer(gestureRecognizer, shouldRecognizeSimultaneouslyWith: otherGestureRecognizer)
    }
}

extension FluidNavigationGestureObserver {
    @objc func tapGestureHandler(gesture: UITapGestureRecognizer) {
        self.handleTapGesture(gesture: gesture)
    }

    /** The function that handles a pan gesture.  */
    @objc func panGestureHandler(gesture: UIPanGestureRecognizer) {
        self.handlePanGesture(gesture: gesture)
    }

    /** The function that handles an edge pan gesture. */
    @objc func edgePanGestureHandler(gesture: UIScreenEdgePanGestureRecognizer) {
        self.handleEdgePanGesture(gesture: gesture)
    }
}
