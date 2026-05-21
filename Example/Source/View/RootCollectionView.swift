//
//  RootCollectionView.swift
//  Fluidable
//
//  Created by Kojiro Futamura on 2019/07/08.
//  Copyright © 2019 Gumob. All rights reserved.
//

import Foundation
import UIKit

class RootCollectionView: UICollectionView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        /* NOTE: Set accessibility */
        self.accessibilityIdentifier = "rootCollectionView"
    }
}