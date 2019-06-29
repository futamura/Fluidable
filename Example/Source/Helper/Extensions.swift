//
//  Helpers.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit
import Fluidable

extension UIImage {
    enum ImageSize {
        case small, medium, large
        var label: String {
            switch self {
            case .small:  return "256"
            case .medium: return "512"
            case .large:  return "original"
            }
        }
    }

    convenience init?(row: Int, size: ImageSize) {
        let odd: Int = Int(CGFloat(row).truncatingRemainder(dividingBy: CGFloat(22)))
        self.init(named: "image-\(odd)-\(size.label)")
    }
}

extension UIView {
    func toImage() -> UIImage {
        return UIImage(view: self)
    }
}

extension UIImage {
    convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage)!)
    }
}

extension UINib {
    static func instantiate<T>(nibName: String, bundle: Bundle? = nil, owner: Any? = nil, options: [UINib.OptionsKey: Any]? = nil) -> T {
        return UINib(nibName: nibName, bundle: bundle).instantiate(withOwner: owner, options: options).first as! T
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        let className: String = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellReuseIdentifier: className)
    }

    func register<T: UITableViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func dequeueReusableCell<T: UITableViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: type.className, for: indexPath) as! T
    }
}

extension UICollectionView {
    enum ElementKind {
        case header
        case footer
        case none

        func toString() -> String {
            switch self {
            case .header: return UICollectionView.elementKindSectionHeader
            case .footer: return UICollectionView.elementKindSectionHeader
            case .none:   return "none"
            }
        }

        init(from str: String) {
            switch str {
            case UICollectionView.elementKindSectionHeader: self = .header
            case UICollectionView.elementKindSectionHeader: self = .footer
            default: self = .none
            }
        }
    }

    func register<T: UICollectionViewCell>(cellType: T.Type) {
        let className: String = cellType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register<T: UICollectionViewCell>(cellTypes: [T.Type]) {
        cellTypes.forEach { register(cellType: $0) }
    }

    func register<T: UICollectionReusableView>(reusableViewType: T.Type, of kind: ElementKind = .header) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: nil)
        register(nib, forSupplementaryViewOfKind: kind.toString(), withReuseIdentifier: className)
    }

    func register<T: UICollectionReusableView>(reusableViewTypes: [T.Type], kind: ElementKind = .header) {
        reusableViewTypes.forEach { register(reusableViewType: $0, of: kind) }
    }

    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as! T
    }

    func dequeueReusableView<T: UICollectionReusableView>(with type: T.Type, for indexPath: IndexPath, of kind: ElementKind = .header) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind.toString(), withReuseIdentifier: type.className, for: indexPath) as! T
    }
}

extension UIScrollView {
    /** The `UIEdgeInsets` value indicating a effective content offset depending on the `contentInsetAdjustmentBehavior`. */
    var effectiveContentInset: UIEdgeInsets {
        if #available(iOS 11, *) { return self.adjustedContentInset } else { return self.contentInset }
    }
}

extension NSLayoutConstraint {
    @discardableResult
    func activate() -> Self {
        self.isActive = true
        return self
    }

    @discardableResult
    func deactivate() -> Self {
        self.isActive = false
        return self
    }

    @discardableResult
    func toggle() -> Self {
        self.isActive.toggle()
        return self
    }
}

extension UIDevice {
    var isPhone: Bool { return UIDevice.current.userInterfaceIdiom == .phone }
    var isPad: Bool { return UIDevice.current.userInterfaceIdiom == .pad }
}

extension Comparable {
    func clamped(_ lower: ClosedRange<Self>.Bound, _ upper: ClosedRange<Self>.Bound) -> Self {
        return self < lower ? lower : (upper < self ? upper : self)
    }

    func clamped(to range: ClosedRange<Self>) -> Self {
        return self.clamped(range.lowerBound, range.upperBound)
    }

    mutating func clamp(_ lower: ClosedRange<Self>.Bound, _ upper: ClosedRange<Self>.Bound) {
        self = self.clamped(lower, upper)
    }

    mutating func clamp(to range: ClosedRange<Self>) {
        self = self.clamped(range.lowerBound, range.upperBound)
    }
}
