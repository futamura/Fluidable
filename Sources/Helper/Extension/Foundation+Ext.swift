//
// Created by kojirof on 2019-03-07.
// Copyright (c) 2019 Gumob. All rights reserved.
//

import Foundation

internal extension String {
    init<Subject>(debug instance: Subject?) {
        if instance == nil {
            self = "nil"
        } else {
            self = String(describing: instance!) + " (Optional)"
        }
    }
}

extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Array where Element: FloatingPoint {
    func nearest(to value: Element) -> (index: Int, element: Element)? {
        var nearestIndex: Int?
        var nearestElement: Element?
        var nearestDist: Element = Element.infinity
        for (index, element): (Int, Element) in self.enumerated() {
            let dist: Element = abs(element - value)
            if dist < nearestDist {
                nearestDist = dist
                nearestIndex = index
                nearestElement = element
            }
        }
        guard let index: Int = nearestIndex, let element: Element = nearestElement else { return nil }
        return (index: index, element: element)
    }
}

protocol Coordinates {
    var x: CGFloat { get }
    var y: CGFloat { get }
}

extension CGPoint: Coordinates {
}

extension CGVector: Coordinates {
    var x: CGFloat { return self.dx }
    var y: CGFloat { return self.dy }
}

extension Array where Element: Coordinates {
    func nearest(to point: Element) -> (index: Int, element: Element)? {
        var nearestIndex: Int?
        var nearestElement: Element?
        var nearestDist: CGFloat = .infinity
        for (index, element): (Int, Element) in self.enumerated() {
            let distance: CGFloat = (element as! CGPoint).distance(to: point as! CGPoint)
            if distance < nearestDist {
                nearestDist = distance
                nearestIndex = index
                nearestElement = element
            }
        }
        guard let index: Int = nearestIndex, let element: Element = nearestElement else { return nil }
        return (index: index, element: element)
    }
}

extension Collection where Element: Numeric {
    /** Returns the total sum of all elements in the array */
    var sum: Element { return reduce(0, +) }
}

extension Collection where Element: BinaryInteger {
    /** Returns the average of all elements in the array */
    var average: Double { return isEmpty ? 0 : Double(sum) / Double(count) }
}

extension Collection where Element: BinaryFloatingPoint {
    /** Returns the average of all elements in the array */
    var average: Element { return isEmpty ? 0 : sum / Element(count) }
}

extension Collection where Element == CGPoint {
    /** Returns the total sum of all elements in the array */
    var sum: Element { return reduce(.zero, +) }
    /** Returns the average of all elements in the array */
    var average: Element { return isEmpty ? .zero : sum / CGFloat(count) }
}
