//
//  FluidPresenterTimer.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal class FluidViewAnimatorTimer {
    var displayLink: CADisplayLink?
    var callbackBlock: (() -> Void)?

    func start(_ callback: @escaping (() -> Void)) {
        self.callbackBlock = callback
        guard self.displayLink == nil else { return }
        self.displayLink = CADisplayLink(target: self, selector: #selector(update))
//        self.displayLink?.preferredFramesPerSecond = 60
        self.displayLink?.add(to: .current, forMode: .common)
    }

    @objc func update() {
        guard self.displayLink != nil else { return }
        self.callbackBlock?()
    }

    func stop() {
        guard self.displayLink != nil else { return }
        self.displayLink?.invalidate()
        self.displayLink = nil
        self.callbackBlock = nil
    }
}
