//
//  FluidTransitionCompatible+Configuration.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

extension FluidDriverCompatible {
    func configureParameters(driverType: FluidDriverType,
                             animationType: FluidAnimationType,
                             context: UIViewControllerContextTransitioning?,
                             container: UIView, source: UIViewController?, destination: UIViewController?,
                             initialContainerSize: CGSize? = nil, finalContainerSize: CGSize? = nil,
                             duration: TimeInterval? = nil, easing: FluidAnimatorEasing? = nil,
                             shouldInsertSubview: Bool = true) throws {
        Logger()?.log("🐮🛠", [
//            "driverType:".lpad() + String(debug: driverType),
//            "animationType:".lpad() + String(debug: animationType),
//            "container:".lpad() + String(debug: container),
//            "source:".lpad() + String(debug: source),
//            "destination:".lpad() + String(debug: destination),
//            "initialContainerSize:".lpad() + String(debug: initialContainerSize),
//            "finalContainerSize:".lpad() + String(debug: finalContainerSize),
//            "duration:".lpad() + String(debug: duration),
//            "easing:".lpad() + String(debug: easing),
        ])
        self.parameters = .init(driverType: driverType, animationType: animationType,
                                context: context, container: container, source: source, destination: destination,
                                initialContainerSize: initialContainerSize, finalContainerSize: finalContainerSize,
                                duration: duration, easing: easing)
        self.parameters.configureViews(shouldInsertSubview: shouldInsertSubview)
        /* NOTE: Register parameters */
        self.registerParameters(parameters: self.parameters)
        Logger()?.log("🐮🛠", ["\n" + String(debug: self.parameters), ])
        /* NOTE: Validate */
        do {
            try self.parameters.validateParameters()
            switch driverType {
            case .present:
                try self.parameters.validatePresentEasing()
                try self.parameters.validatePresentDuration()
            case .dismiss:
                try self.parameters.validateDismissEasing()
                try self.parameters.validateDismissDuration()
            }
        } catch let error as FluidError {
            error.printMessage()
            throw error
        } catch {
            print("[Fluidable]", "Unknown Error:", error.localizedDescription, "\n")
        }
    }

    @discardableResult
    func registerParameters<T: FluidParametersCompatible>(parameters: T) -> Self {
        Logger()?.log("🐮🛠", [
        ])
        if self.observingGesture == nil { self.observingGesture = .init(delegate: self) }
        if self.observingScrolls == nil { self.observingScrolls = [ScrollObserver]() }
        self.parameters = parameters as? Parameters
        self.observingGesture?.registerParameters(parameters: parameters)
        self.observingScrolls?.forEach { $0.registerParameters(parameters: parameters) }
        self.viewAnimator.registerParameters(parameters: self.parameters)
        return self
    }

    func dispose() {
        defer { Logger()?.log("🐮🗑🗑🗑", []) }
        self.viewAnimator = nil
        self.interruptibleAnimator = nil
        self.parameters = nil
        self.observingGesture = nil
        self.observingScrolls = nil
        self.mostTopObservingScroll = nil
        AssociatedObject.remove(self)
    }
}
