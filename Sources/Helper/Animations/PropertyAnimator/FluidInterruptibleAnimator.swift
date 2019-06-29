//
// Created by kojirof on 2019-03-06.
// Copyright (c) 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

/** UIViewPropertyAnimator for debugging */
internal class FluidInterruptibleAnimator: UIViewPropertyAnimator {
    let identifier: String

    typealias CompletionBlock = (UIViewAnimatingPosition, UIViewAnimatingStateEx) -> Void
    var completionBlock: CompletionBlock?

    init(duration: TimeInterval, timingParameters parameters: UITimingCurveProvider, id: String) {
        self.identifier = id
        super.init(duration: duration, timingParameters: parameters)
        /* FIXME: Convert progress with linear timing function */
        /* FIXME: The interactive transition glitches when the scrubsLinearly value set to true */
        if #available(iOS 11.0, *) { self.scrubsLinearly = false }
    }

    deinit { Logger()?.log("🚨🧹🧹🧹", ["id: " + String(describing: identifier)]) }
}

extension FluidInterruptibleAnimator {
    func addCompletion(_ completion: CompletionBlock?) {
        Logger()?.log("🚨🛠", [
            "identifier:".lpad() + String(describing: identifier),
            "completion:".lpad() + String(describing: completion),
        ])
        self.completionBlock = completion
        super.addCompletion({ [weak self] (position: UIViewAnimatingPosition) in
            self?.positionDidChange(position: position)
        })
    }

    override func startAnimation() {
        Logger()?.log("🚨⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete),
        ])
        super.startAnimation()
    }


    override func startAnimation(afterDelay delay: TimeInterval) {
        super.startAnimation(afterDelay: delay)
        Logger()?.log("🚨⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete),
        ])
    }

    override func pauseAnimation() {
        super.pauseAnimation()
        Logger()?.log("🚨⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete),
        ])
    }

    override func continueAnimation(withTimingParameters parameters: UITimingCurveProvider?, durationFactor: CGFloat) {
        super.continueAnimation(withTimingParameters: parameters, durationFactor: durationFactor)
        Logger()?.log("🚨⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete),
        ])
    }

    @available(iOS 10.0, *)
    override func finishAnimation(at finalPosition: UIViewAnimatingPosition) {
        super.finishAnimation(at: finalPosition)
        Logger()?.log("🚨⏩", [
            "identifier:".lpad() + String(describing: self.identifier),
            "fractionComplete:".lpad() + String(describing: self.fractionComplete),
        ])
    }

    func positionDidChange(position: UIViewAnimatingPosition) {
        Logger()?.log("🚨💥", [
            "identifier:".lpad() + String(describing: identifier),
            "position:".lpad() + String(describing: position),
            "stateEx:".lpad() + String(describing: self.stateEx),
        ])
        self.completionBlock?(position, self.stateEx)
    }

    func invalidate() {
        Logger()?.log("🚨🗑🗑🗑", [
            "id: " + String(describing: identifier),
        ])
        self.completionBlock = nil
    }
}
