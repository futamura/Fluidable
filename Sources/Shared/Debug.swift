//
//  Debug.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation

internal protocol Debuggable {
    var debug: String { get }
}

/**
 Debugger
 */
internal extension String {
    func lpad(_ length: Int = 34) -> String {
        return self.padding(toLength: length, withPad: " ", startingAt: 0)
    }

    enum TruncationPosition {
        case head
        case middle
        case tail
    }

    func truncated(_ limit: Int, position: TruncationPosition = .tail, leader: String = "...") -> String {
        guard self.count > limit else { return self }

        switch position {
        case .head:
            return leader + self.suffix(limit)
        case .middle:
            let headCharactersCount = Int(ceil(Float(limit - leader.count) / 2.0))

            let tailCharactersCount = Int(floor(Float(limit - leader.count) / 2.0))

            return "\(self.prefix(headCharactersCount))\(leader)\(self.suffix(tailCharactersCount))"
        case .tail:
            return self.prefix(limit) + leader
        }
    }
}

private func extractFileName(_ file: String) -> String {
    let str: NSString = (file as NSString)
    return str.lastPathComponent.replacingOccurrences(of: ".\(str.pathExtension)", with: "")
}

internal class Logger {
    enum Level {
        case none, simple, info, verbose
    }

    init?() {
        let isFramework: Bool = {
            guard let schemeName: String = Bundle.main.infoDictionary?["CFBundleName"] as? String else { return false }
            return schemeName.starts(with: "Fluidable")
        }()
        if !isFramework { return nil }
    }

    static func format(name: String, prop: Any?) -> String {
        guard let prop: Any = prop else {
            return "\(name):".lpad() + "nil"
        }
        return "\(name):".lpad() + String(describing: prop)
    }

    func log(_ emoji: String? = nil, _ messages: [String]? = nil, _ appendLineBreak: Bool = true, _ shouldPrint: Bool = true,
             _ function: String = #function, _ file: String = #file, _ line: Int = #line) {
        guard shouldPrint else { return }
        let emoji: String = emoji ?? ""
        /* File info */
        let file: String = extractFileName(file)
        let line: String = String(format: "%03d", arguments: [line])
//        let fileInfo: String = "\(file):\(line):\(function)".truncated(86, position: .head)
        let fileInfo: String = "\(file):\(line):\(function)"
        /* Head */
        let head: String = "\(emoji) [\(fileInfo)] "
        /* Line break */
        let br: String = "\n"
        /* Generate message */
        var out: String = ""
        if let messages: [String] = messages {
            messages.forEach {
                if $0.isEmpty {
                    out += br
                } else {
                    out += head + $0 + br
                }
            }
        }
        if out.isEmpty {
            out += head + br
        }
        if !appendLineBreak {
            out = String(out.dropLast())
        }
        print(out)
    }
}

func printf(_ name: String, _ value: Any?, pad: Int = 48, icon: String = "ℹ️") {
    var str: String
    switch value {
    case is Bool:
        str = (value as? Bool ?? false) ? "🔵 true" : "🔴 false"
    default:
        str = String(describing: value ?? "nil")
    }
    print("    \(icon) \(name):".lpad(pad) + str)
}
