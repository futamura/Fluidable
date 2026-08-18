//
//  FluidBackgroundView.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import CoreImage
import Foundation
import UIKit

@MainActor public protocol FluidBackgroundCompatible: NSObjectProtocol {
    var visibility: CGFloat { get set }
}

extension FluidBackgroundCompatible where Self: UIView {
    func fitToSuperview() {
        if let view: UIView = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            self.topAnchor.constraint(equalTo: view.topAnchor).activate()
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor).activate()
            self.leftAnchor.constraint(equalTo: view.leftAnchor).activate()
            self.rightAnchor.constraint(equalTo: view.rightAnchor).activate()
        }
    }
}

internal class FluidBlurredBackgroundView: UIView, FluidBackgroundCompatible {
    nonisolated private static let ciContext = CIContext(options: nil)
    private static let blurQueue = DispatchQueue(label: "Fluidable.FluidBlurredBackgroundView.blur", qos: .userInitiated)

    private let blurView = UIImageView()
    private let tintView = UIView()
    private var snapshotSize: CGSize = .zero
    private var snapshotGeneration: Int = 0
    private var isSnapshotUpdatePending: Bool = false

    var baseBlurRadius: CGFloat = 0

    /** A percentage of visibility. */
    @objc internal dynamic var visibility: CGFloat = -1 {
        didSet {
            guard self.visibility != oldValue else { return }
            self.applyVisibility()
        }
    }

    /** Tint color. The default value is nil. */
    @objc dynamic internal var colorTint: UIColor? {
        didSet { self.tintView.backgroundColor = self.colorTint }
    }

    /** Tint color alpha. The default value is 0.0. */
    @objc dynamic open var colorTintAlpha: CGFloat = 0 {
        didSet { self.tintView.alpha = self.colorTintAlpha * self.visibility.clamped(0, 1) }
    }

    /** Blur radius. The default value is 0.0. */
    @objc dynamic open var blurRadius: CGFloat = 0

    /** Scale factor. */
    @objc dynamic open var scale: CGFloat = 1

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(radius: CGFloat, color: UIColor, alpha: CGFloat) {
        super.init(frame: .zero)
        self.clipsToBounds = true
        self.blurView.alpha = 0
        self.blurView.contentMode = .scaleToFill
        self.addSubview(self.blurView)
        self.tintView.alpha = 0
        self.addSubview(self.tintView)
        self.baseBlurRadius = radius
        self.blurRadius = 0
        self.colorTint = color
        self.tintView.backgroundColor = color
        self.colorTintAlpha = alpha
        self.visibility = 0
        self.isUserInteractionEnabled = false
        self.tag = FluidConst.backgroundViewTag
    }

    deinit { Logger()?.log("🥶🧹🧹🧹️", []) }

    override func didMoveToWindow() {
        super.didMoveToWindow()
        self.applyVisibility()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.blurView.frame = self.bounds
        self.tintView.frame = self.bounds
        if self.snapshotSize != self.bounds.size {
            self.invalidateSnapshot()
            self.applyVisibility()
        }
    }

    override func updateConstraints() {
        self.fitToSuperview()
        super.updateConstraints()
    }

    private func applyVisibility() {
        let clampedVisibility = self.visibility.clamped(0, 1)
        self.blurRadius = self.baseBlurRadius * clampedVisibility
        if self.blurView.image == nil {
            self.updateSnapshot()
        }
        self.blurView.alpha = clampedVisibility
        self.tintView.alpha = self.colorTintAlpha * clampedVisibility
    }

    private func updateSnapshot() {
        guard !self.isSnapshotUpdatePending else { return }
        guard self.bounds.width > 0, self.bounds.height > 0 else { return }
        guard let snapshot = self.makeBackgroundSnapshot() else { return }

        self.snapshotGeneration += 1
        let generation = self.snapshotGeneration
        let snapshotSize = self.bounds.size
        let blurRadius = self.baseBlurRadius
        self.isSnapshotUpdatePending = true

        Self.blurQueue.async { [weak self] in
            let blurredImage = Self.makeBlurredImage(from: snapshot, radius: blurRadius)
            let target = self
            DispatchQueue.main.async {
                MainActor.assumeIsolated {
                    guard let self = target else { return }
                    guard self.snapshotGeneration == generation else { return }
                    self.isSnapshotUpdatePending = false
                    guard self.bounds.size == snapshotSize else { return }
                    self.blurView.image = blurredImage
                    self.snapshotSize = snapshotSize
                }
            }
        }
    }

    private func invalidateSnapshot() {
        self.snapshotGeneration += 1
        self.isSnapshotUpdatePending = false
        self.blurView.image = nil
        self.snapshotSize = .zero
    }

    private func makeBackgroundSnapshot() -> UIImage? {
        guard let superview = self.superview,
              let backgroundIndex = superview.subviews.firstIndex(of: self) else { return nil }

        let previousSubviews = superview.subviews[..<backgroundIndex]
        let hasBackgroundContent = previousSubviews.contains { view in
            return !view.isHidden && view.alpha > 0 && view.bounds.width > 1 && view.bounds.height > 1
        }
        if hasBackgroundContent {
            return self.renderSnapshot(of: superview, hiding: Array(superview.subviews[backgroundIndex...]))
        }
        if let window = self.window, window !== superview {
            return self.renderSnapshot(of: window, hiding: [superview])
        }
        return self.renderSnapshot(of: superview, hiding: Array(superview.subviews[backgroundIndex...]))
    }

    private func renderSnapshot(of view: UIView, hiding hiddenSubviews: [UIView]) -> UIImage {
        let origin = self.convert(CGPoint.zero, to: view)
        let hiddenStates = hiddenSubviews.map { $0.isHidden }
        hiddenSubviews.forEach { $0.isHidden = true }
        defer {
            zip(hiddenSubviews, hiddenStates).forEach { view, isHidden in
                view.isHidden = isHidden
            }
        }

        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        format.opaque = false
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size, format: format)
        return renderer.image { context in
            context.cgContext.translateBy(x: -origin.x, y: -origin.y)
            view.layer.render(in: context.cgContext)
        }
    }

    nonisolated private static func makeBlurredImage(from image: UIImage, radius: CGFloat) -> UIImage {
        guard radius > 0,
              let inputImage = CIImage(image: image) else { return image }

        let clampedImage = inputImage.clampedToExtent()
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(clampedImage, forKey: kCIInputImageKey)
        filter?.setValue(radius * image.scale, forKey: kCIInputRadiusKey)

        guard let outputImage = filter?.outputImage?.cropped(to: inputImage.extent),
              let cgImage = ciContext.createCGImage(outputImage, from: inputImage.extent) else {
            return image
        }
        return UIImage(cgImage: cgImage, scale: image.scale, orientation: image.imageOrientation)
    }
}

internal class FluidDimmedBackgroundView: UIView, FluidBackgroundCompatible {
    @objc internal dynamic var visibility: CGFloat = -1 {
        didSet {
            guard self.visibility != oldValue else { return }
            self.alpha = self.visibility.clamped(0, 1)
        }
    }

    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    init(color: UIColor) {
        super.init(frame: .zero)
        self.backgroundColor = color
        self.alpha = 0
        self.isUserInteractionEnabled = false
        self.tag = FluidConst.backgroundViewTag
        self.visibility = 0
    }

    deinit { Logger()?.log("🥶🧹🧹🧹️", []) }

    override func updateConstraints() {
        self.fitToSuperview()
        super.updateConstraints()
    }
}
