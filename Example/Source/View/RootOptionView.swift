//
//  RootOptionView.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

class RootOptionView: UIView {
    @IBOutlet weak var containerView: UIView!

    required init?(coder aDecoder: NSCoder) { super.init(coder: aDecoder) }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.alpha = 0.0
        self.backgroundColor = .clear
        self.isHidden = true
        self.containerView.backgroundColor = .white
        self.containerView.layer.cornerRadius = ExampleConst.cornerRadius
        self.containerView.layer.shadowColor = UIColor.black.cgColor
        self.containerView.layer.shadowOpacity = 0.2
        self.containerView.layer.shadowRadius = ExampleConst.cornerRadius
    }

    override func layoutSubviews() {
        if let f: CGRect = self.superview?.frame {
            self.frame = f
            self.autoresizingMask = [AutoresizingMask.flexibleWidth, AutoresizingMask.flexibleHeight]
        }
        super.layoutSubviews()
    }
}

extension RootOptionView: UIGestureRecognizerDelegate {
}

extension RootOptionView {
    @objc func handleTap(sender: UITapGestureRecognizer? = nil) {
        hide()
    }

    func toggle() {
        switch self.isHidden {
        case true: self.show()
        case false: self.hide()
        }
    }

    func show() {
        guard self.isHidden else { return }
        self.containerView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        self.isHidden = false
        let transform: CGAffineTransform = .identity
        UIView.animate(withDuration: 0.2,
                       delay: 0.0,
                       options: .curveEaseOut,
                       animations: { [weak self] in
                           self?.alpha = 1.0
                           self?.containerView.transform = transform
                       })
    }

    func hide() {
        guard !self.isHidden else { return }
        let transform: CGAffineTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.alpha = 0.0
            self?.containerView.transform = transform
        }, completion: { [weak self] _ in
            self?.isHidden = true
        })
    }
}

extension RootOptionView {
    @IBAction func didTapBackground(_ sender: Any) {
        self.hide()
    }

    @IBAction func didChangeShadowValue(_ sender: UISegmentedControl) {
        Config.shared.isShadowEnabled = sender.selectedSegmentIndex == 0 ? true : false
    }

    @IBAction func didChangeTransitionValue(_ sender: UISegmentedControl) {
        Config.shared.transitionStyle = FluidTransitionStyle(index: sender.selectedSegmentIndex) ?? FluidTransitionStyle.fluid(behavior: .scale)
    }

    @IBAction func didChangeBackgroundValue(_ sender: UISegmentedControl) {
//        Config.shared.backgroundStyle = FluidBackgroundStyle(index: sender.selectedSegmentIndex) ?? .blur(radius: 8.0, color: .clear, alpha: 1.0)
    }
}
