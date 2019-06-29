//
//  FluidPropertyAnimator+Observing.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

internal extension FluidPropertyAnimator {
    func startTimer() {
        guard self.displayLink == nil else { return }
        self.displayLink = CADisplayLink(target: self, selector: #selector(updateTimer))
//        self.displayLink?.preferredFramesPerSecond = 60
        self.displayLink?.add(to: .current, forMode: .common)
    }

    @objc func updateTimer() {
        guard self.displayLink != nil else { return }
        self.progressDidUpdate()
    }

    func stopTimer() {
        guard self.displayLink != nil else { return }
        self.displayLink?.invalidate()
        self.displayLink = nil
    }
}

internal extension FluidPropertyAnimator {
    func progressDidUpdate() {
        guard self.animatorState != .finished else { return }
        self._currentFractionComplete = self.fractionComplete
//        Logger()?.log("🐅💥", [
//            "identifier: ".lpad() + String(describing: self.identifier),
//            "animatorProgress: ".lpad() + String(describing: self.animatorProgress.decimal()),
//            "fractionComplete: ".lpad() + String(describing: self.fractionComplete.decimal()),
//        ])
    }

    func positionDidChange(position: UIViewAnimatingPosition) {
        Logger()?.log("🐅💥", [
            "identifier: ".lpad() + String(describing: self.identifier),
            "animatorProgress: ".lpad() + String(describing: self.animatorProgress.decimal()),
            "fractionComplete: ".lpad() + String(describing: self.fractionComplete.decimal()),
            "isRunning: ".lpad() + String(describing: self.isRunning),
            "isReversed: ".lpad() + String(describing: self.isReversed),
            "state: ".lpad() + String(describing: self.state),
            "stateEx: ".lpad() + String(describing: self.stateEx),
            "position: ".lpad() + String(describing: position),
        ])
        self.stopTimer()
        switch self.stateEx {
        case .inactive: break
        case .active:   break
        case .stopped:  break
        case .none:     self._animatorState = .finished
        }
    }
}
