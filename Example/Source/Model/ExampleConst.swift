//
//  ExampleConst.swift
//  Fluidable
//
//  Created by kojirof on 2019/06/29.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

struct ExampleConst {
    /* Collection View */
    static let collectionTopMargin: CGFloat = 16
    static let collectionLeftMargin: CGFloat = 16
    static let collectionRightMargin: CGFloat = 16
    static let collectionBottomMargin: CGFloat = 16
    static let collectionCellPadding: CGFloat = 12
    static var collectionNumberOfColumns: Int {
        let size: CGSize = UIApplication.shared.keyWindow?.bounds.size ?? CGSize(width: 6, height: 4)
        let isLandscape: Bool = size.width > size.height
        switch isLandscape {
        case true:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad: return 3
            default: return 2
            }
        case false:
            switch UIDevice.current.userInterfaceIdiom {
            case .pad: return 2
            default: return 1
            }
        }
    }

    /* Cell */
    static let cornerRadius: CGFloat = 12
    static let shadowRadius: CGFloat = 18
    static let shadowOpacity: CGFloat = 0.1
    static let shadowOffset: CGSize = .init(width: 0, height: 10)

    /* Cell (Debug) */
//    static let cornerRadius: CGFloat = 12
//    static let shadowRadius: CGFloat = 0
//    static let shadowOpacity: CGFloat = 0.5
//    static let shadowOffset: CGSize = .init(width: 10, height: 20)

    static let headerHeight: CGFloat = 92 + 14
    static let tableCellHeight: CGFloat = 64
}
